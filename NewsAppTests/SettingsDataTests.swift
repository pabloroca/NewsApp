//
//  SettingsDataTests.swift
//  NewsApp
//
//  Created by Pablo Roca Rozas on 29/03/2017.
//  Copyright © 2017 PR2Studio. All rights reserved.
//

import XCTest
import RealmSwift

@testable import NewsApp

class SettingsDataTests: XCTestCase {
    
    var dataController: SettingsDataController?
    
    override func setUp() {
        super.setUp()
        self.dataController = SettingsDataController()
        self.dataController?.deleteAll()
        self.dataController?.setup()
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testsetup() {
        let data = self.dataController!.readAll()
        if data.count == 4 {
            XCTAssert(true, "Pass")
        } else {
            XCTFail()
        }
    }
    
    func testDeleteAll() {
        self.dataController!.deleteAll()
        let data = self.dataController!.readAll()

        if data.isEmpty {
            XCTAssert(true, "Pass")
        } else {
            XCTFail()
        }
    }
    
    func testsetTSFeedRead() {
        self.dataController?.setTSFeedRead(feedid: 1, ts: 3)
        if let data = self.dataController?.readFirst(feedid: 1) {
            if data.feedid == 1 {
                XCTAssert(true, "Pass")
            } else {
                XCTFail()
            }
        } else {
            XCTFail()
        }
    }

    func testreadFirstShouldFail() {
        self.dataController?.setTSFeedRead(feedid: 5, ts: 3)
        if self.dataController?.readFirst(feedid: 5) != nil {
            XCTFail()
        } else {
            XCTAssert(true, "Pass")
        }
    }

    func testreadTSFeedRead() {
        self.testsetTSFeedRead()
        if let data = self.dataController?.readFirst(feedid: 1) {
            if data.tsFeedRead == 3 {
                XCTAssert(true, "Pass")
            } else {
                XCTFail()
            }
        } else {
            XCTFail()
        }
    }

}
