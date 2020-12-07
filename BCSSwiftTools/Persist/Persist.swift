//
//  Persist.swift
//  BrokerApp
//
//  Created by alexej_ne on 19.11.2019.
//

@propertyWrapper
public struct Persist<T> {
    public let key: String
    public let defaultValue: T
    
    public var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
    
    public init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
}

@propertyWrapper
public struct PersistOptional<T> {
    public let key: String
    public let defaultValue: T?
    
    public var wrappedValue: T? {
        get {
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            if let newValue = newValue {
                UserDefaults.standard.set(newValue, forKey: key)
            }
        }
    }
    
    public init(key: String, defaultValue: T?) {
        self.key = key
        self.defaultValue = defaultValue
    }
}
