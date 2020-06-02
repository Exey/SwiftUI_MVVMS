//
//  Obfuscator.swift
//  Tripster
//
//  Created by exey on 21.04.2020.
//  Copyright © 2020 Exey Panteleev. All rights reserved.
//

import Foundation

extension String {
    
    func characters() -> [Character] {
        return self.map { $0 }
    }
    
}

final class Obfuscator: Serviceable {
    
    // MARK: - Variables
    
    //let secretKey = "6d8042b599c8247ec9f0b7b8f4d7048833cacaf6"
    let key: [UInt8] = [84, 5, 90, 81, 86, 83, 0, 84, 91, 88, 1, 89, 80, 85, 85, 4, 1, 88, 4, 81, 0, 86, 0, 89, 4, 85, 6, 86, 82, 85, 90, 89, 81, 82, 1, 0, 1, 0, 4, 87]

    /// The salt used to obfuscate and reveal the string.
    private var salt: String
    
    // MARK: - Initialization
    
    init() {
        // Generate salt
        typealias C = Character
        let a1: C, a2: C
        (a1, a2) = ("a", "b")
        self.salt = String("00".characters().enumerated().map { i, e in
            if i == 0 { return a2 }
            else { return a1 }
        })
        
    }
    
    init(with salt: String) {
        self.salt = salt
    }
    
    // MARK: - Instance Methods
    #if DEBUG
    func bytesByObfuscatingString(string: String) -> [UInt8] {
        let text = [UInt8](string.utf8)
        let cipher = [UInt8](self.salt.utf8)
        let length = cipher.count
        
        var encrypted = [UInt8]()
        
        for t in text.enumerated() {
            encrypted.append(t.element ^ cipher[t.offset % length])
        }
        
        #if DEBUG
        pp("Salt used: \(self.salt)\n")
        pp("Swift Code:\n************")
        pp("// Original \"\(string)\"")
        pp("let key: [UInt8] = \(encrypted)\n")
        #endif
        
        return encrypted
    }
    #endif
    
    func reveal(key: [UInt8]) -> String {
        let cipher = [UInt8](self.salt.utf8)
        let length = cipher.count
        
        var decrypted = [UInt8]()
        
        for k in key.enumerated() {
            decrypted.append(k.element ^ cipher[k.offset % length])
        }
        
        return String(bytes: decrypted, encoding: .utf8)!
    }
}
