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

enum PartyType: String, Filter {
    case Democrat
    case Republican
    
    
    var filterTitle: String {
        return String(describing: self)
    }
    
    static func allValues() -> [PartyType] {
        
        return [.Democrat, .Republican]
    }
    
}


