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
        doGetRequest(url: getCompleteUrl(forKey: Constants.ServerKeys.documents)) { error in
            if error != nil {
                completion(error)
                
            } else {
                completion(nil)
            }
        }
    }
    
    class func filterDocumentsByName(name: String, completion: @escaping(Error?) -> Void) {
        var url = getCompleteUrl(forKey: Constants.ServerKeys.documents)
        
        url.append("?name=")
        url.append(name)
        
        doGetRequest(url: url) { error in
            if error != nil {
                completion(error)
                
            } else {
                completion(nil)
            }
        }
    }
    
    class func filterDocumentsByDate(startDate: String, endDate:String, completion: @escaping(Error?) -> Void) {
        var url = getCompleteUrl(forKey: Constants.ServerKeys.documents)
        
        url.append("?startDate=")
        url.append(startDate)
        url.append("&endDate=")
        url.append(endDate)
        
        doGetRequest(url: url) { error in
            if error != nil {
                completion(error)
                
            } else {
                completion(nil)
            }
        }
        
    }
    
    class func saveDocument(document: Document, completion: @escaping(Error?) -> Void) {
        let url = getCompleteUrl(forKey: Constants.ServerKeys.documents)
        let params = document.dictionaryRepresentation() as? Parameters
        
        doPostRequest(url: url, params: params!) { error in
            if error != nil {
                completion(error)
                
            } else {
                completion(nil)
            }
        }
    }
    
    class func createUser(user: User, completion: @escaping(Error?) -> Void) {
        let url = getCompleteUrl(forKey: Constants.ServerKeys.user)
        let params = user.dictionaryRepresentation() as? Parameters
        
        doPostRequest(url: url, params: params!) { error in
            if error != nil {
                completion(error)
                
            } else {
                completion(nil)
            }
        }
    }
    
    class func loginUser(user: User, completion: @escaping(Error?) -> Void) {
        let url = getCompleteUrl(forKey: Constants.ServerKeys.login)
        let params = user.dictionaryRepresentation() as? Parameters
        
        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
                    
            switch(response.result) {
            case .success(_):
                if let json = response.result.value {
                    let dictionary = json as! NSDictionary
                    ApplicationManager.sharedInstance.user = User(dictionary: dictionary)
                    completion(nil)
                }
                
            case .failure(_):
                completion(NSError.init(domain: "Erro ao salvar informações.", code: 1, userInfo: nil))
                
            }
        
        }
    }
    
    private class func doGetRequest(url: String, completion: @escaping(Error?) -> Void) {
        Alamofire.request(url).responseJSON { response in
            
            if let json = response.result.value {
                let dictionary = json as! NSDictionary
                let array = dictionary.value(forKey: "content") as! Array<NSDictionary>
                
                ApplicationManager.sharedInstance.documentsArray.removeAll()
                
                for dict in array {
                    let document = Document(dictionary: dict)
                    ApplicationManager.sharedInstance.documentsArray.append(document!)
                }
                
                completion(nil)
                
            } else {
                completion(NSError.init(domain: "Não foi possível buscar informações.", code: 1, userInfo: nil))
            }
        }
    }
    
    private class func doPostRequest(url: String, params: Parameters, completion: @escaping(Error?) -> Void) {
        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            
            switch(response.result) {
            case .success(_):
                completion(nil)
                
            case .failure(_):
                completion(NSError.init(domain: "Erro ao salvar informações.", code: 1, userInfo: nil))
                
            }
            
        }
    }
}
