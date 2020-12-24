//
//  Decimal+.swift
//  Alamofire
//
//  Created by Andrey Raevnev on 07/03/2019.
//

import Foundation

public extension Decimal {
    var significantFractionalDecimalDigits: Int {
        return max(-exponent, 0)
    }
}
