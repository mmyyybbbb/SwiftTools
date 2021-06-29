//
//  KeyChainService.swift
//  BrokerDomainCore
//
//  Created by Andrey Raevnev on 28/02/2019.
//  Copyright © 2019 BCS. All rights reserved.
//

public final class KeyChainService {
    
    @discardableResult
    public class func set(_ id: String, forKey: String) -> Bool {
        if let data = id.data(using: String.Encoding.utf8) {
            let query: [String : Any] = [
                kSecClass as String       : kSecClassGenericPassword as String,
                kSecAttrAccount as String : forKey,
                kSecValueData as String   : data ]
            
            SecItemDelete(query as CFDictionary)
            let status = SecItemAdd(query as CFDictionary, nil)
            if status == noErr {
                return true
            }
        }
        return false
    }
    
    public class func load(key: String) -> String? {
        let query: [String : Any] = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : key,
            kSecReturnData as String  : kCFBooleanTrue as Any,
            kSecMatchLimit as String  : kSecMatchLimitOne ]
        
        var dataTypeRef: AnyObject? = nil
        
        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        if status == noErr, let receivedData = dataTypeRef as? Data, let id = String(data: receivedData, encoding: String.Encoding.utf8) {
            return id
        }
        return nil
    }
    
    @discardableResult
    public class func remove(forKey: String) -> Bool {
        let query: [String : Any] = [
            kSecClass as String       : kSecClassGenericPassword as String,
            kSecAttrAccount as String : forKey
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        if status == noErr {
            return true
        }
        return false
    }
}
