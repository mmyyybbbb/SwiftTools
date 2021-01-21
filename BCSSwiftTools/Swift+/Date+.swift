//
//  Date+.swift
//  BrokerDomainCore
//
//  Created by Andrey Raevnev on 13/02/2019.
//  Copyright © 2019 BCS. All rights reserved.
//

public extension Date {
    
    /**
     Возможные форматы дат.
     */
    enum Formats: String {
        case HHmm               = "HH:mm"
        case HHmmss             = "HH:mm:ss"
        case HHmmddMMyyyy       = "HH:mm dd.MM.yy"
        
        case ddMM               = "dd.MM"
        case ddMMyy             = "dd.MM.yy"
        case ddMMyyyy           = "dd.MM.yyyy"
        case ddMMyyyyг          = "dd.MM.yyyyг."
        case ddMMyyyyHHmm       = "dd.MM.yyyy (HH:mmмск)"
        case ddMMyyyyHHmmss     = "dd.MM.yyyy HH:mm:ss"
        case ddMMyyyyHHmmssZZZ  = "dd.MM.YY HH:mm:ss.SS ZZZZZ"
        case ddMMyyyyPHHmm      = "dd.MM.yyyy, HH:mm"
        case ddMMyyHHmm         = "dd.MM.yy HH:mm"
        case ddMMyyPHHmm        = "dd.MM.yy, HH:mm"
        
        case dMMM               = "d MMM"
        case dMMMyyyy           = "d MMM, yyyy"
        /// dMMMyyyy без запятой. WP - without point
        case dMMMWPyyyy         = "d MMM yyyy"
        case dMMMHHmm           = "d MMM HH:mm"
        
        case ddMMMM             = "dd MMMM"
        case ddMMMMyyyy         = "dd MMMM yyyy"
        case dMMMM              = "d MMMM"
        case dMMMMyyyy          = "d MMMM, yyyy"
        
        case dMMMMyyyyInHHMM    = "d.MM.YYYY в HH:mm"
        case ddMMMMyyyyInHHMM   = "dd.MM.YYYY в HH:mm"
        
        case MMMMyyyy           = "MMMM yyyy"
        case mm_dd_yyyy         = "mm-dd-yyyy"
        
        case dd                 = "dd"
        case MMM                = "MMM"
        case MMMM               = "MMMM"
        case yyyy               = "yyyy"
        case LLLL               = "LLLL"
        
        case yyyyMMdd           = "yyyyMMdd"
        case yyyy_MM_dd         = "yyyy-MM-dd"
        
        case MMddyyyyHHmmss     = "MM/dd/yyyy HH:mm:ss"
        
        case iso8601            = "yyyy-MM-dd'T'HH:mm:ss"
        case iso8601Z           = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        case iso8601ZZZ         = "yyyy-MM-dd'T'HH:mm:ssZZZ"
        case isoFull            = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        case relative           = "relative"
    }
    
    /**
     Возвращает начало текущего дня для текущей даты.
     */
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    /**
     Возвращает конец дня для текущей даты.
     */
    var endOfDay: Date? {
        var components = DateComponents()
        components.day    = 1
        components.second = -1
        return (Calendar.current as NSCalendar).date(byAdding: components, to: startOfDay, options: NSCalendar.Options())
    }
    
    ///Предыдущий день.
    
    var previousDay: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: self) ?? self
    }
    
    ///Предыдущий месяц.
    
    var previousMonth: Date {
        return Calendar.current.date(byAdding: .month, value: -1, to: self) ?? self
    }
    
    ///Предыдущий год.
    
    var previousYear: Date {
        return Calendar.current.date(byAdding: .year, value: -1, to: self) ?? self
    }
    
    ///Число дней в месяце
    
    var countDaysInMonth: Int {
        guard let interval = Calendar.current.dateInterval(of: .month, for: self),
            let days = Calendar.current.dateComponents([.day], from: interval.start, to: interval.end).day else { return 0 }
        
        return days
    }
    
    var shortMonthName: String {
        guard let month = self.string(.MMMM).substring(from: 0, length: 3) else { return "" }
        var shortMonth = month.capitalizeFirstLetter()
        /// Если май то пишем ручками
        if Calendar.current.dateComponents([.month], from: self).month == 5 { shortMonth = "Май" }
        return shortMonth
    }
    
    /**
     Текущая дата.
     */
    static var today: Date {
        return Date()
    }
    
    /**
     Вчерашний день.
     */
    static var yesterday: Date {
        return today.dateByAdding(.day, value: -1) ?? today
    }
    
    /**
     Неделя назад.
     */
    static var weekAgo: Date {
        return today.dateByAdding(.day, value: -6) ?? today
    }
    
    /**
     Месяц назад.
     */
    static var monthAgo: Date {
        return today.dateByAdding(.month, value: -1) ?? today
    }
    
    /**
     Год назад.
     */
    static var yearAgo: Date {
        return today.dateByAdding(.year, value: -1) ?? today
    }
    
    /**
     Текущий год.
     */
    static func currentYear() -> String {
        return DateFormatterBuilder.dateFormatter(.yyyy, timeZone: .utc).string(from: Date())
    }
    
    /**
    Дата из компонентов.
    
    - parameter day: День
    - parameter month: Месяц
    - parameter year: Год
    
    - returns: Дата.
    */
    
    static func fromComponents(day: Int? = nil, month: Int? = nil, year: Int? = nil) -> Date {
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        
        return Calendar.current.date(from: components) ?? Date()
    }
    
    /**
     Вычисляет дату от текущей, используя unit и их количество.
     
     - parameter unit: Компонент календаря (день, месяц, час и т.д.).
     - parameter value: Значение для unit.
     
     - returns: Дата или nil.
     */
    func dateByAdding(_ unit: Calendar.Component, value: Int) -> Date? {
        return Calendar.current.date(byAdding: unit, value: value, to: self)
    }
    
    /**
     Вычисляет дату от текущей, используя unit и их количество, и представляет ее в формате ISO8601.
     
     - parameter unit: Компонент календаря (день, месяц, час и т.д.).
     - parameter value: Значение для unit.
     
     - returns: Строка в ISO8601.
     */
    func fullDateByAdding(_ unit: Calendar.Component, value: Int) -> String {
        guard let dateAgo = dateByAdding(unit, value: value) else { return "" }
        
        return DateFormatterBuilder.isoFull.string(from: dateAgo)
    }
    
    /**
     Вычисляет дату от текущей, используя unit и их количество, и представляет ее в коротком формате.
     
     - parameter unit: Компонент календаря (день, месяц, час и т.д.).
     - parameter value: Значение для unit.
     
     - returns: Строка в формате yyyy-MM-dd.
     */
    func shortDateByAdding(_ unit: Calendar.Component, value: Int) -> String {
        guard let dateAgo = dateByAdding(unit, value: value) else { return "" }
        
        return DateFormatterBuilder.yyyy_MM_dd.string(from: dateAgo)
    }
    
    func string(_ format: Formats, timeZone: TimeZone = TimeZone.autoupdatingCurrent) -> String {
        if case .relative = format {
            return self.relative(.day)
        }
        
        return DateFormatterBuilder.dateFormatter(format, timeZone: timeZone).string(from: self)
    }
    
    /**
     Получает текущую дату в миллисекундах.
     
     - returns: Количество миллисекунд.
     */
    func toMillis() -> Double {
        return timeIntervalSince1970 * 1000
    }
    
    /**
     Определяет, что текущая дата больше, чем передаваемая.
     
     - parameter dateToCompare: Дата, с которой нужно сравнить текущую.
     
     - returns: Значение типа Bool.
     */
    func isGreaterThanDate(_ dateToCompare : Date) -> Bool {
        if self.compare(dateToCompare) == ComparisonResult.orderedDescending {
            return true
        }
        
        return false
    }
    
    /**
     Определяет, является ли текущая дата текущим днем.
     
     - returns: Значение типа Bool.
     */
    func isToday() -> Bool {
        let today = (Calendar.current as NSCalendar).components([.year, .month, .day], from: Date())
        let comps = (Calendar.current as NSCalendar).components([.year, .month, .day], from: self)
        if comps.year == today.year && comps.month == today.month && comps.day == today.day {
            return true
        }
        return false
    }
    
    /**
     Определяет, что текущая дата менее месяца назад.
     
     - returns: Значение типа Bool.
     */
    func isMonthAgoOrLess() -> Bool {
        let monthAgoDate = Date().dateByAdding(.day, value: -30)
        return monthAgoDate!.compare(self) == .orderedAscending
    }
    
    /**
     Возвращает первый день в году.
     
     - returns: Первый день в году в виде даты или nil.
     */
    func firstDayOfYear() -> Date? {
        var components = Calendar.current.dateComponents([.day, .month, .year], from: self)
        components.setValue(1, for: .month)
        components.setValue(1, for: .day)
        return Calendar.current.date(from: components)
    }
    
    /**
     Вычисляет количество дней в году.
     
     - returns: Количество дней.
     */
    func daysInYear() -> Int {
        let calendar = Calendar.current
        let year = calendar.component(.year, from: self)
        
        if year%100 != 0 && year%4 == 0 || year%400 == 0 {
            return 366
        } else {
            return 365
        }
    }
    
    /**
     Вычисляет количество дней, прошедгих с начала года.
     
     - returns: Количество дней.
     */
    func passDaysInYear() -> Int {
        let cal = Calendar.current
        let days = cal.ordinality(of: .day, in: .year, for: self)
        
        if let numberOfCurrentDay = days {
            return numberOfCurrentDay
        } else {
            return 0
        }
    }
    
    /**
    Вычисляет интервал между двумя датами в заданных еденицах
    
    - returns: Количество секунд/часов/дней и т.д.
    */
    func interval(ofComponent comp: Calendar.Component, fromDate date: Date) -> Int {

        let currentCalendar = Calendar.current

        guard let start = currentCalendar.ordinality(of: comp, in: .era, for: date) else { return 0 }
        guard let end = currentCalendar.ordinality(of: comp, in: .era, for: self) else { return 0 }

        return end - start
    }
    
}

// MARK: Relative

public enum DateAccuracyType: String {
    case day
    case dayShort
    case minute
    case minuteShort
    case seconds
    case quoteTime
}

public extension Date {
    
    enum RelativeDateFormat {
        case today
        case yesterday
        case thisYear
        case yearAgo
    }
    
    /**
     Формирует человекопонятное представление для даты.
     
     - parameter accuracy: Точность представления.
     
     - returns: Строка представления даты.
     */
    func relative(_ accuracy: DateAccuracyType) -> String {
        let type = relativeType
        
        switch accuracy {
        case .day:
            return relativeDay(relativeType: type)
        case .dayShort:
            return relativeDay(relativeType: type, short: true)
        case .minute:
            return relativeMinute(relativeType: type)
        case .minuteShort:
            return relativeMinute(relativeType: type, short: true)
        case .seconds:
            return relativeSecond(relativeType: type)
        case .quoteTime:
            return relativeQuoteTime(relativeType: type)
        }
    }
    
    var relativeType: RelativeDateFormat {
        let calendar = Calendar.current
        let components        = calendar.dateComponents([.second, .minute, .hour, .day, .month, .year], from: self)
        let componentsNowDate = calendar.dateComponents([.second, .minute, .hour, .day, .month, .year], from: Date())
        
        if components.day == componentsNowDate.day && components.month == componentsNowDate.month && components.year == componentsNowDate.year {
            return .today
        } else if (componentsNowDate.day! - components.day!) == 1 && components.month == componentsNowDate.month && components.year == componentsNowDate.year {
            return .yesterday
        } else if components.year! < componentsNowDate.year! {
            return .yearAgo
        } else {
            return .thisYear
        }
    }
    
    private func relativeDay(relativeType: RelativeDateFormat, short: Bool = false) -> String {
        switch relativeType {
        case .today:
            return "Сегодня"
        case .yesterday:
            return "Вчера"
        case .thisYear:
            return DateFormatterBuilder.dateFormatter(short ? .dMMM : .dMMMM).string(from: self)
        case .yearAgo:
            return DateFormatterBuilder.dateFormatter(short ? .dMMMyyyy : .dMMMMyyyy).string(from: self)
        }
    }
    
    private func relativeMinute(relativeType: RelativeDateFormat, short: Bool = false) -> String {
        switch relativeType {
        case .today:
            return "Сегодня, \(DateFormatterBuilder.HHmm.string(from: self))"
        case .yesterday:
            return "Вчера, \(DateFormatterBuilder.HHmm.string(from: self))"
        case .thisYear:
            return "\(DateFormatterBuilder.dateFormatter(short ? .dMMM : .dMMMM).string(from: self)), \(DateFormatterBuilder.dateFormatter(.HHmm).string(from: self))"
        case .yearAgo:
            return "\(DateFormatterBuilder.dateFormatter(short ? .dMMMyyyy : .dMMMMyyyy).string(from: self)) \(DateFormatterBuilder.dateFormatter(.HHmm).string(from: self))"
        }
    }
    
    private func relativeSecond(relativeType: RelativeDateFormat) -> String {
        switch relativeType {
        case .today:
            return "Сегодня в \(DateFormatterBuilder.HHmmss.string(from: self))"
        case .yesterday:
            return "Вчера в \(DateFormatterBuilder.HHmmss.string(from: self))"
        case .thisYear, .yearAgo:
            return "\(DateFormatterBuilder.dateFormatter(.ddMMyy).string(from: self)) \(DateFormatterBuilder.dateFormatter(.HHmmss).string(from: self))"
        }
    }
    
    private func relativeQuoteTime(relativeType: RelativeDateFormat) -> String {
        switch relativeType {
        case .today:
            return DateFormatterBuilder.HHmmss.string(from: self)
        case .yesterday:
            return "Вчера, \(DateFormatterBuilder.HHmmss.string(from: self))"
        default:
            return "\(DateFormatterBuilder.dateFormatter(.dMMM).string(from: self)), \(DateFormatterBuilder.dateFormatter(.HHmmss).string(from: self))"
        }
    }
    
    /**
     Проверка входит ли время в интервал времен
     
     - parameter start: Время начала интервала в формате HH:mm
     - parameter end: Время конца интервала в формате HH:mm
     - parameter timezone: Часовой пояс. По умолчанию Москва

     - returns: Результат проверки
     */
    func inTimeInterval(start: String, end: String, timezone: TimeZone = .msk) -> Bool {
        
        let formatterTime = DateFormatter()
        formatterTime.timeZone = timezone
        formatterTime.dateFormat = "HH:mm"
        let timeNow = formatterTime.string(from: self)

        return timeNow >= start && timeNow < end
    }
}
