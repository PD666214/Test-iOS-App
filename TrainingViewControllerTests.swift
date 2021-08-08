//
//  TrainingViewControllerTests.swift
//  BudgetTrackeriOSTests
//
//  Created by Jonathan Wong on 8/8/19.
//  Copyright © 2019 fatty waffles. All rights reserved.
//

import XCTest
@testable import BudgetTrackeriOS

class MockApiClient: ApiClient {
  
  var fetchResourcesCallCount = 0
  var fetchResourceCallCount = 0
  
  let mockNetworkSession = MockNetworkSession()
  
  var fetchResourcesExpectation: XCTestExpectation?
//  var fetchResourceExpectation: XCTestExpectation?
  
  init() {
    super.init(session: mockNetworkSession, resourcePath: "")
  }
  
  override func fetchResources<T>(completion: @escaping (Result<[T], ApiError>) -> Void) where T : Decodable, T : Encodable {
    fetchResourcesCallCount += 1
    mockNetworkSession.dataTask(with: URL(string: "test")!) { [weak self] data, _, _ in
      self?.fetchResourcesExpectation = XCTestExpectation(description: "fetch resources")
      DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
        self?.fetchResourcesExpectation?.fulfill()
        
//        self?.fetchResourceExpectation = XCTestExpectation(description: "fetch resource")
        completion(.success([T]()))
      }
    }.resume()
  }
  
  override func fetchResource<T>(completion: @escaping (Result<T, ApiError>) -> Void) where T : Decodable, T : Encodable {
    fetchResourceCallCount += 1
    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
      self.fetchResourcesExpectation?.fulfill()
    }
  }
}

class TrainingViewControllerTests: XCTestCase {

  var viewController: TrainingViewController!
  
  override func setUp() {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    viewController = (storyboard.instantiateViewController(withIdentifier: "TrainingViewController") as! TrainingViewController)
  }

  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  func testLoadTrainings() {
    let mockApiClient = MockApiClient()
    viewController.apiClient = mockApiClient
    _ = viewController.view
    
    XCTAssertEqual(mockApiClient.fetchResourcesCallCount, 1)
  }
  
  func testLoadTrainingsForEmployee() {
    let mockApiClient = MockApiClient()
    viewController.apiClient = mockApiClient
    
    viewController.employee = Employee(id: 1, firstName: "Jonathan", lastName: "Wong")
    
    _ = viewController.view
    
    mockApiClient.fetchResourcesExpectation!.expectedFulfillmentCount = 2
    
    XCTAssertEqual(mockApiClient.fetchResourcesCallCount, 1)
    wait(for: [mockApiClient.fetchResourcesExpectation!], timeout: 3.0)
//    wait(for: [mockApiClient.fetchResourceExpectation!], timeout: 3.0)
    XCTAssertEqual(mockApiClient.fetchResourceCallCount, 1)
  }

}
