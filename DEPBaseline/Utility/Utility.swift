//
//  Utility.swift
//  DEPBaseline
//
//  Created by Smita Tamboli on 06/09/17.
//  Copyright © 2017 Netcracker. All rights reserved.
//

import Foundation

protocol utilityProtocol {
    var clientID : String {get}
}

struct Utility: utilityProtocol {
    
    var clientID: String = ""

    mutating func getClientId() -> String {
        
        if let path = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist") {
            if let dict = NSDictionary(contentsOfFile: path) as? Dictionary<String, AnyObject> {
                clientID = dict["CLIENT_ID"] as! String
            }
        }
        
        return clientID
    }
    
}
