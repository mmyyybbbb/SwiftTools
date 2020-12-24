//
//  UIImage+.swift
//  BCSSwiftTools
//
//  Created by Alexey Nenastev on 15.05.2020.
//  Copyright © 2020 alexeyne. All rights reserved.
//

import Foundation
import UIKit

public extension String {
    func toImage() -> UIImage? {
        if let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters){
            return UIImage(data: data)
        }
        return nil
    }
}

public extension UIImage {
    func toString() -> String? {
        let data: Data? = self.pngData()
        return data?.base64EncodedString(options: .endLineWithLineFeed)
    }
}
