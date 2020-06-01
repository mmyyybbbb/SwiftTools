//
//  Dictionary+concat.swift
//  BrokerDomainCore
//
//  Created by Andrey Raevnev on 09/07/2019.
//  Copyright © 2019 BCS. All rights reserved.
//

import Foundation

public func += <K, V> (left: inout [K:V], right: [K:V]) {
    for (k, v) in right {
        left[k] = v
    }
}
