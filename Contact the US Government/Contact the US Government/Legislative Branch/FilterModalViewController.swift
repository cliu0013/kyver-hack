//
//  FilterModalViewController.swift
//  Contact the US Government
//
//  Created by Chengji Liu on 11/26/18.
//  Copyright © 2018 Cornell AppDev. All rights reserved.
//

import UIKit


class FilterModalViewController: UIViewController, UICollectionViewDelegate,  UICollectionViewDataSource, UIPickerViewDataSource, UIPickerViewDelegate{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return states.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("Pressed")
        let state = states[row]
        delegate?.stateChanged(newState: state)
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let state = states[row]
        return state
    }
    
    let padding: CGFloat = 50
    let gloryBlue = UIColor.init(red: 0, green: 33.0/255, blue: 71.0/255, alpha: 1.0)
    let gloryRed = UIColor.init(red: 187.0/255, green: 19.0/255, blue: 62.0/255, alpha: 1.0)
    let filterReuseIdentifier: String = "FilterCollectionViewCell"
    var pickerView: UIPickerView!
    var states : [String] = []
    
    var filtersArray: [Filter] = []
    var activePartyTypeFilter: Set<PartyType> = []
    var activeType1Filter: Set<Type1> = []
    var activeSenators : [Senator] = []
    var activeRepresentatives : [Representative] = []
    var senators : [Senator] = []
    var representatives : [Representative] = []
    
    var filterView: UICollectionView!
    var confirmationButton: UIButton!
    var statesButton: UIButton!
    var dimView : UIView!
    weak var delegate: StateDelegate?
    weak var dismissDelegate: DismissDelegate?
    weak var repDismissDelegate: RepDismissDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = gloryRed
        edgesForExtendedLayout = [] // gets rid of views going under navigation controller
        
        //        senators = LegislativeNavViewController.senators
        //        activeSenators = senators
        //        representatives = LegislativeNavViewController.representatives
        //        activeRepresentatives = representatives
        
        
        
        confirmationButton = UIButton()
        confirmationButton.translatesAutoresizingMaskIntoConstraints = false
        confirmationButton.setBackgroundImage(UIImage(named: "confirmationButtonImage"), for: .normal)
        confirmationButton.addTarget(self, action: #selector(dismissFilterModalViewControllerAndSaveOptions), for: .touchUpInside)
        view.addSubview(confirmationButton)
        
        filtersArray.append(contentsOf: PartyType.allValues().map({ f in f as Filter }))
        filtersArray.append(contentsOf: Type1.allValues().map({ f in f as Filter }))
        
        filterView = UICollectionView(frame: .zero, collectionViewLayout: FilterCollectionViewFlowLayout())
        filterView.translatesAutoresizingMaskIntoConstraints = false
        filterView.delegate = self
        filterView.dataSource = self
        filterView.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: filterReuseIdentifier)
        filterView.showsHorizontalScrollIndicator = false
        filterView.backgroundColor = gloryBlue
        filterView.allowsMultipleSelection = true //this is how we select multiple cells at once
        view.addSubview(filterView)
        
//        statesButton = UIButton()
//        statesButton.translatesAutoresizingMaskIntoConstraints = false
//        statesButton.backgroundColor = .white
//        statesButton.setTitle("Choose State", for: .normal)
//        statesButton.addTarget(self, action: #selector(presentStatesPopupModalViewController), for: .touchUpInside)
//        statesButton.contentHorizontalAlignment = .center
//        statesButton.titleLabel?.font =  .systemFont(ofSize: 15)
//        statesButton.layer.cornerRadius = 5
//        statesButton.setTitleColor(.darkGray, for: .normal)
        //view.addSubview(statesButton)
        
        dimView = UIView()
        dimView.translatesAutoresizingMaskIntoConstraints = false
        dimView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        dimView.isHidden = true
        view.addSubview(dimView)
        
        let Alabama = "Alabama"
        let Alaska = "Alaska"
        let Arizona = "Arkansas"
        let California = "California"
        let Colorado = "Colorado"
        
        states = [Alabama, Alaska, Arizona, California, Colorado]
        
        pickerView = UIPickerView(frame: .zero)
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.delegate = self
        pickerView.dataSource = self
//        pickerView.layer.cornerRadius = 10
//        pickerView.layer.masksToBounds = true


        view.addSubview(pickerView)
        
        setupConstraints()
        
        // Do any additional setup after loading the view.
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            confirmationButton.widthAnchor.constraint(equalToConstant: 50),
            confirmationButton.heightAnchor.constraint(equalToConstant: 50),
            confirmationButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 1),
            confirmationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        
        NSLayoutConstraint.activate([
            filterView.heightAnchor.constraint(equalToConstant: 50),
            filterView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            filterView.topAnchor.constraint(equalTo: confirmationButton.bottomAnchor, constant: 2),
            filterView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ])
//        NSLayoutConstraint.activate([
//            statesButton.heightAnchor.constraint(equalToConstant: 30),
//            statesButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
//            statesButton.topAnchor.constraint(equalTo:  confirmationButton.bottomAnchor, constant: 1),
//            statesButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: padding * -1),
//            ])
        NSLayoutConstraint.activate([
            //pickerView.center.constraint(equalTo: view.leadingAnchor, constant: view.bounds.width/6),
            pickerView.topAnchor.constraint(equalTo: filterView.bottomAnchor, constant: 1),
            pickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
    }
    
    @objc func dismissFilterModalViewControllerAndSaveOptions(){
        dismissDelegate?.undim()
        repDismissDelegate?.undim()
        print("should dim 4head")
        dismiss(animated: true, completion: nil)
    }
    
//    @objc func presentStatesPopupModalViewController(){
//        let modalViewController = StatesPopopModalViewController()
//        //modalViewController.modalPresentationStyle = .custom
//        //modalViewController.transitioningDelegate = self
//        modalViewController.modalTransitionStyle = .crossDissolve
//        modalViewController.delegate = self as! StateDelegate
//        present(modalViewController, animated: true, completion: nil)
//    }
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
        if let partyType = filter as? PartyType {
            if shouldRemove {
                activePartyTypeFilter.remove(partyType)
            } else {
                activePartyTypeFilter.insert(partyType)
            }
        }
        if let type1 = filter as? Type1 {
            if shouldRemove {
                activeType1Filter.remove(type1)
            } else {
                activeType1Filter.insert(type1)
            }
        }
        
        filterSenators()
        filterRepresentatives()
    }
    
    func filterSenators() {
        if activePartyTypeFilter.count == 0 && activeType1Filter.count == 0{
            activeSenators = senators
            return
        }
        activeSenators = senators.filter({ s in
            var partyTypeFilteredOut = activePartyTypeFilter.count > 0
            if activePartyTypeFilter.count > 0 {
                if activePartyTypeFilter.contains(s.convertToPartyType(party: s.party)) {
                    partyTypeFilteredOut = false
                }
            }
            
            //            var Type1FilteredOut = activeType1Filter.count > 0
            //            if activeType1Filter.count > 0 {
            //                for Type2 in r.type1 {
            //                    if activeType1Filter.contains(Type1) {
            //                        Type1FilteredOut = false
            //                    }
            //                }
            //            }
            return !partyTypeFilteredOut
        })
    }
    
    func filterRepresentatives() {
        if activePartyTypeFilter.count == 0 && activeType1Filter.count == 0{
            activeRepresentatives = representatives
            return
        }
        activeRepresentatives = representatives.filter({ r in
            var partyTypeFilteredOut = activePartyTypeFilter.count > 0
            if activePartyTypeFilter.count > 0 {
                if activePartyTypeFilter.contains(r.convertToPartyType(party: r.party)) {
                    partyTypeFilteredOut = false
                }
            }
            
            //            var Type1FilteredOut = activeType1Filter.count > 0
            //            if activeType1Filter.count > 0 {
            //                for Type2 in r.type1 {
            //                    if activeType1Filter.contains(Type1) {
            //                        Type1FilteredOut = false
            //                    }
            //                }
            //            }
            return !partyTypeFilteredOut
        })
    }
}


extension FilterModalViewController : UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return PopupPresentationController(presentedViewController: presented, presenting: presenting)
    }
}

class PopupPresentationController : UIPresentationController {
    override var frameOfPresentedViewInContainerView: CGRect {
        get {
            guard let theView = containerView else {
                return CGRect.zero
            }
            let viewBoundaries = CGRect(x: theView.bounds.width/6, y: theView.bounds.height/5, width: (2*theView.bounds.width)/3, height: (1*theView.bounds.height)/2)
            //viewBoundaries.
            
            return viewBoundaries
            //            return CGRect(x: 0, y: theView.bounds.height/2, width: theView.bounds.width, height: theView.bounds.height/2)
        }
    }
}
