//
//  String+.swift
//  BrokerDomainCore
//
//  Created by Ponomarev Vasiliy on 18/02/2019.
//  Copyright © 2019 BCS. All rights reserved.
//

import Foundation

public extension String {

    static let cyrillicCharacters = "абвгдеёжзийклмнопрстуфхцчшщьъыэюя"
    static let englishCharacters = "abcdefghijklmnopqrstuvwxyz"
 
    var int: Int {
        if let safeInt = Int(self) {
            return safeInt
        } else {
            return 0
        }
    }
 
    var intOrNil: Int? {
        return Int(self)
    }
 
    static var empty: String { return "" }

    /**
     Оставляет в текущей строки только цифры.

     - returns: Отформатированное значение в виде строки.
     */
    var onlyNumeric: String {
        return self.reduce("") { (acc, c) -> String in
            guard c.isDigit() else { return acc }
            return "\(acc)\(c)"
        }
    }
 
    /**
     Набор возможных форматов строки (например, номер телефона, инн и т.п.).
     */
    enum Format: String {
        case phone = "+7 (***) ***-**-**"
        case inn = "************"
        case snils = "***-***-*** **"
        case subdivision = "***-***"
        case date = "**.**.****"
        case passportSeriesNumber = "**** ******"
        case creditCard = "**** **** **** ****"
        case issueDate = "**/**"
        case cvc = "***"
        case code5symbols = "*****"
        case code6symbols = "******"

        public var placeholderValue: String {
            switch self {
            case .phone : return "+7 "
            default     : return ""
            }
        }

        public func extractValue(_ str: String) -> String {
            switch self {
            case .phone: return str.onlyNumeric
            default: return str
            }
        }
    }

    /**
     Приводит текущую строку к заданному формату из набора.

     - parameter format: Формат строки из набора.

     - returns: Отформатированное значение в виде строки.
     */
    func convertAs(_ format: Format) -> String {
        return convertNumberWith(format: format.rawValue)
    }

    /**
     Приводит текущую строку к стандартному формату номера телефона.

     - returns: Отформатированное значение в виде строки.
     */
    var phoneFormatted:  String {
        return self.convertNumberWith(format: "+7 (***) ***-**-**")
    }
 
    /**
     Приводит текущую строку к заданному формату.

     - parameter format: Формат строки.
     - parameter replacementChar: Символ для замены.

     - returns: Результирующая строка.
     */
    func convertNumberWith(format: String = "** **-** **", replacementChar: Character = "*") -> String {
        var stringToProcess = self.onlyNumeric
        var resultString = ""

        for ch in format {
            guard !stringToProcess.isEmpty else { break }

            if ch == replacementChar || ch == stringToProcess[stringToProcess.startIndex] {
                let digitToInut = stringToProcess.remove(at: stringToProcess.startIndex)
                resultString.append(digitToInut)
            } else {
                resultString.append(ch)
            }
        }
        return resultString
    }

    /**
     Преобразует текущую строку в дату по заданному формату.

     - parameter format: Формат даты.

     - returns: Полученная дата или nil.
     */
    func date(format: Date.Formats) -> Date? {
        return DateFormatterBuilder.dateFormatter(format).date(from: self)
    }

    /**
     Определяет, содержит ли текущая строка символы кириллицы + дополнительные символы из параметра.

     - returns: Значение типа Bool.
     */
    func isCyrillicWith(additional symbols: String?) -> Bool {
        let cyrillic = String.cyrillicCharacters + (symbols ?? "")

        for sym in self.lowercased() {
            if !cyrillic.contains(sym) {
                return false
            }
        }

        return true
    }

    /**
     Определяет, содержит ли текущая строка английские символы + дополнительные символы из параметра.

     - returns: Значение типа Bool.
     */
    func isEnglishWith(additional symbols: String?) -> Bool {
        let english = String.englishCharacters + (symbols ?? "")

        for sym in self {
            if !english.contains(String(sym).lowercased()) {
                return false
            }
        }

        return true
    }

    /**
     Удаляет из текущей строки все заданные символы.

     - parameter characters: Набор символов, которые подлежат удалению.

     - returns: Очищенная строка.
     */
    func remove(_ characters: [Character]) -> String {
        return String(self.filter({ !characters.contains($0) }))
    }

    /**
     Удаляет из текущей строки все заданные подстроки.

     - parameter subStrings: Набор подстрок, которые подлежат удалению.

     - returns: Очищенная строка.
     */
    func remove(_ subStrings: [String]) -> String {
        var resultString = self
        _ = subStrings.map { resultString = resultString.replacingOccurrences(of: $0, with: "") }
        return resultString
    }

    /**
     Удаляет из текущей строки все заданные символы.

     - parameter characters: Набор символов, которые подлежат удалению.

     - returns: Очищенная строка.
     */
    func remove(_ characters: CharacterSet) -> String {
        return components(separatedBy: characters).joined(separator: "")
    }

    /**
     Заменяет в текущей строке все заданные подстроки на указанную строку.

     - parameter subStrings: Набор подстрок, которые подлежат замене.
     - parameter withString: Строка, на которую нужно заменить подстроки.

     - returns: Очищенная строка.
     */
    func replace(_ subStrings: [String], with strings: String) -> String {
        var resultString = self
        _ = subStrings.map { resultString = resultString.replacingOccurrences(of: $0, with: strings) }
        return resultString
    }

    /**
     Очищает строку для дальнейшего корректного преобразования в Decimal.

     - returns: Очищенная строка.
     */
    func cleanForDecimal() -> String {
        let text = self

        let s1 = text.trimmingCharacters(in: .whitespaces)
        let s2 = s1.replacingOccurrences(of: " ", with: "")
        let s3 = s2.replacingOccurrences(of: "\u{00a0}", with: "")
        let s4 = s3.replacingOccurrences(of: ",", with: ".")

        return s4
    }

    /**
     Удаляет из строки незначящие нули.

     - returns: Очищенная строка.
     */
    func removeInsignificantZeros() -> String {
        var outputString = self
        let reversedString = outputString.reversed()

        for char in reversedString {
            if char == "0" {
                outputString = String(outputString.dropLast())
            } else if char == "," {
                outputString = String(outputString.dropLast())
                break
            } else {
                break
            }
        }

        return outputString
    }

    /**
     Делает заглавной первой букву в текущей строке.

     - returns: Преобразованная строка.
     */
    func capitalizeFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst().lowercased()
    }

    /**
     Делает заглавной первой букву в текущей строке.

     - returns: Преобразованная строка.
     */
    mutating func capitalizeFirst() {
        self = capitalizeFirstLetter()
    }

    /**
     Формирует атрибутную строку с заданным набором атрибутов.

     - parameter attributes: Набор атрибутов.

     - returns: Атрибутная строка.
     */
    func attributed(by attributes: [NSAttributedString.Key: Any]?) -> NSAttributedString {
        return NSAttributedString(string: self, attributes: attributes)
    }

 
    /**
     Заменяет в текущей строке все символы пробелов на символы неразрывного пробела.

     - returns: Преобразованная строка.
     */
    func nonBreaking() -> String {
        return replacingOccurrences(of: " ", with: "\u{00a0}")
    }

    /**
     Убирает из текущей строки все символы пунктуации.

     - returns: Преобразованная строка.
     */
    func clearOfPunctuation() -> String {
        return replacingOccurrences(of: " ", with: "")
            .replacingOccurrences(of: "(", with: "")
            .replacingOccurrences(of: ")", with: "")
            .replacingOccurrences(of: ",", with: "")
            .replacingOccurrences(of: ".", with: "")
            .replacingOccurrences(of: "-", with: "")
            .replacingOccurrences(of: "\u{00a0}", with: "")
    }

    /**
     Вычисляет ширину текущей строки.

     - parameter attributes: Набор атрибутов строки.
     - parameter height: Высота строки.

     - returns: Размер в формате CGSize.
     */
    func width(attributes: [NSAttributedString.Key: Any], height: CGFloat) -> CGSize {
        let sizeToFit = CGSize(width: CGFloat.leastNormalMagnitude, height: height)
        let label = UILabel()
        label.numberOfLines = 1
        label.attributedText = self.attributed(by: attributes)
        var size = label.sizeThatFits(sizeToFit)
        size.height = height
        return size
    }

    /**
     Подсчет высоты строки при заданной ширине.

     - parameter width: ширина строки.
     */
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)

        return ceil(boundingBox.height)
    }
 
    // swiftlint:disable all
    var isCorrectPhoneNumberLength: Bool {
        return self.count == 11
    }

    func removeHTMLTag() -> String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: String.CompareOptions.regularExpression, range: nil)
    }
    
    func index<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> Index? {
        range(of: string, options: options)?.lowerBound
    }
    func endIndex<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> Index? {
        range(of: string, options: options)?.upperBound
    }
    func indices<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> [Index] {
        var indices: [Index] = []
        var startIndex = self.startIndex
        while startIndex < endIndex,
            let range = self[startIndex...]
                .range(of: string, options: options) {
                indices.append(range.lowerBound)
                startIndex = range.lowerBound < range.upperBound ? range.upperBound :
                    index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
        }
        return indices
    }
    func ranges<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> [Range<Index>] {
        var result: [Range<Index>] = []
        var startIndex = self.startIndex
        while startIndex < endIndex,
            let range = self[startIndex...]
                .range(of: string, options: options) {
                result.append(range)
                startIndex = range.lowerBound < range.upperBound ? range.upperBound :
                    index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
        }
        return result
    }
}
