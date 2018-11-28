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
    
    var confirmationButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        title = "Filter"
        
        confirmationButton = UIButton()
        confirmationButton.translatesAutoresizingMaskIntoConstraints = false
        confirmationButton.setBackgroundImage(UIImage(named: "confirmationButtonImage"), for: .normal)
        confirmationButton.addTarget(self, action: #selector(dismissFilterModalViewControllerAndSaveOptions), for: .touchUpInside)
        view.addSubview(confirmationButton)
        
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
