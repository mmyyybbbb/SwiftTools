//
//  Pluralizer.swift
//  YandexInvestition
//
//  Created by Сергей Климов on 10.09.2018.
//  Copyright © 2018 BCS. All rights reserved.
//

public struct TextCase {
    public let single: String
    public let plural: String
    public let pluralGenetive: String
    
    public init(single: String, plural: String, pluralGenetive: String) {
        self.single = single
        self.plural = plural
        self.pluralGenetive = pluralGenetive
    }
    
    public func string(by value: Int) -> String {
        switch "\(self)".last {
        case "1": return single
        case "2", "3", "4": return pluralGenetive
        default: return plural
        }
    }
}
 
