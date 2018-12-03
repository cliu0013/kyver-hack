//
//  LegislativeNavViewController.swift
//  Contact the US Government
//
//  Created by Chengji Liu on 11/26/18.
//  Copyright © 2018 Cornell AppDev. All rights reserved.
//

import UIKit

protocol RepStateDelegate: class {
    func stateChanged(newState: String)
    func districtChanged(newDistrict: String)
    func filterRepresentatives(activePartyTypeFilter: Set<String>)
}
protocol RepDismissDelegate: class {
    func undim()
}
class RepresentativeNavViewController: UITableViewController{
    
    let padding: CGFloat = 30
    let buttonHeight: CGFloat = 45
    let imageHeight: CGFloat = 160
    let cellHeight: CGFloat = 90
    
    let contentFont = UIFont(name: ".SFUIText-Medium", size: 20)
    let headerFont = UIFont(name: "HelveticaNeue-Bold", size: 25)
    let gloryRed = UIColor(red:1.00, green:0.37, blue:0.33, alpha:1.0)
    let gloryBlue = UIColor(red:0.21, green:0.51, blue:0.72, alpha:1.0)
    let blurEffect = UIBlurEffect(style: .dark)
    
    
    let RepCellId = "RepCellId"
    
    var representatives = [Representative]()
    var blurEffectView : UIVisualEffectView!
    var searchBar: UISearchBar!
    let searchController = UISearchController(searchResultsController: nil)
    
    var activeRepresentatives : [Representative] = []
    var searchedRepresentatives = [Representative]()
    var initialFilter: Bool!
    var activePartyTypeFilterPreference: Set<String>!
    var state: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Representatives"
        //navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = gloryRed
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        edgesForExtendedLayout = [] // gets rid of views going under navigation controller
        setupNavBarItems()
        
        searchController.searchResultsUpdater = self
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RepresentativesTableViewCell.self, forCellReuseIdentifier: RepCellId)
        tableView.sectionHeaderHeight = 50
        
        
        getRepresentatives(state: "ny", roles: "legislatorLowerBody", YOUR_API_KEY: "AIzaSyCNrilf9OFSEvR3MZeO7-HeV5GGyjBcLic")
        
        
        if(initialFilter){
            filterRepresentativesInitially(activePartyTypeFilter: activePartyTypeFilterPreference)
        }
        
        if(state != ""){
            filterRepresentativesInitiallyByState(state: state)
        }
        
        
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        //always fill the view
        blurEffectView.frame = self.view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.isHidden = true
        view.addSubview(blurEffectView)
        
    }
    func getRepresentatives(state: String, roles: String, YOUR_API_KEY: String) {
        NetworkManager.getRepresentativesUrl(state: state)
        let length: Int = NetworkManager.representativesUrl.count - 1
        for i in 0...length {
            NetworkManager.getRepresentatives(i: i, roles: roles, YOUR_API_KEY: YOUR_API_KEY) { representative in
                print("TODO")
                self.representatives.append(representative[0])
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func filterRepresentativesInitially(activePartyTypeFilter: Set<String>){
        if activePartyTypeFilter.count == 0{
            activeRepresentatives = representatives
            return
        }
        activeRepresentatives = representatives.filter({ r in
            var partyTypeFilteredOut = activePartyTypeFilter.count > 0
            if activePartyTypeFilter.count > 0 {
                if activePartyTypeFilter.contains(r.party) {
                    partyTypeFilteredOut = false
                }
            }
            return !partyTypeFilteredOut
        })
        representatives = activeRepresentatives
    }
    
    func filterRepresentativesInitiallyByState(state: String){
        var newReps: [Representative] = []
        for representative in representatives{
            if (representative.address[0].state == state){
                newReps.append(representative)
            }
        }
        representatives = newReps
    }
    
    
    func setupNavBarItems(){
        let filterButton = UIButton(type: .system)
        filterButton.setTitle("Filter", for: .normal)
        filterButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        filterButton.tintColor = .white
        filterButton.addTarget(self, action: #selector(presentFilterModalViewController), for: .touchUpInside)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Representatives"
        navigationItem.searchController = searchController
        navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: filterButton) ]
    }
    
    @objc func handleSearch(){
        print("do something")
    }
    
    @objc func presentFilterModalViewController(){
        let modalViewController = FilterModalViewController()
        modalViewController.modalPresentationStyle = .custom
        modalViewController.transitioningDelegate = self
        modalViewController.repDismissDelegate = self
        modalViewController.repDelegate = self
        blurEffectView.isHidden = false
        present(modalViewController, animated: true, completion: nil)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering(){
            return searchedRepresentatives.count
        }
        return representatives.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RepCellId, for: indexPath) as! RepresentativesTableViewCell
        let representative: Representative
        if isFiltering(){
            representative = searchedRepresentatives[indexPath.row]
        } else {
            representative = representatives[indexPath.row]
        }
        cell.configure(for: representative)
        cell.setNeedsUpdateConstraints()
        cell.selectionStyle = .none
        cell.backgroundColor = .white
        cell.textLabel?.numberOfLines = 0
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let navViewController = RepresentativeViewController()
        navViewController.representative = representatives[indexPath.row]
        navigationController?.pushViewController(navViewController, animated: true)
    }
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        searchedRepresentatives = representatives.filter({( representative : Representative) -> Bool in
            return representative.name.lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
}
extension RepresentativeNavViewController : UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return HalfSizePresentationController(presentedViewController: presented, presenting: presenting)
    }
}
extension RepresentativeNavViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
extension RepresentativeNavViewController: RepStateDelegate{
    
    
    
    
    func stateChanged(newState: String) {
        //TODO Filter that state
        var newReps: [Representative] = []
        for representative in representatives{
            if (representative.address[0].state == newState){
                newReps.append(representative)
            }
        }
        representatives = newReps
        tableView.reloadData()
    }
    
    func districtChanged(newDistrict: String) {
        //        var newReps: [Representative] = []
        //        for representative in representatives{
        //            if (representative.district == newDistrict){
        //                newReps.append(representative)
        //            }
        //        }
        //        representatives = newReps
        //        tableView.reloadData()
    }
    
    func filterRepresentatives(activePartyTypeFilter: Set<String>) {
        if activePartyTypeFilter.count == 0{
            activeRepresentatives = representatives
            return
        }
        activeRepresentatives = representatives.filter({ r in
            var partyTypeFilteredOut = activePartyTypeFilter.count > 0
            if activePartyTypeFilter.count > 0 {
                if activePartyTypeFilter.contains(r.party) {
                    partyTypeFilteredOut = false
                }
            }
            return !partyTypeFilteredOut
        })
        representatives = activeRepresentatives
        tableView.reloadData()
    }
    
}

extension RepresentativeNavViewController: RepDismissDelegate{
    func undim() {
        blurEffectView.isHidden = true
    }
}


