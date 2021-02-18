//
//  Collection+.swift
//  BrokerInsuranceModule
//
//  Created by Svyatoshenko "Megal" Misha on 2020-12-21.
//

extension Collection {

    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
