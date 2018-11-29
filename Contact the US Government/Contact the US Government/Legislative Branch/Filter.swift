//
//  Filter.swift
//  Contact the US Government
//
//  Created by Nikki (｡◕‿◕｡) on 11/28/18.
//  Copyright © 2018 Cornell AppDev. All rights reserved.
//

import UIKit

protocol Filter {
    var filterTitle: String { get }
}

enum PartyType: Filter {
    case Democrat
    case Republican
    
    
    var filterTitle: String {
        return String(describing: self).localizedUppercase
    }
    
    static func allValues() -> [PartyType] {
        return [.Democrat, .Republican]
    }
}

enum Type1: Filter {
    case filter1
    case filter2
    case filter3
    
    var filterTitle: String {
        return String(describing: self).localizedUppercase
    }
    
    static func allValues() -> [Type1] {
        return [.filter1, .filter2, .filter3]
    }
}
