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
    
    private static let us = [
        "al":"7",
        "ak":"1",
        "az":"8",
        "ar":"4",
        "ca":"53",
        "co":"7",
        "ct":"5",
        "de":"1",
        "fl":"25",
        "ga":"13",
        "hi":"2",
        "id":"2",
        "in":"9",
        "il":"19",
        "ia":"5",
        "ks":"4",
        "ky":"6",
        "la":"7",
        "mi":"15",
        "md":"8",
        "mn":"8",
        "mo":"9",
        "mt":"1",
        "me":"2",
        "ma":"10",
        "ms":"4",
        "nh":"2",
        "ny":"29",
        "nj":"13",
        "nd":"1",
        "ne":"3",
        "nv":"3",
        "nm":"3",
        "nc":"13",
        "ok":"5",
        "or":"5",
        "oh":"18",
        "pa":"19",
        "ri":"2",
        "sd":"1",
        "sc":"6",
        "tn":"9",
        "tx":"32",
        "wv":"3",
        "wi":"8",
        "wy":"1",
        "wa":"9",
        "ut":"3",
        "va":"11",
        "vt":"1"
    ]
    
    public static let usa = [
        "Alabama":"al",
        "Alaska":"ak",
        "Arizona":"az",
        "Arkansas":"ar",
        "California":"ca",
        "Colorado":"co",
        "Connecticut":"ct",
        "Deleware":"de",
        "Florida":"fl",
        "Georgia":"ga",
        "Hawaii":"hi",
        "Idaho":"id",
        "Indiana":"in",
        "Illinois":"il",
        "Iowa":"ia",
        "Kansas":"ks",
        "Kentucky":"ky",
        "Louisiana":"la",
        "Michigan":"mi",
        "Maryland":"md",
        "Minnesota":"mn",
        "Missouri":"mo",
        "Montana":"mt",
        "Maine":"me",
        "Massachusetts":"ma",
        "Mississippi":"ms",
        "New Hampshire":"nh",
        "New York":"ny",
        "New Jersey":"nj",
        "North Dakota":"nd",
        "Nebraska":"ne",
        "Nevada":"nv",
        "New Mexico":"nm",
        "North Carolina":"nc",
        "Oklahoma":"ok",
        "Oregon":"or",
        "Ohio":"oh",
        "Pennsylvania":"pa",
        "Rhode Island":"ri",
        "South Dakota":"sd",
        "South Carolina":"sc",
        "Tennessee":"tn",
        "Texas":"tx",
        "West Virginia":"wv",
        "Wisconsin":"wi",
        "Wyoming":"wy",
        "Washington":"wa",
        "Utah":"ut",
        "Virginia":"va",
        "Vermont":"vt"
    ]
    
    public static let usaReverse = [
        "al":"Alabama",
        "ak":"Alaska",
        "az":"Arizona",
        "ar":"Arkansas",
        "ca":"California",
        "co":"Colorado",
        "ct":"Connecticut",
        "de":"Deleware",
        "fl":"Florida",
        "ga":"Georgia",
        "hi":"Hawaii",
        "id":"Idaho",
        "in":"Indiana",
        "il":"Illinois",
        "ia":"Iowa",
        "ks":"Kansas",
        "ky":"Kentucky",
        "la":"Louisiana",
        "mi":"Michigan",
        "md":"Maryland",
        "mn":"Minnesota",
        "mo":"Missouri",
        "mt":"Montana",
        "me":"Maine",
        "ma":"Massachusetts",
        "ms":"Mississippi",
        "nh":"New Hampshire",
        "ny":"New York",
        "nj":"New Jersey",
        "nd":"North Dakota",
        "ne":"Nebraska",
        "nv":"Nevada",
        "nm":"New Mexico",
        "nc":"North Carolina",
        "ok":"Oklahoma",
        "or":"Oregon",
        "oh":"Ohio",
        "pa":"Pennsylvania",
        "ri":"Rhode Island",
        "sd":"South Dakota",
        "sc":"South Carolina",
        "tn":"Tennessee",
        "tx":"Texas",
        "wv":"West Virginia",
        "wi":"Wisconsin",
        "wy":"Wyoming",
        "wa":"Washington",
        "ut":"Utah",
        "va":"Virginia",
        "vt":"Vermont"
        
        
    ]
    
    
    public static var state: String = "vt"
    
    private static var senatorUrl = "https://www.googleapis.com/civicinfo/v2/representatives/ocd-division%2Fcountry%3Aus%2Fstate%3A\(state)"
    
    public static var representativesUrl = [String]()
    
    static func getRepresentativesUrl(state: String){
        let dNum: Int = Int(us[state]!)!
        for d in 1...dNum {
            var representativeUrl = "https://www.googleapis.com/civicinfo/v2/representatives/ocd-division%2Fcountry%3Aus%2Fstate%3A\(state)%2Fcd%3A\(d)"
            print(representativeUrl)
            representativesUrl.append(representativeUrl)
        }
    }
    
    static func getSenators(state: String, roles: String, YOUR_API_KEY: String, completion: @escaping ([Senator]) -> Void) {
        let parameters: [String: Any] = [
            "roles": roles,
            "key": YOUR_API_KEY
        ]
        senatorUrl = "https://www.googleapis.com/civicinfo/v2/representatives/ocd-division%2Fcountry%3Aus%2Fstate%3A\(state)"
        Alamofire.request(senatorUrl, method: .get, parameters: parameters).validate().responseData { (response) in
            switch response.result {
            case .success(let data):
                if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
                    print(json)
                }
                let jsonDecoder = JSONDecoder()
                if let senator = try? jsonDecoder.decode(SenatorResponse.self, from: data) {
                    completion(senator.officials)
                } else {
                    print("Invalid Response Data")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func getRepresentatives(i: Int, roles: String, YOUR_API_KEY: String, completion: @escaping ([Representative]) -> Void) {
        let parameters: [String: Any] = [
            "roles": roles,
            "key": YOUR_API_KEY
        ]
        Alamofire.request(representativesUrl[i], method: .get, parameters: parameters).validate().responseData { (response) in
            switch response.result {
            case .success(let data):
                if let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
                    print(json)
                }
                let jsonDecoder = JSONDecoder()
                if let representative = try? jsonDecoder.decode(RepresentativeResponse.self, from: data) {
                    completion(representative.officials)
                } else {
                    print("Invalid Response Data")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    
}
