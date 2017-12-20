//
//  User.swift
//  Chatty
//
//  Created by Daniil on 20.12.17.
//  Copyright © 2017 thePODDUBSTEP. All rights reserved.
//

import Foundation

class ChatUser: NSObject {
    var name: String?
    var email: String?
    var profileImageUrl: String?
    var id: String?
    
    init(dictionary: [String: Any]) {
        super.init()
        name = dictionary["name"] as? String
        email = dictionary["email"] as? String
        profileImageUrl = dictionary["profileImageUrl"] as? String
    }
}
