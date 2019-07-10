//
//  Optional+String.swift
//  SwiftTools
//
//  Created by alexej_ne on 10.07.2019.
//  Copyright © 2019 alexeyne. All rights reserved.
//

public extension Optional where Wrapped == String {
    var valueOrEmpty: String {
        if let val = self {  return val  }
        return .empty
    }
    
    var stringOrEmpty: String {
        return self ?? ""
    }
    
    var isNullOrEmpty: Bool {
        return self == nil || self!.isEmpty
    }
}
