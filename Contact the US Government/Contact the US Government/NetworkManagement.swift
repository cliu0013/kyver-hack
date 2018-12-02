//
//  NetworkManagement.swift
//  Contact the US Government
//
//  Created by Chengji Liu on 11/30/18.
//  Copyright © 2018 Cornell AppDev. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkManager {
    
    var us = ["me":"2",
              "nh":"2",
              "vt":"1",
              "ma":"10",
              "ny":"29",
              "ri":"2",
              "ct":"5",
              "nj":"13",
              "pa":"19",
              "de":"1",
              "md":"8",
              "va":"11",
              "wv":"3",
              "nc":"13",
              "sc":"6",
              "ga":"13",
              "fl":"25",
              "ms":"4",
              "tn":"9",
              "ky":"6",
              "oh":"18",
              "in":"9",
              "il":"19",
              "mi":"15",
              "wi":"8",
              "mn":"8",
              "ia":"5",
              "mo":"9",
              "ar":"4",
              "la":"7",
              "nd":"1",
              "sd":"1",
              "ne":"3",
              "ks":"4",
              "ok":"5",
              "tx":"32",
              "mt":"1",
              "wy":"1",
              "co":"7",
              "nm":"3",
              "az":"8",
              "ut":"3",
              "id":"2",
              "wa":"9",
              "or":"5",
              "me":"2",
              "ca":"53",
              "nv":"3",
              "ak":"1",
              "hi":"2",
              ]
    
    //This is how to get the representatives info, notice that we have to specify the district, so to list all of the people from all of the districts in one state, we have to create a dictionary first.
    //https://www.googleapis.com/civicinfo/v2/representatives/ocd-division%2Fcountry%3Aus%2Fstate%3Any%2Fcd%3A1?roles=legislatorLowerBody&key=AIzaSyCNrilf9OFSEvR3MZeO7-HeV5GGyjBcLic
    
    
    //This is how to get the senators info
    //GET https://www.googleapis.com/civicinfo/v2/representatives/ocd-division%2Fcountry%3Aus%2Fstate%3Anc?roles=legislatorUpperBody&key=AIzaSyCNrilf9OFSEvR3MZeO7-HeV5GGyjBcLic
    
    private static let senateURL = "https://www.googleapis.com/civicinfo/v2/representatives/ocd-division%2Fcountry%3Aus%2Fstate%3Any?roles=legislatorUpperBody&key=AIzaSyCNrilf9OFSEvR3MZeO7-HeV5GGyjBcLic"
    
    static func getSenators(fromName name: String, _ didGetSenators: @escaping ([Senator]) -> Void) {
       
        let parameters: [String: Any] = [
            "name": name
        ]
        Alamofire.request(senateURL, parameters: parameters).validate().responseData { (response) in
            switch response.result {
            case .success(let data):
                if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
                    print(json)
                }
                let jsonDecoder = JSONDecoder()
                if let senatorResponse = try? jsonDecoder.decode(SenatorResponse.self, from: data) {
                    didGetSenators(senatorResponse.officials)
                } else {
                    print("Invalid Response Data")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    static func getSenators(fromParty party: String, _ didGetSenators: @escaping ([Senator]) -> Void) {
        
        let parameters: [String: Any] = [
            "party": party
        ]
        Alamofire.request(senateURL, parameters: parameters).validate().responseData { (response) in
            switch response.result {
            case .success(let data):
                if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
                    print(json)
                }
                let jsonDecoder = JSONDecoder()
                if let senatorResponse = try? jsonDecoder.decode(SenatorResponse.self, from: data) {
                    didGetSenators(senatorResponse.officials)
                } else {
                    print("Invalid Response Data")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func getSenators(fromPhotoUrl photoUrl: String, _ didGetSenators: @escaping ([Senator]) -> Void) {
        
        let parameters: [String: Any] = [
            "photoUrl": photoUrl
        ]
        Alamofire.request(senateURL, parameters: parameters).validate().responseData { (response) in
            switch response.result {
            case .success(let data):
                if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
                    print(json)
                }
                let jsonDecoder = JSONDecoder()
                if let senatorResponse = try? jsonDecoder.decode(SenatorResponse.self, from: data) {
                    didGetSenators(senatorResponse.officials)
                } else {
                    print("Invalid Response Data")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
