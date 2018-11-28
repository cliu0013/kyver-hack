//
//  FilterCollectionViewCell.swift
//  Contact the US Government
//
//  Created by Nikki (｡◕‿◕｡) on 11/28/18.
//  Copyright © 2018 Cornell AppDev. All rights reserved.
//

import UIKit

class FilterCollectionViewCell: UICollectionViewCell {
    var nameLabel: UILabel!
    
    let padding: CGFloat = 8
    let labelHeight: CGFloat = 28
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.black.cgColor
        
        
        nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.systemFont(ofSize: 10)
        
        contentView.addSubview(nameLabel)
    }
    
    override func updateConstraints() {
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 2),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: labelHeight),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 50)
            ])
        
        super.updateConstraints()
    }
    
    func configure(for filter: Filter) {
        nameLabel.text = filter.name
        
    }
    
    func configure(for filter: Filter, color : UIColor) {
        nameLabel.text = filter.name
        contentView.backgroundColor = color
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

