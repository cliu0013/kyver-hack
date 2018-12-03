//
//  FilterCollectionViewCell.swift
//  Contact the US Government
//
//  Created by Nikki (｡◕‿◕｡) on 11/28/18.
//  Copyright © 2018 Cornell AppDev. All rights reserved.
//

import UIKit

class FilterCollectionViewCell: UICollectionViewCell {
    var filterLabel: UILabel!
    var unselectedColor: UIColor = UIColor(red:0.21, green:0.51, blue:0.72, alpha:1.0)
    var selectedColor: UIColor = UIColor(red:1.00, green:0.37, blue:0.33, alpha:1.0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        filterLabel = UILabel(frame: bounds)
        filterLabel.textAlignment = .center
        filterLabel.font = .systemFont(ofSize: 14)
        filterLabel.textColor = .darkGray
//        filterLabel.layer.borderColor = UIColor(named: "black")?.cgColor
//        filterLabel.layer.borderWidth = 0.5
        filterLabel.layer.cornerRadius = 5
        filterLabel.clipsToBounds = true
        
        contentView.addSubview(filterLabel)
        isSelected = false
    }
    
    func setup(with title: String) {
        filterLabel.text = title
    }
    
    //when a cell is selected, we change the background / text color here to reflect the selected
    override var isSelected: Bool {
        didSet {
            super.isSelected = isSelected
            if isSelected {
                backgroundColor = selectedColor
                filterLabel.textColor = unselectedColor
            } else {
                backgroundColor = unselectedColor
                filterLabel.textColor = selectedColor
            }
            setNeedsDisplay()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

