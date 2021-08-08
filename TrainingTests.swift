//
//  TrainingTests.swift
//  BudgetTrackeriOSTests
//
//  Created by Jonathan Wong on 7/12/19.
//  Copyright © 2019 fatty waffles. All rights reserved.
//

import XCTest
@testable import BudgetTrackeriOS

class TrainingTests: XCTestCase {

  override func setUp() {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }

  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  func testTrainingSum() {
    let training1 = Training(name: "1", price: 100)
    let training2 = Training(name: "2", price: 200)
    let training3 = Training(name: "3", price: 300)
    let trainings = [training1, training2, training3]
    
    XCTAssertEqual(trainings.sum(), 600)
  }

}
