//
//  crypto.swift
//  iBOCA
//
//  Created by saman on 6/26/17.
//  Copyright © 2017 sunspot. All rights reserved.
//


import Foundation
import Security
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
