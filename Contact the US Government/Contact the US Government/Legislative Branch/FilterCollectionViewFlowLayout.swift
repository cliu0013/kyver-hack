//
//  FilterCollectionViewFlowLayout.swift
//  Contact the US Government
//
//  Created by Nikki (｡◕‿◕｡) on 11/28/18.
//  Copyright © 2018 Cornell AppDev. All rights reserved.
//

import UIKit

class FilterCollectionViewFlowLayout: UICollectionViewFlowLayout {
    var cellWidth: CGFloat!
    var cellHeight: CGFloat!
    let edgeInset: CGFloat = 32
    let itemHeight: CGFloat = 34
    let itemWidth: CGFloat = 100
    
    override func prepare() {
        super.prepare()
        itemSize = CGSize(width: itemWidth, height: itemHeight)
        minimumLineSpacing = edgeInset
        minimumInteritemSpacing = edgeInset
        scrollDirection = .horizontal
        sectionInset = UIEdgeInsets(top: 0.0, left: 90, bottom: 0.0, right: 90)
    }
}
