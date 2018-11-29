//
//  Governors.swift
//  Contact the US Government
//
//  Created by Chengji Liu on 11/27/18.
//  Copyright © 2018 Cornell AppDev. All rights reserved.
//

import Foundation

class Senator: Codable {
    var state: String
    var _class: String
    var name: String
    var party: String
    var officeRoom: String
    var phone: String
    var website: String
    var email: String
    
    init(state: String, _class: String, name: String, party: String, officeRoom: String, phone: String, website: String, email: String) {
        self.state = state
        self._class = _class
        self.name = name
        self.party = party
        self.officeRoom = officeRoom
        self.phone = phone
        self.website = website
        self.email = email
    }
    
    func convertToPartyType(party : String) -> PartyType {
        if (party == "Republican"){
            return .Republican
        }
        else {
            return .Democrat
        }
    }
}

class Representative: Codable {
    var state: String
    var name: String
    var party: String
    var district: String
    var officeRoom: String
    var phone: String
    var website: String
    var email: String
    
    init(state: String, name: String, party: String, district: String, officeRoom: String, phone: String, website: String, email: String) {
        self.state = state
        self.name = name
        self.party = party
        self.district = district
        self.officeRoom = officeRoom
        self.phone = phone
        self.website = website
        self.email = email
    }
    
    func convertToPartyType(party : String) -> PartyType {
        if (party == "Republican"){
            return .Republican
        }
        else {
            return .Democrat
        }
    }
    
}


