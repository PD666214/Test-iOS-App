//
//  MockNetworkSession.swift
//  BudgetTrackeriOSTests
//
//  Created by Jonathan Wong on 7/22/19.
//  Copyright © 2019 fatty waffles. All rights reserved.
//

import XCTest
@testable import BudgetTrackeriOS

class MockNetworkSession: NetworkSession {
  func dataTask(with url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) -> NetworkTask {
//    let managers = [Manager(id: 1,
//                            firstName: "Jonathan",
//                            lastName: "Wong",
//                            budget: 4000),
//                    Manager(id: 2,
//                            firstName: "William",
//                            lastName: "Ying",
//                            budget: 8000),
//                    Manager(id: 3,
//                            firstName: "Phoebe",
//                            lastName: "Katz",
//                            budget: 6000)
//    ]
//    let jsonEncoder = JSONEncoder()
//    let json = try!jsonEncoder.encode(managers)
//    let managerString = String(data: json, encoding: .utf8)
//    print(managerString!)
    let bundle = Bundle(for: type(of: self))
    guard let url = bundle.url(forResource: "managers", withExtension: "json") else {
      XCTFail("missing file managers.json")
      return MockNetworkTask()
    }
    let json = try! Data(contentsOf: url)
    completion(json, nil, nil)
    return MockNetworkTask()
  }
  
  func dataTask(with request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) -> NetworkTask {
    return MockNetworkTask()
  }
}

class MockNetworkErrorSession: NetworkSession {
  func dataTask(with request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) -> NetworkTask {
    completion(nil, nil, error)
    return MockNetworkTask()
  }
  
  func dataTask(with url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) -> NetworkTask {
    completion(nil, nil, error)
    return MockNetworkTask()
  }
  
  var error: ApiError?
}

class MockNetworkTask: NetworkTask {
  func resume() {
    
  }
}
