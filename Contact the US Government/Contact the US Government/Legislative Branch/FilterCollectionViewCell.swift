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
    var unselectedColor: UIColor = .lightGray
    var selectedColor: UIColor = .blue
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        filterLabel = UILabel(frame: bounds)
        filterLabel.textAlignment = .center
        filterLabel.font = .systemFont(ofSize: 14)
        filterLabel.textColor = .blue
        layer.cornerRadius = 5
        backgroundColor = .lightGray
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

