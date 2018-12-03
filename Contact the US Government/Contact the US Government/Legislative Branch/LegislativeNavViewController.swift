//
//  LegislativeNavViewController.swift
//  Contact the US Government
//
//  Created by Chengji Liu on 11/26/18.
//  Copyright © 2018 Cornell AppDev. All rights reserved.
//

import UIKit

class LegislativeNavViewController: UITableViewController{
    
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
    let SenCellId = "SenCellId"
    var representatives: [Representative] = []
    var senators: [Senator] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Legislative Branch"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = gloryRed
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        edgesForExtendedLayout = [] // gets rid of views going under navigation controller
        
        setupNavBarItems()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RepresentativesTableViewCell.self, forCellReuseIdentifier: RepCellId)
        tableView.register(SenatorsTableViewCell.self, forCellReuseIdentifier: SenCellId)
        tableView.sectionHeaderHeight = 50
        
//        getSenators(roles: "legislatorUpperBody", YOUR_API_KEY: "AIzaSyCNrilf9OFSEvR3MZeO7-HeV5GGyjBcLic")
//        getRepresentatives(state: "ny", roles: "legislatorLowerBody", YOUR_API_KEY: "AIzaSyCNrilf9OFSEvR3MZeO7-HeV5GGyjBcLic")
    }
    
    func getSenators(roles: String, YOUR_API_KEY: String) {
        NetworkManager.getSenators(state: NetworkManager.state, roles: roles, YOUR_API_KEY: YOUR_API_KEY) { senatorsArray in
            print("TODO")
            self.senators = senatorsArray
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
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
    
    
    func setupNavBarItems(){
        let filterButton = UIButton(type: .system)
        filterButton.setTitle("Filter", for: .normal)
        filterButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        filterButton.tintColor = .white
        filterButton.addTarget(self, action: #selector(presentFilterModalViewController), for: .touchUpInside)
        
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
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let label = UILabel()
            label.text = "  Senators"
            label.font = headerFont
            label.textColor = .white
            label.backgroundColor = gloryBlue
            return label
        } else {
            let label = UILabel()
            label.text = "  Representative"
            label.font = headerFont
            label.textColor = .white
            label.backgroundColor = gloryBlue
            return label
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: SenCellId, for: indexPath) as! SenatorsTableViewCell
            let senator = senators[indexPath.row]
            cell.configure(for: senator)
            cell.setNeedsUpdateConstraints()
            cell.selectionStyle = .none
            cell.backgroundColor = .white
            cell.textLabel?.numberOfLines = 0
            
            
            return cell
        } else{
            let cell = tableView.dequeueReusableCell(withIdentifier: RepCellId, for: indexPath) as! RepresentativesTableViewCell
            let representative = representatives[indexPath.row]
            cell.configure(for: representative)
            cell.setNeedsUpdateConstraints()
            cell.selectionStyle = .none
            cell.backgroundColor = .white
            cell.textLabel?.numberOfLines = 0
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0{
            let navViewController = SenateViewController()
            navViewController.senator = senators[indexPath.row]
            navigationController?.pushViewController(navViewController, animated: true)
        } else {
            let navViewController = RepresentativeViewController()
            navViewController.representative = representatives[indexPath.row]
            navigationController?.pushViewController(navViewController, animated: true)
        }
    }
    
    
    
}
extension LegislativeNavViewController : UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return HalfSizePresentationController(presentedViewController: presented, presenting: presenting)
    }
}


class HalfSizePresentationController : UIPresentationController {
    
    override var frameOfPresentedViewInContainerView: CGRect {
        get {
            guard let theView = containerView else {
                return CGRect.zero
            }
            //            return CGRect(x: 0, y: theView.bounds.height - theView.bounds.height/6, width: theView.bounds.width, height: theView.bounds.height/6)
            return CGRect(x: 0, y: theView.bounds.height - theView.bounds.height/3, width: theView.bounds.width, height: theView.bounds.height/3)
            //            return CGRect(x: 0, y: theView.bounds.height/2, width: theView.bounds.width, height: theView.bounds.height/2)
        }
    }
    
    
}

