//
//  Service.swift
//  myDocuments
//
//  Created by Pedro Nascimento on 14/04/2018.
//  Copyright © 2018 Pedro Nascimento. All rights reserved.
//

import Foundation
import Alamofire

class Service: NSObject {
    
    private class func getCompleteUrl(forKey key: String) -> String {
        if let path = Bundle.main.path(forResource: "RestEndpoints", ofType: "plist") {
            let dictionary = NSDictionary(contentsOfFile: path)
            let serverUrl = dictionary?.value(forKey: Constants.ServerKeys.server) as! String
            
            return serverUrl + (dictionary?.value(forKey: key) as! String)
        }
        
        return ""
    }
    
    class func getAllDocuments(completion: @escaping(Error?) -> Void) {
        Alamofire.request(getCompleteUrl(forKey: Constants.ServerKeys.documents)).responseJSON { response in
            
            if let json = response.result.value {
                let array = json as! NSArray
                ApplicationManager.sharedInstance.documentsArray.removeAll()
                
                for dict in array {
                    let document = Document(dictionary: dict as! NSDictionary)
                    ApplicationManager.sharedInstance.documentsArray.append(document!)
                }
                
                completion(nil)
                
            } else {
                completion(NSError.init(domain: "Não foi possível buscar informações.", code: 1, userInfo: nil))
            }
        }
    }
    
    class func saveDocument(document: Document, completion: @escaping(Error?) -> Void) {
        print(document.dictionaryRepresentation())
        let url = getCompleteUrl(forKey: Constants.ServerKeys.documents)
        let params = document.dictionaryRepresentation() as? Parameters
        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            
            switch(response.result) {
            case .success(_):
                completion(nil)
                
            case .failure(_):
                completion(NSError.init(domain: "Erro ao salvar o documento.", code: 1, userInfo: nil))
                
            }
            
            print(response)
            
        }
    }
}
