//
//  FilterModalViewController.swift
//  Contact the US Government
//
//  Created by Chengji Liu on 11/26/18.
//  Copyright © 2018 Cornell AppDev. All rights reserved.
//

import UIKit

class FilterModalViewController: UIViewController {
    
    let padding: CGFloat = 50
    let gloryBlue = UIColor.init(red: 0, green: 33.0/255, blue: 71.0/255, alpha: 1.0)
    let gloryRed = UIColor.init(red: 187.0/255, green: 19.0/255, blue: 62.0/255, alpha: 1.0)
    let filterReuseIdentifier: String = "FilterCollectionViewCell"
    var refreshControl: UIRefreshControl!
    //var filtersArray: [Filter]!
    
    var filterView: UICollectionView!
    var confirmationButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = gloryRed
        
        confirmationButton = UIButton()
        confirmationButton.translatesAutoresizingMaskIntoConstraints = false
        confirmationButton.setBackgroundImage(UIImage(named: "confirmationButtonImage"), for: .normal)
        confirmationButton.addTarget(self, action: #selector(dismissFilterModalViewControllerAndSaveOptions), for: .touchUpInside)
        view.addSubview(confirmationButton)
        
        filterView = UICollectionView(frame: .zero, collectionViewLayout: FilterCollectionViewFlowLayout())
        filterView.translatesAutoresizingMaskIntoConstraints = false
        //        filterView.delegate = self
        //        filterView.dataSource = self
        filterView.register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: filterReuseIdentifier)
        filterView.showsHorizontalScrollIndicator = false
        filterView.backgroundColor = gloryBlue
        filterView.allowsMultipleSelection = true //this is how we select multiple cells at once
        view.addSubview(filterView)
        
        setupConstraints()
        
        // Do any additional setup after loading the view.
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            confirmationButton.widthAnchor.constraint(equalToConstant: 100),
            confirmationButton.heightAnchor.constraint(equalToConstant: 100),
            confirmationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: padding * -1.0),
            confirmationButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: padding * -1.0)
            ])
        
        NSLayoutConstraint.activate([
            filterView.heightAnchor.constraint(equalToConstant: 50),
            filterView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            filterView.bottomAnchor.constraint(equalTo: view.bottomAnchor,  constant: padding * -0.3),
            filterView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ])
    }
    
    @objc func dismissFilterModalViewControllerAndSaveOptions(){
            dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
