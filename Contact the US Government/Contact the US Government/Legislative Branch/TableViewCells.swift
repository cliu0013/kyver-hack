//
//  TableViewCells.swift
//  Contact the US Government
//
//  Created by Chengji Liu on 11/27/18.
//  Copyright © 2018 Cornell AppDev. All rights reserved.
//

import UIKit

class SenatorsTableViewCell: UITableViewCell {
    
    var profileImage: UIImageView!
    var nameLabel: UILabel!
    var stateandpartyLabel: UILabel!
    var detailsButton: UIButton!
    var attrs = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16.0), NSAttributedString.Key.foregroundColor: UIColor.init(red: 187.0/255, green: 19.0/255, blue: 62.0/255, alpha: 1.0), NSAttributedString.Key.underlineStyle: 1] as [NSAttributedString.Key : Any]
    
    var attributedString = NSMutableAttributedString(string:"")
    
    
    
    let padding: CGFloat = 10
    let nameLabelHeight: CGFloat = 25
    let nameFont = UIFont(name: ".SFUIText-Medium", size: 25)
    let contentFont = UIFont(name: ".SFUIText-Medium", size: 16)
    let gloryBlue = UIColor.init(red: 0, green: 40.0/255, blue: 104.0/255, alpha: 1.0)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // TODO: Instantiate labels and imageView
        
        profileImage = UIImageView()
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileImage.heightAnchor.constraint(equalToConstant: 60)
        profileImage.widthAnchor.constraint(equalToConstant: 60)
        profileImage.layer.cornerRadius = 30
        profileImage.layer.masksToBounds = true
        
        stateandpartyLabel = UILabel()
        stateandpartyLabel.translatesAutoresizingMaskIntoConstraints = false
        stateandpartyLabel.font = contentFont
        stateandpartyLabel.textAlignment = .left
        stateandpartyLabel.textColor = .darkGray
        stateandpartyLabel.numberOfLines = 0
        
        nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = nameFont
        nameLabel.textAlignment = .left
        nameLabel.textColor = .black
        nameLabel.numberOfLines = 0
        
        detailsButton = UIButton()
        detailsButton.translatesAutoresizingMaskIntoConstraints = false
        let buttonTitleStr = NSMutableAttributedString(string:"details", attributes:attrs)
        attributedString.append(buttonTitleStr)
        detailsButton.setAttributedTitle(attributedString, for: .normal)
        
        contentView.addSubview(profileImage)
        contentView.addSubview(stateandpartyLabel)
        contentView.addSubview(nameLabel)
        contentView.addSubview(detailsButton)
        
        updateConstraints()
        
    }
    
    override func updateConstraints() {
        
        NSLayoutConstraint.activate([
            profileImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            profileImage.heightAnchor.constraint(equalToConstant: 60),
            profileImage.widthAnchor.constraint(equalToConstant: 60),
            profileImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            ])
        
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: padding),
            nameLabel.heightAnchor.constraint(equalToConstant: nameLabelHeight)
            ])
        
        NSLayoutConstraint.activate([
            stateandpartyLabel.bottomAnchor.constraint(equalTo: nameLabel.topAnchor),
            stateandpartyLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor,constant: padding)
            ])
        
        NSLayoutConstraint.activate([
            detailsButton.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: -5),
            detailsButton.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: padding),
            ])
        
        super.updateConstraints()
        
    }
    
    func configure(for senator: Senator){
        nameLabel.text = senator.name
        stateandpartyLabel.text = "New York (\(senator.party))"
        let url = URL(string: "\(senator.photoUrl)")
        downloadImage(from: url!)
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                self.profileImage.image = UIImage(data: data)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}

class RepresentativesTableViewCell: UITableViewCell {
    
    var profileImage: UIImageView!
    var nameLabel: UILabel!
    var stateandpartyLabel: UILabel!
    var detailsButton: UIButton!
    var attrs = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16.0), NSAttributedString.Key.foregroundColor: UIColor.init(red: 187.0/255, green: 19.0/255, blue: 62.0/255, alpha: 1.0), NSAttributedString.Key.underlineStyle: 1] as [NSAttributedString.Key : Any]
    
    var attributedString = NSMutableAttributedString(string:"")
    
    
    
    let padding: CGFloat = 10
    let nameLabelHeight: CGFloat = 25
    let nameFont = UIFont(name: ".SFUIText-Medium", size: 25)
    let contentFont = UIFont(name: ".SFUIText-Medium", size: 16)
    let gloryBlue = UIColor.init(red: 0, green: 40.0/255, blue: 104.0/255, alpha: 1.0)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // TODO: Instantiate labels and imageView
        
        profileImage = UIImageView()
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileImage.heightAnchor.constraint(equalToConstant: 60)
        profileImage.widthAnchor.constraint(equalToConstant: 60)
        profileImage.layer.cornerRadius = 30
        profileImage.layer.masksToBounds = true
        
        stateandpartyLabel = UILabel()
        stateandpartyLabel.translatesAutoresizingMaskIntoConstraints = false
        stateandpartyLabel.font = contentFont
        stateandpartyLabel.textAlignment = .left
        stateandpartyLabel.textColor = .darkGray
        stateandpartyLabel.numberOfLines = 0
        
        nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = nameFont
        nameLabel.textAlignment = .left
        nameLabel.textColor = .black
        nameLabel.numberOfLines = 0
        
        detailsButton = UIButton()
        detailsButton.translatesAutoresizingMaskIntoConstraints = false
        let buttonTitleStr = NSMutableAttributedString(string:"details", attributes:attrs)
        attributedString.append(buttonTitleStr)
        detailsButton.setAttributedTitle(attributedString, for: .normal)
        
        contentView.addSubview(profileImage)
        contentView.addSubview(stateandpartyLabel)
        contentView.addSubview(nameLabel)
        contentView.addSubview(detailsButton)
        
        updateConstraints()
        
    }
    
    override func updateConstraints() {
        
        NSLayoutConstraint.activate([
            profileImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            profileImage.heightAnchor.constraint(equalToConstant: 60),
            profileImage.widthAnchor.constraint(equalToConstant: 60),
            profileImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            ])
        
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: padding),
            nameLabel.heightAnchor.constraint(equalToConstant: nameLabelHeight)
            ])
        
        NSLayoutConstraint.activate([
            stateandpartyLabel.bottomAnchor.constraint(equalTo: nameLabel.topAnchor),
            stateandpartyLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor,constant: padding)
            ])
        
        NSLayoutConstraint.activate([
            detailsButton.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: -5),
            detailsButton.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: padding),
            ])
        
        super.updateConstraints()
        
    }
    
    func configure(for representative: Representative){
        nameLabel.text = representative.name
        stateandpartyLabel.text = "New York (\(representative.party))"
        let url = URL(string: "\(representative.photoUrl)")
        downloadImage(from: url!)
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                self.profileImage.image = UIImage(data: data)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}






class StateTableViewCell: UITableViewCell {
    var nameLabel: UILabel!
    var attrs = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16.0), NSAttributedString.Key.foregroundColor: UIColor.init(red: 187.0/255, green: 19.0/255, blue: 62.0/255, alpha: 1.0), NSAttributedString.Key.underlineStyle: 1] as [NSAttributedString.Key : Any]
    
    var attributedString = NSMutableAttributedString(string:"")
    
    let padding: CGFloat = 10
    let nameLabelHeight: CGFloat = 25
    let nameFont = UIFont(name: ".SFUIText-Medium", size: 25)
    let contentFont = UIFont(name: ".SFUIText-Medium", size: 16)
    let gloryBlue = UIColor.init(red: 0, green: 40.0/255, blue: 104.0/255, alpha: 1.0)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // TODO: Instantiate labels and imageView
        nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = nameFont
        nameLabel.textAlignment = .left
        nameLabel.textColor = .black
        nameLabel.numberOfLines = 0
        contentView.addSubview(nameLabel)
        
        
        updateConstraints()
        
    }
    
    override func updateConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            nameLabel.heightAnchor.constraint(equalToConstant: nameLabelHeight)
            
            
            ])
        super.updateConstraints()
        
    }
    
    func configure(for state: String){
        nameLabel.text = state
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


