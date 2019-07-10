//
//  DateFormatterBuilder.swift
//  BrokerDomainCore
//
//  Created by Andrey Raevnev on 13/02/2019.
//  Copyright © 2019 BCS. All rights reserved.
//

import Foundation

public struct DateFormatterBuilder {
    
    static let localeRU = Locale(identifier: "ru_RU")
    
    public static let HHmm       = dateFormatter(.HHmm)
    public static let HHmmss     = dateFormatter(.HHmmss)
    public static let ddMM       = dateFormatter(.ddMM)
    public static let ddMMyy     = dateFormatter(.ddMMyy)
    public static let ddMMyyyy   = dateFormatter(.ddMMyyyy)
    public static let dMMM       = dateFormatter(.dMMM)
    public static let dMMMyyyy   = dateFormatter(.dMMMyyyy)
    public static let ddMMMM     = dateFormatter(.ddMMMM)
    public static let ddMMMMyyyy = dateFormatter(.ddMMMMyyyy)
    public static let dMMMM      = dateFormatter(.dMMMM)
    public static let yyyyMMdd   = dateFormatter(.yyyyMMdd)
    public static let yyyy_MM_dd = dateFormatter(.yyyy_MM_dd)
    public static let isoFull    = dateFormatter(.isoFull)
    
    /**
     Создает форматтер для дат с заданными настройками.
     
     - parameter dateFormat: Строковый формат даты.
     - parameter timeZone: Часовой пояс.
     - parameter locale: Локаль.
     
     - returns: Форматтер DateFormatter.
     */
    public static func dateFormatter(_ dateFormat: String, timeZone: TimeZone = TimeZone.autoupdatingCurrent) -> DateFormatter {
        let formatter = DateFormatter()
        
        formatter.locale     = localeRU
        formatter.timeZone   = timeZone
        formatter.dateFormat = dateFormat
        
        return formatter
    }
    
    /**
     Создает форматтер для дат с заданными настройками.
     
     - parameter dateFormat: Строковый формат даты из заданного набора.
     - parameter timeZone: Часовой пояс.
     - parameter locale: Локаль.
     
     - returns: Форматтер DateFormatter.
     */
    public static func dateFormatter(_ dateFormat: Date.Formats, timeZone: TimeZone = TimeZone.autoupdatingCurrent) -> DateFormatter {
        return dateFormatter(dateFormat.rawValue, timeZone: timeZone)
    }
    
    /**
     Парсит дату в формате ISO8601 и возвращает количество каждой части даты.
     
     - parameter iso8601IntervalParse: Дата в формате ISO8601.
     
     - returns: Части даты: количество лет, месяцев, дней и т.д.
     */
    public static func iso8601IntervalParse(_ isoInterval: String?) -> (years: Int, months: Int, days: Int, hours: Int, minutes: Int, seconds: Int) {
        var years = 0, months = 0, days = 0, hours = 0, minutes = 0, seconds = 0
        
        guard let interval = isoInterval else {
            return (years: years, months: months, days: days, hours: hours, minutes: minutes, seconds: seconds)
        }
        
        var stringValue = ""
        var value       = 0
        
        for char in interval {
            if char == "P" || char == "T" {
                continue;
            }
            
            switch(String(char)) {
            case "Y": years   = value
            case "M": months  = value
            case "D": days    = value
            case "H": hours   = value
            case "m": minutes = value
            case "S": seconds = value
            default:
                guard let _ = Int(String(char)) else { continue }
                
                stringValue += String(char)
                if let v = Int(stringValue) {
                    value = v
                }
            }
        }
        
        return (years: years, months: months, days: days, hours: hours, minutes: minutes, seconds: seconds)
    }
    
    public static func dMMMMHHmmString(from date: Date) -> String {
        return "\(DateFormatterBuilder.dMMMM.string(from: date)), \(DateFormatterBuilder.HHmm.string(from: date))"
    }

    public static func d_MMMMYYYY_HHmmString(from date: Date) -> String {
        return " · \(DateFormatterBuilder.ddMMMMyyyy.string(from: date)) · \(DateFormatterBuilder.HHmm.string(from: date))"
    }
    
    public static func ddMMyyyyHHmmString(from date: Date) -> String {
        return "\(DateFormatterBuilder.ddMMyyyy.string(from: date)), \(DateFormatterBuilder.HHmm.string(from: date))"
    }
}
