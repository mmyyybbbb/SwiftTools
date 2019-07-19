//
//  Device+.swift
//  SwiftTools
//
//  Created by alexej_ne on 19.07.2019.
//  Copyright © 2019 alexeyne. All rights reserved.
//

public extension UIDevice {
    
    static var installationId: String {
        let key = "__installationId"
        
        if let id = KeyChainService.load(key: key) {
            return id
        }
        
        let id: String = ProcessInfo().globallyUniqueString
        KeyChainService.set(id, forKey: key)
        return id
    }
}
