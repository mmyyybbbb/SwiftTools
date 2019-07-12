//
//  NSDecimalNumber.swift
//  BrokerDomainCore
//
//  Created by alexej_ne on 12.07.2019.
//  Copyright © 2019 BCS. All rights reserved.
//
import Foundation

public extension NSNumber {
    func string(_ formatter: NumberFormatter) -> String {
        return formatter.string(from: self) ?? ""
    }
}

public extension Int {
    func string(_ formatter: NumberFormatter) -> String {
        return formatter.string(from: NSNumber(value: self)) ?? ""
    }
}

public extension Double {
    func string(_ formatter: NumberFormatter) -> String {
        return formatter.string(from: NSNumber(value: self)) ?? ""
    }
}
