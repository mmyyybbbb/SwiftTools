//
//  Validator.swift
//  BrokerDomainCore
//
//  Created by Ponomarev Vasiliy on 20/05/2019.
//  Copyright © 2019 BCS. All rights reserved.
//

import Foundation

public typealias ValidationError = String
public typealias Password = String

typealias Validator<T> = (T) -> ValidationError?

public struct Validation {

    public static func checkIsEmptyString(_ value: String, errMessage: String = "") -> ValidationError? {
        return !value.isEmpty ? nil : errMessage
    }

    public static func checkIsValidEmail(_ value: String, errMessage: String = "") -> ValidationError? {
        return value.isValidEmail() ? nil : errMessage
    }

    public static func checkIsValidPassportSeriesAndNumber(_ value: String, errMessage: String = "") -> ValidationError? {
        return value.isValidPassportSeriesAndNumber() ? nil : errMessage
    }

    public static func checkIsValidDateddMMyyyy(_ value: String, errMessage: String = "") -> ValidationError? {
        return value.isValidDateddMMyyyy() ? nil : errMessage
    }

    public static func checkIsValidPastDateddMMyyyy(_ value: String, errMessage: String = "") -> ValidationError? {
        if let date = value.date(format: .ddMMyyyy), date.isGreaterThanDate(Date.today) {
            return errMessage
        }
        return value.isValidDateddMMyyyy() ? nil : errMessage
    }

    public static func checkIsValidDate18yo(_ value: String, errMessage: String = "") -> ValidationError? {
        if let date = value.date(format: .ddMMyyyy),
            let maximumDate = Date.today.dateByAdding(Calendar.Component.year, value: -18),
            date.isGreaterThanDate(maximumDate) {
            return errMessage
        }
        return nil
    }

    public static func checkIsValidDate18yo(_ date: Date?, errMessage: String = "") -> ValidationError? {
        if let date = date, let maximumDate = Date.today.dateByAdding(Calendar.Component.year, value: -18),
            date.isGreaterThanDate(maximumDate) {
            return errMessage
        }
        return nil
    }

    public static func checkIsValidPassportIssueId(_ value: String, errMessage: String = "") -> ValidationError? {
        return value.isValidPassportIssueId() ? nil : errMessage
    }


}
