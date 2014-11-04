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
        let game = TennisGame()
        XCTAssertEqual("Love Love", game.showScore(), "")
    }

    func testLoveWin() {
        var game = TennisGame()
        game.playerScored(Array(count: 4, repeatedValue: .B))

        XCTAssertEqual("B wins!", game.showScore(), "")
    }

    func testDeuce() {
        var game = TennisGame()
        game.playerScored([.B, .B, .B, .A, .A, .A])

        XCTAssertEqual("Deuce", game.showScore(), "")
    }

    func testBAdvantage() {
        var game = TennisGame()
        game.playerScored([.B, .B, .B, .A, .A, .A, .B])

        XCTAssertEqual("B advantage", game.showScore(), "")
    }

    func testDeuceAgain() {
        var game = TennisGame()
        game.playerScored([.B, .B, .B, .A, .A, .A, .B, .A])

        XCTAssertEqual("Deuce", game.showScore(), "")
    }

    func testAAdvantageAfterBAdvantage() {
        var game = TennisGame()
        game.playerScored([.B, .B, .B, .A, .A, .A, .B, .A, .A])

        XCTAssertEqual("A advantage", game.showScore(), "")
    }

    func testAWinAfterBAdvantage() {
        var game = TennisGame()
        game.playerScored([.B, .B, .B, .A, .A, .A, .B, .A, .A, .A])

        XCTAssertEqual("A wins!", game.showScore(), "")
    }

    func testNothingHappenAfterBWin() {
        var game = TennisGame()
        game.playerScored([.B, .B, .B, .B, .A, .A, .A, .B, .A, .A, .A])

        XCTAssertEqual("B wins!", game.showScore(), "")
    }
}
