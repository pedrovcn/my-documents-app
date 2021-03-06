//
//  Document.swift
//  myDocuments
//
//  Created by Pedro Nascimento on 14/04/2018.
//  Copyright © 2018 Pedro Nascimento. All rights reserved.
//

import Foundation

class Document: NSObject {
    
    var user: User!
    var name: String!
    var date: String!
    var base64Image: String!
    var imageByteArray: Data!
    
    private final let nameKey = "name"
    private final let dateKey = "dateRegistered"
    private final let userKey = "user"
    private final let base64ImageKey = "base64Image"
    private final let imageByteArrayKey = "imageByteArrayKey"
    
    public init?(dictionary: NSDictionary) {
        name = dictionary[nameKey] as? String
        date = dictionary[dateKey] as? String
        user = dictionary[userKey] as? User
    }
    
    public init?(nameDocument: String) {
        name = nameDocument
        user = ApplicationManager.sharedInstance.user
    }
    
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.name, forKey: nameKey)
        dictionary.setValue(self.date, forKey: dateKey)
        dictionary.setValue(self.user.dictionaryRepresentation(), forKey: userKey)
//        dictionary.setValue(self.base64Image, forKey: base64Image)
//        dictionary.setValue(self.imageByteArray, forKey: imageByteArrayKey)
        
        return dictionary
    }
}
