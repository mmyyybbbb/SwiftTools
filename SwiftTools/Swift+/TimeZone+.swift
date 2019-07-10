//
//  TimeZone+.swift
//  BrokerDomainCore
//
//  Created by Andrey Raevnev on 13/02/2019.
//  Copyright © 2019 BCS. All rights reserved.
//

public extension TimeZone {
    
    /**
     Тайм зона UTC+04:00.
     */
    static var plus4utc: TimeZone {
        return TimeZone(identifier: "UTC+04:00")!
    }
    
    /**
     Тайм зона GMT.
     */
    static var gmt: TimeZone {
        return TimeZone(identifier: "GMT")!
    }
    
    /**
     Тайм зона UTC.
     */
    static var utc: TimeZone {
        return TimeZone(identifier: "UTC")!
    }
}
