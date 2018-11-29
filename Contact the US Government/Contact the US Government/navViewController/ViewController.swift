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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        view.backgroundColor = .white
        title = "Test"
        
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
    
}
