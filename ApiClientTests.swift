//
//  ApiClientTests.swift
//  BudgetTrackeriOSTests
//
//  Created by Jonathan Wong on 7/20/19.
//  Copyright © 2019 fatty waffles. All rights reserved.
//

import XCTest
@testable import BudgetTrackeriOS

class ApiClientTests: XCTestCase {

  override func setUp() {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }

  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  func testFetchManagers() {
    let expect = expectation(description: "fetch managers")
    let apiClient = ApiClient(session: MockNetworkSession(), resourcePath: "managers")
    apiClient.fetchResources { (result: Result<[Manager], ApiError>) in
      expect.fulfill()
      switch result {
      case .success(let managers):
        XCTAssertNotNil(managers)
        XCTAssertEqual(managers.count, 3)
      case .failure(let error):
        XCTAssertNil(error)
        XCTFail("Could not fetch managers")
      }
    }
    
    waitForExpectations(timeout: 2.0, handler: nil)
  }
  
  func testJSONError() {
    let expect = expectation(description: "parsing JSON failed")
    let mockNetworkErrorSession = MockNetworkErrorSession()
    mockNetworkErrorSession.error = .jsonError
    let apiClient = ApiClient(session: mockNetworkErrorSession, resourcePath: "managers")
    apiClient.fetchResources { (result: Result<[Manager], ApiError>) in
      expect.fulfill()
      switch result {
      case .success:
        XCTFail()
      case .failure(let error):
        XCTAssertNotNil(error)
      }
    }
    
    waitForExpectations(timeout: 2.0, handler: nil)
  }
  
  func testSaveTraining() {
    let expect = expectation(description: "save training")
    let apiClient = ApiClient(session:URLSession.shared, resourcePath: "trainings")
    apiClient.save(fromPath: "trainings", fromResourceId: 1, toPath: "employees", toResourceId: 1) { statusCode in
      expect.fulfill()
      XCTAssertEqual(statusCode, 201)
    }
    
    waitForExpectations(timeout: 1.0, handler: nil)
  }
  
  func testDeleteTraining() {
    let expect = expectation(description: "delete training")
    
    let apiClient = ApiClient(session:URLSession.shared, resourcePath: "trainings")
    apiClient.delete(fromPath: "trainings", fromResourceId: 1, toPath: "employees", toResourceId: 1) { statusCode in
      expect.fulfill()
      XCTAssertEqual(statusCode, 204)
    }
    
    waitForExpectations(timeout: 1.0, handler: nil)
  }
}
