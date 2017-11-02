//
//  checksums.swift
//  Wabbitduck
//
//  Created by Luis Ezcurdia on 11/1/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

import Foundation

class SWCrypto {
    static let shared = SWCrypto()
    
    func sha1(string:String) -> String {
        let data = string.data(using: String.Encoding.utf8)!
        let digest = sha1(data: data)
        return digest.map { String(format: "%02hhx", $0) }.joined()
    }
    
    func sha1(data:Data) -> [UInt8] {
        var digest = [UInt8](repeating: 0, count:Int(CC_SHA1_DIGEST_LENGTH))
        data.withUnsafeBytes {
            _ = CC_SHA1($0, CC_LONG(data.count), &digest)
        }
        return digest
    }
    
    func sha256(string:String) -> String {
        let data = string.data(using: String.Encoding.utf8)!
        guard let digest = sha256(data: data) else { return "" }
        return digest.map { String(format: "%02hhx", $0) }.joined()
    }
    
    func sha256(data:Data) -> Data? {
        var hashData = Data(count: Int(CC_SHA256_DIGEST_LENGTH))
        _ = hashData.withUnsafeMutableBytes {digestBytes in
            data.withUnsafeBytes {messageBytes in
                CC_SHA256(messageBytes, CC_LONG(data.count), digestBytes)
            }
        }
        return hashData
    }
}
