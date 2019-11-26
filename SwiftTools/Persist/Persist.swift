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
}
