//
//  CommandLine+.swift
//  SwiftTools
//
//  Created by alexej_ne on 10.12.2019.
//  Copyright © 2019 alexeyne. All rights reserved.
//

public extension CommandLine {
    static func exist(_ str: String) -> Bool {
        for argument in CommandLine.arguments {
            if argument.contains(str) {
                return true
            }
        }
        return false
    }
    
    static func value(for str: String) -> String? {
        for argument in CommandLine.arguments {
            if argument.contains(str) {
                guard let substring = argument.split(separator: "=").last else { return nil }
                return String(substring)
            }
        }
        return nil
    }
}
