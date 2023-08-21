//
//  BearsweeperTests.swift
//  BearsweeperTests
//
//  Created by Daniel on 2023-08-18.
//

import XCTest
@testable import Bearsweeper

final class BoardTests: XCTestCase {
    //TODO: replace hardcoded row/column number with correct values based on game type
    func testTileAtReturnsNilForNegativeIndices() {
        let sut = Board()
         
        XCTAssertNil(sut[-1, 0])
        XCTAssertNil(sut[0, -1])
    }
    
    func testTileAtReturnsNilForIndicesThatAreTooLarge() {
        let sut = Board()
         
        XCTAssertNil(sut[8, 0])
        XCTAssertNil(sut[0, 8])
    }
    
    func testTileAtReturnsNotNilForIndicesThatFitInsideBoard() {
        let sut = Board()
         
        XCTAssertNotNil(sut[0, 0])
        XCTAssertNotNil(sut[0, 1])
        XCTAssertNotNil(sut[0, 2])
        XCTAssertNotNil(sut[1, 0])
        XCTAssertNil(sut[3, 9])
        XCTAssertNotNil(sut[8 - 1, 6])
    }
}
