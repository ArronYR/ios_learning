//
//  String.swift
//  ToeflMiao
//
//  Created by JohnLui on 15/4/20.
//  Copyright (c) 2015年 com.lvwenhan. All rights reserved.
//

import Foundation

extension String{
    var md5: String! {
        let str = self.cStringUsingEncoding(NSUTF8StringEncoding)
        let strLen = CC_LONG(self.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.alloc(digestLen)
        
        CC_MD5(str!, strLen, result)
        
        let hash = NSMutableString()
        for i in 0..<digestLen {
            hash.appendFormat("%02x", result[i])
        }
        
        result.destroy()
        
        return String(format: hash as String)
    }
    var base64: String! {
        let utf8EncodeData: NSData! = self.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        let base64EncodingData = utf8EncodeData.base64EncodedStringWithOptions([])
        return base64EncodingData
    }
    var nsdata: NSData {
        return self.dataUsingEncoding(NSUTF8StringEncoding)!
    }
    var hide4NumbersOfPhoneNumber: String! {
        let range: Range = Range(start: self.startIndex.advancedBy(3), end: self.startIndex.advancedBy(7))
        return self.stringByReplacingCharactersInRange(range, withString: "****")
    }
    
    static func randomStringWithLength(len : Int) -> String {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        
        let randomString : NSMutableString = NSMutableString(capacity: len)
        
        for (var i=0; i < len; i++){
            let length = UInt32 (letters.length)
            let rand = arc4random_uniform(length)
            randomString.appendFormat("%C", letters.characterAtIndex(Int(rand)))
        }
        
        return randomString as String
    }
}