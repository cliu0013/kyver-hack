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
    var unselectedColor: UIColor = .white
    var selectedColor: UIColor = .lightGray
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        filterLabel = UILabel(frame: bounds)
        filterLabel.textAlignment = .center
        filterLabel.font = .systemFont(ofSize: 14)
        filterLabel.textColor = .darkGray
        filterLabel.layer.borderColor = UIColor(named: "black")?.cgColor
        filterLabel.layer.borderWidth = 0.5
        filterLabel.layer.cornerRadius = 5
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

