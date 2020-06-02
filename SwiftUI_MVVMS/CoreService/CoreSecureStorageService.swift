//
//  CoreSecureStorageService.swift
//  SwiftUI_MVVMS
//
//  Created by exey on 21.04.2020.
//  Copyright © 2020 exey. All rights reserved.
//

import Foundation
import Security

final class CoreSecureStorageService: Serviceable {

    // MARK: - Keychain
    
    @discardableResult
    func secureSet(key: String, value: String) -> Bool {
        guard let data: Data = value.data(using: String.Encoding.utf8) else {
            return false
        }
        let query = [
            kSecClass as String: kSecClassGenericPassword as String,
            kSecAttrAccount as String: key,
            kSecValueData as String: data,
            ] as [String : Any]

        SecItemDelete(query as CFDictionary)

        let status: OSStatus = SecItemAdd(query as CFDictionary, nil)
        return status == noErr
    }

    func secureGet(key aKey: String) -> String? {
        let keyChainQuery = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: aKey,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne,
            ] as [String : Any]
        var extractedData: AnyObject?

        let status: OSStatus = SecItemCopyMatching(keyChainQuery as CFDictionary, &extractedData)
        if status == noErr {
            if let retrievedData = extractedData as? Data {
                return String(data: retrievedData, encoding: String.Encoding.utf8)
            }
        }
        return nil
    }

    @discardableResult
    func secureDelete(_ key: String) -> Bool {
        let query = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            ] as [String : Any]

        let status: OSStatus = SecItemDelete(query as CFDictionary)
        return status == noErr
    }
    
}
