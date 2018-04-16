//
//  ImageExtension.swift
//  myDocuments
//
//  Created by Pedro Nascimento on 15/04/2018.
//  Copyright © 2018 Pedro Nascimento. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    class func encodeImageBase64(image: UIImage?) -> String{
        let imageData = UIImagePNGRepresentation(image!)! as NSData
        return imageData.base64EncodedString(options: .lineLength64Characters)
    }
    
    class func returnImageBase64(base64String: String) -> UIImage {
        let dataDecoded = NSData(base64Encoded: base64String, options: NSData.Base64DecodingOptions(rawValue: 0))!
        
        let decodedimage:UIImage = UIImage(data: dataDecoded as Data)!
        print(decodedimage)
        return decodedimage
    }
    
    class func encodeImageByteArray(image: UIImage) -> Data {
        return UIImageJPEGRepresentation(image, 1.0)!
    }
    
    class func decodeImageByteArray(data: Data) -> UIImage {
        return UIImage.init(data: data)!
    }
}


