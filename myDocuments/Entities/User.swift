//
//  User.swift
//  myDocuments
//
//  Created by Pedro Nascimento on 14/04/2018.
//  Copyright © 2018 Pedro Nascimento. All rights reserved.
//

import Foundation

class User {
    var idUser: Int32 = 0
    var name: String = ""
    var email: String = ""
    var phone: String = ""
    var password: String = ""
    
    private let idUserKey = "idUser"
    private let nameKey = "name"
    private let emailKey = "email"
    private let phoneKey = "phone"
    private let passwordKey = "password"
    
    public init() {}
    
    public init?(dictionary: NSDictionary) {
        idUser = dictionary[idUserKey] as! Int32
        name = dictionary[nameKey] as! String
        email = dictionary[emailKey] as! String
        phone = dictionary[phoneKey] as! String
        password = dictionary[passwordKey] as! String
    }
    
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
//        dictionary.setValue(self.idUser, forKey: idUserKey)
        dictionary.setValue(self.name, forKey: nameKey)
        dictionary.setValue(self.email, forKey: emailKey)
        dictionary.setValue(self.phone, forKey: phoneKey)
        dictionary.setValue(self.password, forKey: passwordKey)
        
        return dictionary
    }

}
