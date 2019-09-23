//
//  crypto.swift
//  iBOCA
//
//  Created by saman on 6/26/17.
//  Copyright © 2017 sunspot. All rights reserved.
//


import Foundation
import Security
import CryptoSwift
           // ".......x.......x.......x.......X.......x.......x.......x.......X
let key =     "g2t2A)os{jw6E;9L8g,FrTR*LpRjX63U"
let initvec = "CV68au@dz7XPkFEb"

func encryptString(str : String) -> Data {
    do {
        let aes = try AES(key: key, iv: initvec, padding: Padding.zeroPadding)
        let ciphertext = try aes.encrypt(Array(str.utf8))
        return Data(ciphertext)
    } catch { }
    return Data()
}


func decryptString(ciphertext : Data) -> String {
    do {
        
        let aes = try AES(key: key, iv: initvec, padding: Padding.zeroPadding)
        let data = try aes.decrypt(ciphertext.bytes)
        return String(data: Data(data), encoding: String.Encoding.utf8)!
    } catch { }
    return ""
}

func decodeBase64() {
    
    let base64 = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAri0SeZI6c_UunD7i8A6VY9XxrdDyY4dBUDISruFx_QELq0ch07e3wLaKcQekPMLFntPdxW-Qs_tgBvbPg2u7N5PM2PrYe2cOEVv3RBH0c8hpLewmGwjzp1GorNU0KMCiV8cJoXNtb3lAw1kIJlg0i4NG6PCGCB46sts3w8O_QICWwGqbMyUWDHa1sjN3XCpTB_dXvHM-WAT5TQKt7VyfqDpkc2Offjh24EszI4g1LgxARmpBICV-rS_avHKQXNltoH-ogdqXZDGVtZhMXL0iwmz-ibjDNOLQHLKt158YcN26cMfKW-1t01kDnZg7sixw4rEq7RTapF7EYh99yNJuowIDAQAB"
    let base64Key = base64urlToBase64(base64url: base64)
    let keyData = Data(base64Encoded: base64Key)
    let key = SecKeyCreateWithData(keyData! as CFData, [
        kSecAttrKeyType: kSecAttrKeyTypeRSA,
        kSecAttrKeyClass: kSecAttrKeyClassPublic,
        ] as NSDictionary, nil)
    
    let cardInfo = "9400112999999998|202212|".data(using: .utf8)
    let error: UnsafeMutablePointer<Unmanaged<CFError>?>? = nil
    if let encryptData = SecKeyCreateEncryptedData(key!, .rsaEncryptionOAEPSHA256, cardInfo! as CFData, error) as Data? {
        print(encryptData.base64EncodedString().toggleBase64URLSafe(on: true))
    }
    
}

func base64urlToBase64(base64url: String) -> String {
    var base64 = base64url
        .replacingOccurrences(of: "-", with: "+")
        .replacingOccurrences(of: "_", with: "/")
    if base64.count % 4 != 0 {
        base64.append(String(repeating: "=", count: 4 - base64.count % 4))
    }
    return base64
}


extension String {
    
    /// Encodes or decodes into a base64url safe representation
    ///
    /// - Parameter on: Whether or not the string should be made safe for URL strings
    /// - Returns: if `on`, then a base64url string; if `off` then a base64 string
    func toggleBase64URLSafe(on: Bool) -> String {
        if on {
            // Make base64 string safe for passing into URL query params
            let base64url = self.replacingOccurrences(of: "/", with: "_")
                .replacingOccurrences(of: "+", with: "-")
                .replacingOccurrences(of: "=", with: "")
            return base64url
        } else {
            // Return to base64 encoding
            var base64 = self.replacingOccurrences(of: "_", with: "/")
                .replacingOccurrences(of: "-", with: "+")
            // Add any necessary padding with `=`
            if base64.count % 4 != 0 {
                base64.append(String(repeating: "=", count: 4 - base64.count % 4))
            }
            return base64
        }
    }
    
}
