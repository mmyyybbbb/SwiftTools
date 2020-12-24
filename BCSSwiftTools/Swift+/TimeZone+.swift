//
//  TimeZone+.swift
//  BrokerDomainCore
//
//  Created by Andrey Raevnev on 13/02/2019.
//  Copyright © 2019 BCS. All rights reserved.
//

import Foundation

public extension TimeZone {
    
    /**
     Тайм зона UTC+04:00.
     */
    static var plus4utc: TimeZone { TimeZone(identifier: "UTC+04:00")! }
    
    /**
     Тайм зона GMT.
     */
    static var gmt: TimeZone { TimeZone(identifier: "GMT")! }
    
    /**
     Тайм зона UTC.
     */
    static var utc: TimeZone { TimeZone(identifier: "UTC")! }
    
    /**
    Тайм зона Москва.
    */
    static let msk = TimeZone(identifier: "Europe/Moscow")!
}
