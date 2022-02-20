//
//  ProfileTest.swift
//  Banky2UnitTests
//
//  Created by 野中淳 on 2022/02/20.
//

import Foundation
import XCTest

@testable import Banky2

class ProfileTest:XCTestCase{
    
    override func setUp() {
        super.setUp()
    }
    
    func testCanParse() throws{
        let json = """
        {
        "id":"1",
        "first_name":"Jun",
        "last_name":"Nonaka"
        }
        """
        
        let data = json.data(using: .utf8)!
        let result = try! JSONDecoder().decode(Profile.self, from: data)
        
        XCTAssertEqual(result.id, "1")
        XCTAssertEqual(result.firstName, "Jun")
        XCTAssertEqual(result.lastName, "Nonaka")

    }
    
}
