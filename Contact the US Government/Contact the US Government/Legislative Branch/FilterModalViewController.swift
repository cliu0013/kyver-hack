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
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 1 {
            return states.count
        }
        else {
            return districts.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        done = true
        globalRow = row
        globalcomponent = component
    }
    
    func changeAttr(row: Int, component: Int, done: Bool){
        if (done == true && row != -1 && component != -1){
            if component == 1{
                let state = states[row]
                delegate?.stateChanged(newState: state)
                repDelegate?.stateChanged(newState: state)
            }
            else {
                let district = states[row]
                repDelegate?.districtChanged(newDistrict: district)
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 1{
            let state = states[row]
            return state
        }
        else {
            let district = districts[row]
            return district
        }
        
    }
    
    let padding: CGFloat = 50
    let gloryRed = UIColor(red:1.00, green:0.37, blue:0.33, alpha:1.0)
    let gloryBlue = UIColor(red:0.21, green:0.51, blue:0.72, alpha:1.0)
    let filterReuseIdentifier: String = "FilterCollectionViewCell"
    var pickerView: UIPickerView!
    var states : [String] = []
    var districts : [String] = []
    
    var filtersArray: [Filter] = []
    var activePartyTypeFilter: Set<String> = []

    
    
    var filterView: UICollectionView!
    var confirmationButton: UIButton!
    var dimView : UIView!
    weak var delegate: StateDelegate?
    weak var dismissDelegate: DismissDelegate?
    weak var repDismissDelegate: RepDismissDelegate?
    weak var repDelegate: RepStateDelegate?
    var done: Bool = false
    var globalRow: Int = -1
    var globalcomponent: Int = -1
    
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
        
        filterView = UICollectionView(frame: .zero, collectionViewLayout: FilterCollectionViewFlowLayout())
        filterView.translatesAutoresizingMaskIntoConstraints = false
        filterView.delegate = self
        filterView.dataSource = self
        filterView.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: filterReuseIdentifier)
        filterView.showsHorizontalScrollIndicator = false
        filterView.backgroundColor = UIColor(red:0.74, green:0.84, blue:0.92, alpha:1.0)
        filterView.allowsMultipleSelection = true //this is how we select multiple cells at once
        view.addSubview(filterView)
        

        
        dimView = UIView()
        dimView.translatesAutoresizingMaskIntoConstraints = false
        dimView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        dimView.isHidden = true
        view.addSubview(dimView)
        
        states = [
            "Alabama",
            "Alaska",
            "Arizona",
            "Arkansas",
            "California",
            "Colorado",
            "Connecticut",
            "Deleware",
            "Florida",
            "Georgia",
            "Hawaii",
            "Idaho",
            "Indiana",
            "Illinois",
            "Iowa",
            "Kansas",
            "Kentucky",
            "Louisiana",
            "Michigan",
            "Maryland",
            "Minnesota",
            "Missouri",
            "Montana",
            "Maine",
            "Massachusetts",
            "Mississippi",
            "New Hampshire",
            "New York",
            "New Jersey",
            "North Dakota",
            "Nebraska",
            "Nevada",
            "New Mexico",
            "North Carolina",
            "Oklahoma",
            "Oregon",
            "Ohio",
            "Pennsylvania",
            "Rhode Island",
            "South Dakota",
            "South Carolina",
            "Tennessee",
            "Texas",
            "West Virginia",
            "Wisconsin",
            "Wyoming",
            "Washington",
            "Utah",
            "Virginia",
            "Vermont"
        ]
        
        let first = "1st"
        let second = "2nd"
        let third = "3rd"
        
        districts = [first, second, third]
        
        
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
        changeAttr(row: globalRow, component: globalcomponent, done: done)
        dismiss(animated: true, completion: nil)
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
        repDelegate?.filterRepresentatives(activePartyTypeFilter: activePartyTypeFilter)
        delegate?.filterSenators(activePartyTypeFilter: activePartyTypeFilter)
    }
    
//    func filterSenators() {
//        if activePartyTypeFilter.count == 0{
//            activeSenators = senators
//            return
//        }
//        activeSenators = senators.filter({ s in
//            var partyTypeFilteredOut = activePartyTypeFilter.count > 0
//            if activePartyTypeFilter.count > 0 {
//                if activePartyTypeFilter.contains(s.convertToPartyType(party: s.party)) {
//                    partyTypeFilteredOut = false
//                }
//            }
//            return !partyTypeFilteredOut
//        })
//    }
//
//    func filterRepresentatives() {
//        if activePartyTypeFilter.count == 0{
//            activeRepresentatives = representatives
//            return
//        }
//        activeRepresentatives = representatives.filter({ r in
//            var partyTypeFilteredOut = activePartyTypeFilter.count > 0
//            if activePartyTypeFilter.count > 0 {
//                if activePartyTypeFilter.contains(r.convertToPartyType(party: r.party)) {
//                    partyTypeFilteredOut = false
//                }
//            }
//
//            //            var Type1FilteredOut = activeType1Filter.count > 0
//            //            if activeType1Filter.count > 0 {
//            //                for Type2 in r.type1 {
//            //                    if activeType1Filter.contains(Type1) {
//            //                        Type1FilteredOut = false
//            //                    }
//            //                }
//            //            }
//            return !partyTypeFilteredOut
//        })
//    }
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
