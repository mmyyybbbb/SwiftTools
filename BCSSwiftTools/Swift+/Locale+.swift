//
//  Locale+.swift
//  BrokerDomainCore
//
//  Created by Andrey Raevnev on 13/02/2019.
//  Copyright © 2019 BCS. All rights reserved.
//

extension Locale {
    public static var `default`: Locale {
        return Locale(identifier: "en_US_POSIX")
    }
    
    public static var ru: Locale {
        return Locale(identifier: "ru_RU")
    }
}
