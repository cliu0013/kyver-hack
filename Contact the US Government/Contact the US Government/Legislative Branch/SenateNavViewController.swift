//
//  LegislativeNavViewController.swift
//  Contact the US Government
//
//  Created by Chengji Liu on 11/26/18.
//  Copyright © 2018 Cornell AppDev. All rights reserved.
//

import UIKit

class SenateNavViewController: UITableViewController{
    
    let padding: CGFloat = 30
    let buttonHeight: CGFloat = 45
    let imageHeight: CGFloat = 160
    let cellHeight: CGFloat = 90
    
    let contentFont = UIFont(name: ".SFUIText-Medium", size: 20)
    let headerFont = UIFont(name: "HelveticaNeue-Bold", size: 25)
    let gloryBlue = UIColor.init(red: 0, green: 33.0/255, blue: 71.0/255, alpha: 1.0)
    let gloryRed = UIColor.init(red: 187.0/255, green: 19.0/255, blue: 62.0/255, alpha: 1.0)
    let blurEffect = UIBlurEffect(style: .dark)
    
    
    let SenCellId = "SenCellId"
    //var representatives: [Representative]!
    var senators: [Senator]!
    var blurEffectView : UIVisualEffectView!
    var searchBar: UISearchBar!
    let searchController = UISearchController(searchResultsController: nil)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Senators"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = gloryRed
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        edgesForExtendedLayout = [] // gets rid of views going under navigation controller
        // create the search bar programatically since you won't be
        // able to drag one onto the navigation bar
        
        setupNavBarItems()
        
        definesPresentationContext = true
        
        
        tableView.delegate = self
        tableView.dataSource = self
        //tableView.register(RepresentativesTableViewCell.self, forCellReuseIdentifier: RepCellId)
        tableView.register(SenatorsTableViewCell.self, forCellReuseIdentifier: SenCellId)
        tableView.sectionHeaderHeight = 50
        
        let alexander = Senator(state: "Tennessee", _class: "class I", name: "Alexander, Lamar", party: "Republican", officeRoom: " 455 Dirksen Senate Office Building Washington DC 20510", phone: "2022244944", website: "www.alexander.senate.gov/public/index.cfm?p=Email", email:"")
        
        //let zeldin = Representative(state: "New York", name: "Zeldin, Lee", party: "Republican", district: " 1st", officeRoom: "1517 LHOB", phone: "2022253626", website: "https://zeldin.house.gov", email:"")
        
        //representatives = [zeldin, zeldin, zeldin, zeldin, zeldin]
        senators = [alexander, alexander, alexander, alexander, alexander]
        
        
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        //always fill the view
        blurEffectView.frame = self.view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.isHidden = true
        view.addSubview(blurEffectView) //if you have more UIViews, use an insertSubview API to place it where needed
    }
    
    
    func setupNavBarItems(){
        let filterButton = UIButton(type: .system)
        filterButton.setTitle("Filter", for: .normal)
        filterButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        filterButton.tintColor = .white
        filterButton.addTarget(self, action: #selector(presentFilterModalViewController), for: .touchUpInside)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Senators"
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
        present(modalViewController, animated: true, completion: nil)
        blurEffectView.isHidden = false
    }
    
    //    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    //        if section == 0 {
    //            let label = UILabel()
    //            label.text = "  Senators"
    //            label.font = headerFont
    //            label.textColor = .white
    //            label.backgroundColor = gloryBlue
    //            return label
    //        } else {
    //            let label = UILabel()
    //            label.text = "  Representative"
    //            label.font = headerFont
    //            label.textColor = .white
    //            label.backgroundColor = gloryBlue
    //            return label
    //        }
    //    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //if indexPath.section == 0 {
        let cell = tableView.dequeueReusableCell(withIdentifier: SenCellId, for: indexPath) as! SenatorsTableViewCell
        let senator = senators[indexPath.row]
        cell.configure(for: senator)
        cell.setNeedsUpdateConstraints()
        cell.selectionStyle = .none
        cell.backgroundColor = .white
        cell.textLabel?.numberOfLines = 0
        
        
        return cell
        //        } else{
        //            let cell = tableView.dequeueReusableCell(withIdentifier: RepCellId, for: indexPath) as! RepresentativesTableViewCell
        //            let representative = representatives[indexPath.row]
        //            cell.configure(for: representative)
        //            cell.setNeedsUpdateConstraints()
        //            cell.selectionStyle = .none
        //            cell.backgroundColor = .white
        //            cell.textLabel?.numberOfLines = 0
        //
        //            return cell
        //        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //if indexPath.section == 0{
        let navViewController = SenateViewController()
        navViewController.senator = senators[indexPath.row]
        navigationController?.pushViewController(navViewController, animated: true)
        //        } else {
        //            let navViewController = RepresentativeViewController()
        //            navViewController.representative = representatives[indexPath.row]
        //            navigationController?.pushViewController(navViewController, animated: true)
        //        }
    }
    
    func reloadTable(){
        tableView.reloadData()
    }
    
    
}
extension SenateNavViewController : UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return HalfSizePresentationController(presentedViewController: presented, presenting: presenting)
    }
}
extension SenateNavViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        // TODO
    }
}

//class HalfSizePresentationController : UIPresentationController {
//
//    override var frameOfPresentedViewInContainerView: CGRect {
//        get {
//            guard let theView = containerView else {
//                return CGRect.zero
//            }
//            return CGRect(x: 0, y: theView.bounds.height - theView.bounds.height/6, width: theView.bounds.width, height: theView.bounds.height/6)
//            //            return CGRect(x: 0, y: theView.bounds.height/2, width: theView.bounds.width, height: theView.bounds.height/2)
//        }
//    }


//}

