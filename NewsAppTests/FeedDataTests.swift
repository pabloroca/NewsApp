//
//  FeedDataTests.swift
//  NewsApp
//
//  Created by Pablo Roca Rozas on 29/03/2017.
//  Copyright © 2017 PR2Studio. All rights reserved.
//

import XCTest
import RealmSwift
import SWXMLHash

@testable import NewsApp

class FeedDataTests: XCTestCase {
    
    var dataController: FeedDataController?
    var xml: XMLIndexer?
    
    override func setUp() {
        super.setUp()
        self.dataController = FeedDataController()
        self.dataController?.deleteAll()
        xml = self.readXMLFile(file: "Feed")
        if let xml = xml {
            self.dataController?.processxml(feedid: 0, xml: xml)
        }
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func readXMLFile(file: String) -> XMLIndexer? {
        do {
            let bundle = Bundle(for: type(of: self))
            
            if let file = bundle.url(forResource: file, withExtension: "txt") {
                let data = try Data(contentsOf: file)
                return SWXMLHash.parse(data)
            } else {
                return nil
            }
        } catch {
            return nil
        }
    }
    
    func testsetup() {
        let data = self.dataController!.readAll()
        if !data.isEmpty {
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

    func testReadAll() {
        let data = self.dataController!.readAll()
        
        if data.isEmpty {
            XCTFail()
        } else {
            XCTAssert(true, "Pass")
        }
    }
}
