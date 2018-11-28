//
//  SenateViewController.swift
//  Contact the US Government
//
//  Created by Chengji Liu on 11/27/18.
//  Copyright © 2018 Cornell AppDev. All rights reserved.
//

import UIKit


class SenateViewController: UIViewController {

    let contentFont = UIFont(name: ".SFUIText-Medium", size: 20)
    let headerFont = UIFont(name: "HelveticaNeue-Bold", size: 25)
    let gloryBlue = UIColor.init(red: 0, green: 33.0/255, blue: 71.0/255, alpha: 1.0)
    let gloryRed = UIColor.init(red: 187.0/255, green: 19.0/255, blue: 62.0/255, alpha: 1.0)
    
    var senator: Senator!
    var profilePhoto: UIImageView!
    var phoneButton: UIButton!
    var websiteButton: UIButton!
    
//    struct Senator: Codable {
//        var state: String
//        var _class: String
//        var name: String
//        var party: String
//        var officeRoom: String
//        var phone: String
//        var website: String
//        var email: String
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = senator.name
        // Do any additional setup after loading the view.
        
        profilePhoto = UIImageView()
        profilePhoto.translatesAutoresizingMaskIntoConstraints = false
        profilePhoto.image = UIImage(named: senator.name)
        profilePhoto.layer.cornerRadius = 75
        profilePhoto.layer.masksToBounds = true
        view.addSubview(profilePhoto)
        
        phoneButton = UIButton()
        phoneButton.translatesAutoresizingMaskIntoConstraints = false
        phoneButton.setTitle(senator.phone, for: .normal)
        phoneButton.setTitleColor(gloryBlue, for: .normal)
        phoneButton.addTarget(self, action: #selector(phoneCall), for: .touchUpInside)
        view.addSubview(phoneButton)
        
        websiteButton = UIButton()
        websiteButton.translatesAutoresizingMaskIntoConstraints = false
        websiteButton.setTitle(senator.website, for: .normal)
        websiteButton.setTitleColor(gloryBlue, for: .normal)
        websiteButton.addTarget(self, action: #selector(websiteOpen), for: .touchUpInside)
        view.addSubview(websiteButton)
        
        setupConstraints()
    }
    
    @objc func phoneCall(){
        
    }
    
    @objc func websiteOpen(){
        
    }
    
    
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            profilePhoto.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            profilePhoto.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profilePhoto.heightAnchor.constraint(equalToConstant: 150),
            profilePhoto.widthAnchor.constraint(equalToConstant: 150)
            ])
        
        NSLayoutConstraint.activate([
            phoneButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 500),
            phoneButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            phoneButton.heightAnchor.constraint(equalToConstant: 40)
            ])
        
        NSLayoutConstraint.activate([
            websiteButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 600),
            websiteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            websiteButton.heightAnchor.constraint(equalToConstant: 40)
            ])
        
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