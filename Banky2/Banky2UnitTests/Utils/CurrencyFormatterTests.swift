//
//  CurrencyFormatterTests.swift
//  Banky2UnitTests
//
//  Created by 野中淳 on 2022/02/11.
//

import Foundation
import XCTest

@testable import Banky2

class Test:XCTestCase{
    
    var formatter:CurrencyFormatter!
    
    override func setUp() {
        super.setUp()
        //クラスをインスタンス化
        formatter = CurrencyFormatter()
    }
    func testShouldBeVisible()throws{
        let result = formatter.breakIntoDollarsAndCents(929466.23)
        //結果が期待している値か確認するテスト
        XCTAssertEqual(result.0, "929,466")
        XCTAssertEqual(result.1, "23")
    }
    
    func testDollarsFormatted()throws{
        let result = formatter.dollarsFormatted(929.20)
        XCTAssertEqual(result, "$929.20")
    }
    
    func testZeroDollarsFormatted()throws{
        let result = formatter.dollarsFormatted(000.00)
        XCTAssertEqual(result, "$0.00")
    }
}
