//
//  AccountSummaryViewControllerTests.swift
//  Banky2UnitTests
//
//  Created by 野中淳 on 2022/02/24.
//

import Foundation
import XCTest

@testable import Banky2

class AccountSummaryViewControllerTests:XCTestCase{
    
    var vc:AccountSummaryViewController!
    
    var mockManager:MockProfileManager!
    
    class MockProfileManager: ProfileManageable {
        var profile: Profile?
        var error: NetworkError?
        //同じ関数を準備する
        func fetchProfile(forUserId userId: String, completion: @escaping (Result<Profile, NetworkError>) -> Void) {
            if error != nil {
                //completionつまり結果を自由に制御できる。（今回であれば成功したのにerrorを返す）
                completion(.failure(error!))
                return
            }
            profile = Profile(id: "1", firstName: "FirstName", lastName: "LastName")
            completion(.success(profile!))
        }
    }
    
    override func setUp() {
        super.setUp()
        vc = AccountSummaryViewController()
        
        mockManager = MockProfileManager()
        vc.profileManager = mockManager
    }
    
    func testTitleAndMessageForServerError() throws{
        let titleAndMessage = vc.titleAndMessageForTesting(for: .serverError)
        XCTAssertEqual("Server Error", titleAndMessage.0)
        XCTAssertEqual("We could not process your request. Please try again.", titleAndMessage.1)

    }
    func testTitleAndMessageForNetworkError() throws {
        let titleAndMessage = vc.titleAndMessageForTesting(for: .decodingError)
        XCTAssertEqual("Network Error", titleAndMessage.0)
        XCTAssertEqual("Ensure you are connected to the internet. Please try again.", titleAndMessage.1)
    }
    
    func testAlertForDecodingError() throws {
        mockManager.error = NetworkError.decodingError
        //外からfetch関数を強制的に呼び出す
        vc.forceFetchProfile()
        
        XCTAssertEqual("Network Error", vc.errorAlert.title)
        XCTAssertEqual("Ensure you are connected to the internet. Please try again.", vc.errorAlert.message)
    }
    
    func testAlertForNetworkError() throws {
        mockManager.error = NetworkError.serverError
        //外からfetch関数を強制的に呼び出す
        vc.forceFetchProfile()
        
        XCTAssertEqual("Server Error", vc.errorAlert.title)
        XCTAssertEqual("We could not process your request. Please try again.", vc.errorAlert.message)
    }
}
