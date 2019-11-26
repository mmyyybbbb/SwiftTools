//
//  AppContext.swift
//  BCSTools
//
//  Created by alexej_ne on 14.08.2018.
//  Copyright © 2018 BCS. All rights reserved.
//

public protocol AppContextType {
    associatedtype Context
    
    func isActual(_ : Context) -> Bool
}

public extension AppContextType {
    
    func isAny(_ contexts: Context...) -> Bool {
        for context in contexts {
            if isActual(context) { return true }
        }
        return false
    }
    
    func isAll(_ contexts: Context...) -> Bool {
        for context in contexts {
            if !isActual(context) { return false }
        }
        return true
    }
    
    func isAny(of contexts: [Context]) -> Bool {
        for context in contexts {
            if isActual(context) { return true }
        }
        return false
    }
}
