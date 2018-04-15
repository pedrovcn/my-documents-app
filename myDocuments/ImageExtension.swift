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
    class func returnImageBase64() -> UIImage {
        let dataDecoded = NSData(base64Encoded: "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", options: NSData.Base64DecodingOptions(rawValue: 0))!
        
        let decodedimage:UIImage = UIImage(data: dataDecoded as Data)!
        return decodedimage
    }
}


