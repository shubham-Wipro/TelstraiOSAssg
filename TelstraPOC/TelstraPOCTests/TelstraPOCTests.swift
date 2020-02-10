//
//  TelstraPOCTests.swift
//  TelstraPOCTests
//
//  Created by Shubh on 09/02/20.
//  Copyright © 2020 Shubh. All rights reserved.
//

import XCTest
@testable import TelstraPOC

class TelstraPOCTests: XCTestCase {
    
    var mainController: ViewController!

    override func setUp() {
            mainController = ViewController()
    }

    func testMainView() {
        XCTAssertNotNil(mainController.view,"Main View not created")
    }
    
    func testAPIResponse(){
        NetworkManager.defaultManager.fetchDataFrom(Constants.default_URL) { (data, response, error) in
            XCTAssertEqual(200, response?.statusCode, "Satus Code:: \(String(describing: response?.statusCode))")
        }
    }
        
    func testTableViewIsCreated(){
        let subViews = mainController.view.subviews
        XCTAssertTrue(subViews.contains(mainController.tableView),"TableView not created")
    }
    
    override func tearDown() {
            mainController = nil
    }

}
