//
//  String+Validation.swift
//  BrokerDomainCore
//
//  Created by Ponomarev Vasiliy on 20/05/2019.
//  Copyright © 2019 BCS. All rights reserved.
//

public extension String {

    /**
     Проверяет, соответствует ли текущая строка правилам формирования сложного пароля.

     - returns: Значение типа Bool.
     */
    func validateHardPassword() -> Bool {
        let uppercaseRegExp     = ".*[A-Z]+.*"
        let uppercaseTest       = NSPredicate(format: "SELF MATCHES %@", uppercaseRegExp)
        let containsUppercase   = uppercaseTest.evaluate(with: self)

        let lowercaseRegExp     = ".*[a-z]+.*"
        let lowercaseTest       = NSPredicate(format: "SELF MATCHES %@", lowercaseRegExp)
        let containsLowercase   = lowercaseTest.evaluate(with: self)

        let numberRegExp        = ".*[0-9]+.*"
        let numberTest          = NSPredicate(format: "SELF MATCHES %@", numberRegExp)
        let containsNumber      = numberTest.evaluate(with: self)

        let correctLength = count >= 8

        return containsUppercase && containsLowercase && containsNumber && correctLength
    }

    /**
     Проверяет, соответствует ли текущая строка правилам формирования e-mail.

     - returns: Значение типа Bool.
     */
    func isValidEmail() -> Bool {
        let emailRegEx = "[a-zA-Z0-9\\+\\.\\_\\%\\-\\+]{1,256}\\@[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}(\\.[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25})+"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }

    func isValidPassportSeriesAndNumber() -> Bool {
        let regEx = "[0-9]{4}+ [0-9]{6}"
        let regExTest = NSPredicate(format: "SELF MATCHES %@", regEx)
        return regExTest.evaluate(with: self)
    }

    func isValidDateddMMyyyy() -> Bool {
        let regEx = "[0-9]{2}+.[0-9]{2}+.[0-9]{4}"
        let regExTest = NSPredicate(format: "SELF MATCHES %@", regEx)
        return regExTest.evaluate(with: self)
    }

    func isValidPassportIssueId() -> Bool {
        let regEx = "[0-9]{3}+-[0-9]{3}"
        let regExTest = NSPredicate(format: "SELF MATCHES %@", regEx)
        return regExTest.evaluate(with: self)
    }

}
