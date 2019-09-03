//
//  Pluralizer.swift
//  YandexInvestition
//
//  Created by Сергей Климов on 10.09.2018.
//  Copyright © 2018 BCS. All rights reserved.
//

public struct TextCase: Codable {
    public let single: String
    public let plural: String
    public let pluralGenetive: String
    
    public init(single: String, plural: String, pluralGenetive: String) {
        self.single = single
        self.plural = plural
        self.pluralGenetive = pluralGenetive
    }
    
    public init(_ string: String ) {
        self.single = string
        self.pluralGenetive = string
        self.plural = string
    }
    
    public func string(by value: Int) -> String {
        switch value % 10 {
        case 1: return single
        case 2, 3, 4: return plural
        default: return pluralGenetive
        }
    }
}
 
