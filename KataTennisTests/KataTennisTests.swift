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
        game.playerScored(.B)
        game.playerScored(.B)
        game.playerScored(.B)
        game.playerScored(.B)

        XCTAssertEqual("B wins!", game.showScore(), "")
    }

    func testDeuce() {
        var game = TennisGame()
        game.playerScored(.B)
        game.playerScored(.B)
        game.playerScored(.B)
        game.playerScored(.A)
        game.playerScored(.A)
        game.playerScored(.A)

        XCTAssertEqual("Deuce", game.showScore(), "")
    }

    func testBAdvantage() {
        var game = TennisGame()
        game.playerScored(.B)
        game.playerScored(.B)
        game.playerScored(.B)
        game.playerScored(.A)
        game.playerScored(.A)
        game.playerScored(.A)
        game.playerScored(.B)

        XCTAssertEqual("B advantage", game.showScore(), "")
    }

    func testDeuceAgain() {
        var game = TennisGame()
        game.playerScored(.B)
        game.playerScored(.B)
        game.playerScored(.B)
        game.playerScored(.A)
        game.playerScored(.A)
        game.playerScored(.A)
        game.playerScored(.B)
        game.playerScored(.A)

        XCTAssertEqual("Deuce", game.showScore(), "")
    }

    func testAAdvantageAfterBAdvantage() {
        var game = TennisGame()
        game.playerScored(.B)
        game.playerScored(.B)
        game.playerScored(.B)
        game.playerScored(.A)
        game.playerScored(.A)
        game.playerScored(.A)
        game.playerScored(.B)
        game.playerScored(.A)
        game.playerScored(.A)

        XCTAssertEqual("A advantage", game.showScore(), "")
    }

    func testAWinAfterBAdvantage() {
        var game = TennisGame()
        game.playerScored(.B)
        game.playerScored(.B)
        game.playerScored(.B)
        game.playerScored(.A)
        game.playerScored(.A)
        game.playerScored(.A)
        game.playerScored(.B)
        game.playerScored(.A)
        game.playerScored(.A)
        game.playerScored(.A)

        XCTAssertEqual("A wins!", game.showScore(), "")
    }
}
