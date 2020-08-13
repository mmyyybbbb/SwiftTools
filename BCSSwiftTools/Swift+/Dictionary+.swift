//
//  Dictionary+.swift
//  BCSSwiftTools
//
//  Created by Alexey Nenastev on 20.07.2020.
//  Copyright © 2020 alexeyne. All rights reserved.
//

import Foundation
 
public func + <K,V>(left: Dictionary<K,V>, right: Dictionary<K,V>) -> Dictionary<K,V> {
    var map = Dictionary<K,V>()
    for (k, v) in left {
        map[k] = v
    }
    for (k, v) in right {
        map[k] = v
    }
    return map
}

public extension Dictionary where Key == String, Value == Any {
    var descriptionString: String {
        guard !self.isEmpty else { return "" }
        var result = ""
        
        for val in self {
            result += "\n \(val.key): \(val.value)"
        }
        return result
    }
}

 public extension Dictionary where Key == String {
    var debugInfo: String {
        var str: String = ""
        
        for (k,v) in self {
            str += "\(k) : \(v)\n"
        }
        
        return str
    }
}
