//
//  KataTennisTests.swift
//  KataTennisTests
//
//  Created by Guanshan Liu on 04/11/2014.
//  Copyright (c) 2014 guanshanliu. All rights reserved.
//

import Cocoa
import XCTest

class KataTennisTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testLoveLove() {
        let game = TennisGame.OnGoing(.Love, .Love)
        XCTAssertEqual("Love Love", game.description, "")
    }

    func testLoveWin() {
        var game = TennisGame.OnGoing(.Love, .Love)
        game = game <<< .B <<< .B <<< .B <<< .B

        XCTAssertEqual("B wins!", game.description, "")
    }

    func testDeuce() {
        var game = TennisGame.OnGoing(.Thirty, .Thirty)
        game = game <<< .A <<< .B

        XCTAssertEqual("Deuce", game.description, "")
    }

    func testBAdvantage() {
        var game = TennisGame.OnGoing(.Thirty, .Thirty)
        game = game <<< .A <<< .B <<< .B

        XCTAssertEqual("B advantage", game.description, "")
    }

    func testDeuceAgain() {
        var game = TennisGame.OnGoing(.Thirty, .Thirty)
        game = game <<< .A <<< .B <<< .B <<< .A

        XCTAssertEqual("Deuce", game.description, "")
    }

    func testAAdvantageAfterBAdvantage() {
        var game = TennisGame.BAdvantage
        game = game <<< .A <<< .A

        XCTAssertEqual("A advantage", game.description, "")
    }

    func testAWinAfterBAdvantage() {
        var game = TennisGame.BAdvantage
        game = game <<< .A <<< .A <<< .A

        XCTAssertEqual("A wins!", game.description, "")
    }

    func testNothingHappenAfterBWin() {
        var game = TennisGame.BWin
        game = game <<< .A <<< .B <<< .A <<< .B

        XCTAssertEqual("B wins!", game.description, "")
    }

}
