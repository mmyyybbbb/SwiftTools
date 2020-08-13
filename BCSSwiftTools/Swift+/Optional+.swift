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
    
    var hasValue: Bool {
        return isNullOrEmpty == false
    }
}

public extension Optional where Wrapped == Double {
    var orZero: Double {  return self ?? 0  }
    var orOne: Double {  return self ?? 1  }
}

public extension Optional where Wrapped == Int {
    var orZero: Int {  return self ?? 0  }
    var orOne: Int {  return self ?? 1  }
}

public extension Optional where Wrapped == String {
    var orEmpty: String {  return self ?? ""  }
}

public extension Optional where Wrapped == Int {
    var string: String {
        guard let val = self else { return "" }
        return val.string
    }
}
