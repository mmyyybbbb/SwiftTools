//
//  NumberFormatter.swift
//  BrokerDomainCore
//
//  Created by Ponomarev Vasiliy on 18/02/2019.
//  Copyright © 2019 BCS. All rights reserved.
//

import Foundation

final public class NumberFormatterBuilder {

    public enum FormatterProperty {
        case currency(String)
        case minFractDigits(Int)
        case maxFractDigits(Int)
    }

    public static var `default`: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle           = .decimal
        formatter.locale                = Locale.current
        formatter.usesGroupingSeparator = true
        formatter.groupingSize          = 3
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }

    public static func build(_ properties: [FormatterProperty]) -> NumberFormatter {
        let formatter = `default`

        for prop in properties {
            switch prop {
            case .currency(let cur):
                guard cur.isEmpty == false else { break }
                formatter.numberStyle = .currency
                formatter.currencySymbol = cur
            case .maxFractDigits(let max):
                formatter.maximumFractionDigits = max
            case .minFractDigits(let min):
                formatter.minimumFractionDigits = min
            }
        }

        return formatter
    }

    public static func build(_ properties: FormatterProperty...) -> NumberFormatter {
        return build(properties)
    }
}
