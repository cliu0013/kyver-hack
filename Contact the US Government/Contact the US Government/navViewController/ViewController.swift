//
//  ViewController.swift
//  Proposal
//
//  Created by Chengji Liu on 11/10/18.
//  Copyright © 2018 Cornell AppDev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var Senate: UIButton!
    var Representative: UIButton!
    var madeBy: UILabel!
    let gloryRed = UIColor.init(red: 187.0/255, green: 19.0/255, blue: 62.0/255, alpha: 1.0)
    let padding: CGFloat = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = .white
        navigationItem.title = "Kyver"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = gloryRed
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        edgesForExtendedLayout = [] // gets rid of views going under navigation controller
        
        //setupNavBarItems()
        
        Senate = UIButton()
        Senate.layer.cornerRadius = 20
        Senate.clipsToBounds = true
        Senate.setBackgroundImage(UIImage(named: "Possible app icon"), for: .normal)
        //Senate.backgroundColor = .blue
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
        //Representative.backgroundColor = .blue
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
        //madeBy.backgroundColor = .green
        madeBy.numberOfLines = 6
        view.addSubview(madeBy)
        setupConstraints()
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            //Senate.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            Senate.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            Senate.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            //            Senate.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding*5),
            //            Senate.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding*2),
            //            Senate.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding*2),
            Senate.widthAnchor.constraint(equalToConstant: 300-padding),
            Senate.heightAnchor.constraint(equalToConstant: 225-padding)
            ])
        
        NSLayoutConstraint.activate([
            //Representative.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            Representative.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            Representative.topAnchor.constraint(equalTo: Senate.bottomAnchor, constant: padding),
            //            Representative.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding*5),
            //            Representative.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding*2),
            //            Representative.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding*2),
            Representative.widthAnchor.constraint(equalToConstant: 300-padding),
            Representative.heightAnchor.constraint(equalToConstant: 225-padding)
            ])
        NSLayoutConstraint.activate([
            madeBy.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            //madeBy.topAnchor.constraint(equalTo: Representative.bottomAnchor, constant: padding),
            madeBy.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
            //            madeBy.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding*2),
            //            madeBy.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding*2),
            //madeBy.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 100)
            ])
    }
    
    @objc func pushLegislativeNavViewController(){
        let navViewController = LegislativeNavViewController()
        navigationController?.pushViewController(navViewController, animated: true)
    }
    
    @objc func pushSenateNavViewController(){
        let navViewController = SenateNavViewController()
        navigationController?.pushViewController(navViewController, animated: true)
    }
    @objc func pushRepresentativeNavViewController(){
        let navViewController = RepresentativeNavViewController()
        navigationController?.pushViewController(navViewController, animated: true)
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
extension ViewController : UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return HalfSizePresentationController(presentedViewController: presented, presenting: presenting)
    }
}

