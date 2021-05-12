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
        let emailRegEx = "^([^\\x00-\\x20\\x22\\x28\\x29\\x2c\\x2e\\x3a-\\x3c\\x3e\\x40\\x5b-\\x5d\\x7f-\\xff]+|\\x22([^\\x0d\\x22\\x5c\\x80-\\xff]|\\x5c[\\x00-\\x7f])*\\x22)(\\x2e([^\\x00-\\x20\\x22\\x28\\x29\\x2c\\x2e\\x3a-\\x3c\\x3e\\x40\\x5b-\\x5d\\x7f-\\xff]+|\\x22([^\\x0d\\x22\\x5c\\x80-\\xff]|\\x5c[\\x00-\\x7f])*\\x22))*\\x40([^\\x00-\\x20\\x22\\x28\\x29\\x2c\\x2e\\x3a-\\x3c\\x3e\\x40\\x5b-\\x5d\\x7f-\\xff]+|\\x5b([^\\x0d\\x5b-\\x5d\\x80-\\xff]|\\x5c[\\x00-\\x7f])*\\x5d)(\\x2e([^\\x00-\\x20\\x22\\x28\\x29\\x2c\\x2e\\x3a-\\x3c\\x3e\\x40\\x5b-\\x5d\\x7f-\\xff]+|\\x5b([^\\x0d\\x5b-\\x5d\\x80-\\xff]|\\x5c[\\x00-\\x7f])*\\x5d))*$"
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
