//
//  Character+.swift
//  BrokerDomainCore
//
//  Created by Ponomarev Vasiliy on 18/02/2019.
//  Copyright © 2019 BCS. All rights reserved.
//

import Foundation

public extension Character {

    /**
     Проверяет, что текущий символ является цифрой.

     - returns: Значение типа Bool.
     */
    func isDigit() -> Bool {
        let s = String(self).unicodeScalars
        let uni = s[s.startIndex]

        return NSCharacterSet.decimalDigits.contains(uni)
    }

    /**
     Проверяет, что текущий символ записан в нижнем регистре.

     - returns: Значение типа Bool.
     */
    func isLowercasedLetter() -> Bool {
        let str = String(self)
        guard str.rangeOfCharacter(from: .letters) != nil else { return false }
        return str.lowercased() == str
    }

    /**
     Проверяет, что текущий символ записан в верхнем регистре.

     - returns: Значение типа Bool.
     */
    func isUppercasedLetter() -> Bool {
        let str = String(self)
        guard str.rangeOfCharacter(from: .letters) != nil else { return false }
        return str.uppercased() == str
    }
}
