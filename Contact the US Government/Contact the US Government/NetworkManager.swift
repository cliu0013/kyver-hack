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
    
    
    private static let state: String = "ny"
    
    private static let senatorUrl = "https://www.googleapis.com/civicinfo/v2/representatives/ocd-division%2Fcountry%3Aus%2Fstate%3Any"
    
    public static var representativesUrl = [String]()
    
    static func getRepresentativesUrl(state: String){
        let dNum: Int = Int(us[state]!)!
        for d in 1...dNum {
            var representativeUrl = "https://www.googleapis.com/civicinfo/v2/representatives/ocd-division%2Fcountry%3Aus%2Fstate%3A\(state)%2Fcd%3A\(d)"
            print(representativeUrl)
            representativesUrl.append(representativeUrl)
        }
    }

    static func getSenators(roles: String, YOUR_API_KEY: String, completion: @escaping ([Senator]) -> Void) {
        let parameters: [String: Any] = [
            "roles": roles,
            "key": YOUR_API_KEY
        ]
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
