//
//  NSDecimalNumber+.swift
//  Alamofire
//
//  Created by Andrey Raevnev on 07/03/2019.
//

public extension NSDecimalNumber {
    var fractionDigitsCount: Int {
        return self.decimalValue.significantFractionalDecimalDigits
    }
    var absoluteValue: NSDecimalNumber {
        if self.compare(NSDecimalNumber.zero) == .orderedAscending {
            let negativeValue = NSDecimalNumber(mantissa: 1, exponent: 0, isNegative: true)
            return self.multiplying(by: negativeValue)
        } else {
            return self
        }
    }
}


public extension NSDecimalNumber {
    static var defaultPriceStep: NSDecimalNumber {
        return NSDecimalNumber(value: 0.01)
    }
}
