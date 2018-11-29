//
//  ViewController.swift
//  Proposal
//
//  Created by Chengji Liu on 11/10/18.
//  Copyright © 2018 Cornell AppDev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var LegislativeBranch: UIButton!
    let gloryRed = UIColor.init(red: 187.0/255, green: 19.0/255, blue: 62.0/255, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = .white
        navigationItem.title = "Contact"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = gloryRed
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        edgesForExtendedLayout = [] // gets rid of views going under navigation controller
        
        setupNavBarItems()
        
        LegislativeBranch = UIButton()
        LegislativeBranch.translatesAutoresizingMaskIntoConstraints = false
        LegislativeBranch.setTitle("LegislativeBranch", for: .normal)
        LegislativeBranch.setTitleColor(.black, for: .normal)
        LegislativeBranch.addTarget(self, action: #selector(pushLegislativeNavViewController), for: .touchUpInside)
        view.addSubview(LegislativeBranch)
        
        setupConstraints()
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            LegislativeBranch.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            LegislativeBranch.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
    }
    
    @objc func pushLegislativeNavViewController(){
        let navViewController = LegislativeNavViewController()
        navigationController?.pushViewController(navViewController, animated: true)
    }
    
    func setupNavBarItems(){
        let filterButton = UIButton(type: .system)
        filterButton.setTitle("Made By", for: .normal)
        filterButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        filterButton.tintColor = .white
        //filterButton.addTarget(self, action: #selector(presentMadeByModalViewController), for: .touchUpInside)
        
        navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: filterButton) ]
    }
    
    //    @objc func presentMadeByModalViewController(){
    //        //let modalViewController = MadeByModalViewController()
    //        modalViewController.modalPresentationStyle = .custom
    //        modalViewController.transitioningDelegate = self
    //        present(modalViewController, animated: true, completion: nil)
    //
    //    }
    
}
extension ViewController : UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return HalfSizePresentationController(presentedViewController: presented, presenting: presenting)
    }
}

