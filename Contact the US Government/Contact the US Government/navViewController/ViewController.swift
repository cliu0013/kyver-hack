//
//  ViewController.swift
//  Proposal
//
//  Created by Chengji Liu on 11/10/18.
//  Copyright © 2018 Cornell AppDev. All rights reserved.
//

import UIKit
protocol StateDelegateI: class {
    func stateChanged(newState: String)
}
class ViewController: UIViewController, UICollectionViewDelegate,  UICollectionViewDataSource{
    
    var Senate: UIButton!
    var Representative: UIButton!
    var madeBy: UILabel!
    let gloryRed = UIColor(red:1.00, green:0.37, blue:0.33, alpha:1.0)
    let gloryBlue = UIColor(red:0.21, green:0.51, blue:0.72, alpha:1.0)
    let padding: CGFloat = 30
    let filterReuseIdentifier: String = "FilterCollectionViewCell"
    var states : [String] = []
    var districts : [String] = []
    
    var filtersArray: [Filter] = []
    var activePartyTypeFilter: Set<String> = []
    
    
    var filterView: UICollectionView!
    var confirmationButton: UIButton!
    var statesButton: UIButton!
    var initialSenatorFilter: Bool = false
    var initialRepresentativeFilter: Bool = false
    var state: String = ""
    weak var delegate: StateDelegate?
    var preferencesLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = .white
        navigationItem.title = "Kyver"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = gloryRed
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.largeTitleTextAttributes = textAttributes
        edgesForExtendedLayout = [] // gets rid of views going under navigation controller
        
        //setupNavBarItems()
        
        Senate = UIButton()
        Senate.layer.cornerRadius = 20
        Senate.clipsToBounds = true
        Senate.setBackgroundImage(UIImage(named: "Possible app icon"), for: .normal)
        Senate.translatesAutoresizingMaskIntoConstraints = false
        Senate.setTitle("Senate", for: .normal)
        Senate.setTitleColor(.black, for: .normal)
        Senate.contentHorizontalAlignment = .center
        Senate.contentVerticalAlignment = .bottom
        Senate.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 10.0, right: 0.0)
        Senate.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 25)
        Senate.addTarget(self, action: #selector(pushSenateNavViewController), for: .touchUpInside)
        view.addSubview(Senate)
        
        Representative = UIButton()
        Representative.layer.cornerRadius = 20
        Representative.clipsToBounds = true
        Representative.setBackgroundImage(UIImage(named: "Red Bird"), for: .normal)
        Representative.translatesAutoresizingMaskIntoConstraints = false
        Representative.setTitle("Representative", for: .normal)
        Representative.setTitleColor(.black, for: .normal)
        Representative.contentHorizontalAlignment = .center
        Representative.contentVerticalAlignment = .bottom
        Representative.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 10.0, right: 0.0)
        Representative.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 25)
        Representative.addTarget(self, action: #selector(pushRepresentativeNavViewController), for: .touchUpInside)
        view.addSubview(Representative)
        
        madeBy = UILabel()
        madeBy.translatesAutoresizingMaskIntoConstraints = false
        madeBy.text = "Made By\nRyan Richardson, Chengji Liu, Jack Ding, Ryan Tremblay\nWith help from Jaewon Sim and Young Kim\n© 2018 Cornell AppDev"
        madeBy.font = UIFont(name: ".SFUIText-Medium", size: 10)
        madeBy.textAlignment = .center
        madeBy.textColor = .darkGray
        madeBy.numberOfLines = 6
        view.addSubview(madeBy)
        
        filtersArray.append(contentsOf: PartyType.allValues().map({ f in f as Filter }))
        
        filterView = UICollectionView(frame: .zero, collectionViewLayout: FilterCollectionViewFlowLayout())
        filterView.translatesAutoresizingMaskIntoConstraints = false
        filterView.delegate = self
        filterView.dataSource = self
        filterView.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: filterReuseIdentifier)
        filterView.showsHorizontalScrollIndicator = false
        filterView.backgroundColor = .white
        filterView.allowsMultipleSelection = true //this is how we select multiple cells at once
        view.addSubview(filterView)
        
        statesButton = UIButton()
        statesButton.translatesAutoresizingMaskIntoConstraints = false
        statesButton.backgroundColor = .white
        statesButton.setTitle("Choose State", for: .normal)
        statesButton.addTarget(self, action: #selector(presentStatesPopupModalViewController), for: .touchUpInside)
        statesButton.contentHorizontalAlignment = .center
        statesButton.titleLabel?.font =  .systemFont(ofSize: 15)
        statesButton.layer.cornerRadius = 5
        statesButton.layer.borderColor = UIColor(named: "black")?.cgColor
        statesButton.layer.borderWidth = 0.5
        statesButton.setTitleColor(.darkGray, for: .normal)
        view.addSubview(statesButton)
        
        preferencesLabel = UILabel()
        preferencesLabel.translatesAutoresizingMaskIntoConstraints = false
        preferencesLabel.text = "Choose Preferences"
        preferencesLabel.font = UIFont(name: ".SFUIText-Medium", size: 20)
        preferencesLabel.textColor = .black
        preferencesLabel.textAlignment = .center
        view.addSubview(preferencesLabel)
        
        
        setupConstraints()
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            Senate.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            Senate.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            Senate.widthAnchor.constraint(equalToConstant: 300-padding),
            Senate.heightAnchor.constraint(equalToConstant: 225-padding)
            ])
        
        NSLayoutConstraint.activate([

            Representative.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            Representative.topAnchor.constraint(equalTo: Senate.bottomAnchor, constant: padding),
            Representative.widthAnchor.constraint(equalToConstant: 300-padding),
            Representative.heightAnchor.constraint(equalToConstant: 225-padding)
            ])
        NSLayoutConstraint.activate([
            madeBy.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            madeBy.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
            ])
        NSLayoutConstraint.activate([
            preferencesLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            preferencesLabel.topAnchor.constraint(equalTo: Representative.bottomAnchor, constant: padding/2)
            ])
        NSLayoutConstraint.activate([
            filterView.heightAnchor.constraint(equalToConstant: 50),
            filterView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            filterView.topAnchor.constraint(equalTo: preferencesLabel.bottomAnchor, constant: 10),
            filterView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ])
        
        NSLayoutConstraint.activate([
            statesButton.heightAnchor.constraint(equalToConstant: 30),
            statesButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding*3),
            statesButton.topAnchor.constraint(equalTo:  filterView.bottomAnchor, constant: 10),
            statesButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding*3),
            ])

    
    }
    
    
    @objc func pushSenateNavViewController(){
        let navViewController = SenateNavViewController()
        navViewController.activePartyTypeFilterPreference = activePartyTypeFilter
        navViewController.initialFilter = initialSenatorFilter
        navViewController.state = state
        navigationController?.pushViewController(navViewController, animated: true)
    }
    @objc func pushRepresentativeNavViewController(){
        let navViewController = RepresentativeNavViewController()
        navViewController.activePartyTypeFilterPreference = activePartyTypeFilter
        navViewController.initialFilter = initialRepresentativeFilter
        navViewController.state = state
        navigationController?.pushViewController(navViewController, animated: true)
    }
    
    @objc func presentStatesPopupModalViewController(){
        let modalViewController = StatesPopopModalViewController()
        //modalViewController.modalPresentationStyle = .custom
        //modalViewController.transitioningDelegate = self
        modalViewController.modalTransitionStyle = .crossDissolve
        modalViewController.delegate = self as! StateDelegateI
        present(modalViewController, animated: true, completion: nil)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filtersArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: filterReuseIdentifier, for: indexPath) as? FilterCollectionViewCell else { return UICollectionViewCell() }
        let filter = filtersArray[indexPath.item]
        cell.setup(with: filter.filterTitle)
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: filterReuseIdentifier, for: indexPath) as? FilterCollectionViewCell else { return }
        let currentFilter = filtersArray[indexPath.item]
        changeFilter(filter: currentFilter, shouldRemove: false)
        //       Code fo
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: filterReuseIdentifier, for: indexPath) as? FilterCollectionViewCell else { return }
        let currentFilter = filtersArray[indexPath.item]
        changeFilter(filter: currentFilter, shouldRemove: true)
        //        displayDelegatesCollectionView.reloadData()
    }
    
    func changeFilter(filter: Filter, shouldRemove: Bool = false) {
        if let partyType = filter as? String {
            if shouldRemove {
                activePartyTypeFilter.remove(partyType)
            } else {
                activePartyTypeFilter.insert(partyType)
            }
        }
        filterRepresentativesInitially()
        filterSenatorsInitially()
    }
    
    func filterSenatorsInitially() {
        if activePartyTypeFilter.count == 0{
            initialSenatorFilter = false
            return
        }else {
            initialSenatorFilter = true
            return
        }
    }
    
    
    func filterRepresentativesInitially(){
        if activePartyTypeFilter.count == 0{
            initialRepresentativeFilter = false
            return
        }else {
            initialRepresentativeFilter = true
            return
        }
    }
    
    //    func setupNavBarItems(){
    //        let filterButton = UIButton(type: .system)
    //        filterButton.setTitle("Made By", for: .normal)
    //        filterButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
    //        filterButton.tintColor = .white
    //        //filterButton.addTarget(self, action: #selector(presentMadeByModalViewController), for: .touchUpInside)
    //
    //        navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: filterButton) ]
    //    }
    
    //    @objc func presentMadeByModalViewController(){
    //        //let modalViewController = MadeByModalViewController()
    //        modalViewController.modalPresentationStyle = .custom
    //        modalViewController.transitioningDelegate = self
    //        present(modalViewController, animated: true, completion: nil)
    //
    //    }
    
}
//extension ViewController : UIViewControllerTransitioningDelegate {
//    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
//        return HalfSizePresentationController(presentedViewController: presented, presenting: presenting)
//    }
//}

extension ViewController: StateDelegateI{
    func stateChanged(newState: String) {
        statesButton.setTitle(newState, for: .normal)
        NetworkManager.state = NetworkManager.usa[newState] ?? "az"
        state = newState
        print(statesButton.titleLabel)
    }
}


