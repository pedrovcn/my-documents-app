//
//  ApplicationManager.swift
//  myDocuments
//
//  Created by Pedro Nascimento on 14/04/2018.
//  Copyright © 2018 Pedro Nascimento. All rights reserved.
//

import Foundation
class ApplicationManager {
    
    static let sharedInstance = ApplicationManager()

    var documentsArray: Array<Document>!
    var user: User!

    private init() {
        documentsArray = Array<Document>()
        user = User()
    }
}
