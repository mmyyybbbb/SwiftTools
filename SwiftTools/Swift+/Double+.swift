//
//  Double+.swift
//  BrokerDomainCore
//
//  Created by Ponomarev Vasiliy on 18/02/2019.
//  Copyright © 2019 BCS. All rights reserved.
//

import Foundation

public extension Double {

    var fractionalDigitsCount: Int {
        return nsDecimal.decimalValue.significantFractionalDecimalDigits
    }
    
    /**
     Округляет текущее значение до указанного количества знаков после запятой.

     - parameter places: Количество знаков после запятой.

     - returns: Округленное значение.
     */
    func roundToPlaces(_ places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }

    /**
     Применяет указанный форматтер и возвращает значение в виде строки.

     - parameter formatter: Форматтер типа NumberFormatter.

     - returns: Отформатированное значение в виде строки.
     */
    func applyFormatter(_ formatter: NumberFormatter) -> String {
        // swiftlint:disable all
        guard let res =  formatter.string(from: NSNumber(floatLiteral: self)) else { return "" }
        return res
    }

    /**
     Применяет указанный набор типов форматтеров и возвращает значение в виде строки.

     - parameter props: Набор форматтеров типа NumberFormatterBuilder.FormatterProperty.

     - returns: Отформатированное значение в виде строки.
     */
    func string(_ props: NumberFormatterBuilder.FormatterProperty...) -> String {
        let formatter = NumberFormatterBuilder.build(props)
        return applyFormatter(formatter)
    }

    /**
     Преобразует текущее значение в тип NSDecimalNumber.
     */
    var nsDecimal: NSDecimalNumber {
        return NSDecimalNumber(value: self)
    }

    /**
     Преобразует текущее значение в тип String.
     */
    var stringValue: String {
        return "\(self)"
    }
}
