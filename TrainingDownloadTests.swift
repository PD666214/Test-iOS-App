//
//  TrainingDownloadTests.swift
//  BudgetTrackeriOSTests
//
//  Created by Jonathan Wong on 7/12/19.
//  Copyright © 2019 fatty waffles. All rights reserved.
//

import XCTest
@testable import BudgetTrackeriOS

class TrainingDownloadTests: XCTestCase {

  override func setUp() {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }

  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  func testTrainingDownloadSum() {
    let training1 = Training(name: "1", price: 100)
    let training2 = Training(name: "2", price: 200)
    let training3 = Training(name: "3", price: 300)
    let trainings1 = [training1, training2, training3]
    let trainingDownload1 = TrainingDownload(employeeId: 1)
    trainingDownload1.trainings = trainings1
    
    let trainings2 = [training1, training2]
    let trainingDownload2 = TrainingDownload(employeeId: 2)
    trainingDownload2.trainings = trainings2
    
    let trainingDownloads = [trainingDownload1, trainingDownload2]
    
    XCTAssertEqual(trainingDownloads.sum(), 900)
  }

}
