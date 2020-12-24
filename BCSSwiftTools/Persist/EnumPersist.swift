//
//  EnumPersist.swift
//  BCSSwiftTools
//
//  Created by n.leontev on 13.02.2020.
//  Copyright © 2020 alexeyne. All rights reserved.
//

@propertyWrapper
public struct EnumPersist<T: RawRepresentable> {
    public let key: String
    public let defaultValue: T
    
    public var wrappedValue: T {
        get {
            guard let value = UserDefaults.standard.object(forKey: key) as? T.RawValue else {  return defaultValue }
            return T(rawValue: value) ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: key)
        }
    }
    
    public init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
}
