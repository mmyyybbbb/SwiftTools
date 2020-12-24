//
//  Data+.swift
//  BCSSwiftTools
//
//  Created by Alexey Nenastev on 20.07.2020.
//  Copyright © 2020 alexeyne. All rights reserved.
//

 
public extension Data {
    var prettyPrintedJSONString: NSString? { /// NSString gives us a nice sanitized debugDescription
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }

        return prettyPrintedString
    }
}
