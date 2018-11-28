//
//  Governors.swift
//  Contact the US Government
//
//  Created by Chengji Liu on 11/27/18.
//  Copyright © 2018 Cornell AppDev. All rights reserved.
//

import Foundation
struct Senator: Codable {
    var state: String
    var _class: String
    var name: String
    var party: String
    var officeRoom: String
    var phone: String
    var website: String
    var email: String
}

struct Representative: Codable {
    var state: String
    var name: String
    var party: String
    var district: String
    var officeRoom: String
    var phone: String
    var website: String
    var email: String
}
