//
//  BCSSwiftToolsTests.swift
//  BCSSwiftToolsTests
//
//  Created by Alexey Nenastev on 15.05.2020.
//  Copyright © 2020 alexeyne. All rights reserved.
//

import XCTest
import BCSSwiftTools

class BCSSwiftToolsTests: XCTestCase {
 
    func testCodable_ImageResource_URL() {
        let originalURL = URL(string: "https://avatars.mds.yandex.net/get-pdb/2300765/c721cdec-3682-4524-a6e7-fdfb39f46697/s1200")!
        let originalRes = ImageResource.url(originalURL)
        
        UserDefaults.standard.set(object: originalRes, forKey: "res")
        
        let restoredRes = UserDefaults.standard.object(ImageResource.self, with: "res")
        
        XCTAssert(originalRes == restoredRes)
    }
    
    func testCodable_ImageResource_Image() {
        let image = UIImage(systemName: "heart.fill")!
        let originalRes = ImageResource.image(image)
        
        UserDefaults.standard.set(object: originalRes, forKey: "res")
        
        let restoredRes = UserDefaults.standard.object(ImageResource.self, with: "res")
        
        XCTAssert(restoredRes != nil)
    }
    
    func testDateFormatter() {
        let dateValue = "01/22/2020 23:23:23"
        let date = dateValue.date(format: .MMddyyyyHHmmss)
        XCTAssert(date != nil)

        let testFormat = Date.Formats.MM_dd_yyyy
        let testValue = date?.string(testFormat)
        XCTAssert(testValue == "01-22-2020")

        let testDate = testValue?.date(format: testFormat)
        XCTAssert(testDate != nil)

        let day = testDate?.string(.dd)
        XCTAssert(day == "22")

        let month = testDate?.string(.MMMM)
        XCTAssert(month?.lowercased().hasPrefix("янв") ?? false)

        let year = testDate?.string(.yyyy)
        XCTAssert(year == "2020")
    }
}
