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
    
    func testAboveLeftReturnsCorrectValue() throws {
        let sut = Board()
         
        let wrongTile = try XCTUnwrap(sut[0, 0])
        let correctTile = try XCTUnwrap(sut[8 - 1, 8 - 1])
        
        XCTAssertNil(sut.aboveLeft(tile: wrongTile))
        XCTAssertNotNil(sut.aboveLeft(tile: correctTile))
    }
    
    func testAboveRightReturnsCorrectValue() throws {
        let sut = Board()
         
        let wrongTile = try XCTUnwrap(sut[0, 8 - 1])
        let correctTile = try XCTUnwrap(sut[8 - 1, 0])
        
        XCTAssertNil(sut.aboveRight(tile: wrongTile))
        XCTAssertNotNil(sut.aboveRight(tile: correctTile))
    }
    
    func testAboveReturnsCorrectValue() throws {
        let sut = Board()
         
        let wrongTile = try XCTUnwrap(sut[0, 0])
        let correctTile = try XCTUnwrap(sut[8 - 1, 0])
        
        XCTAssertNil(sut.above(tile: wrongTile))
        XCTAssertNotNil(sut.above(tile: correctTile))
    }
    
    func testBelowLeftReturnsCorrectValue() throws {
        let sut = Board()
        let wrongTile = try XCTUnwrap(sut[8 - 2, 0])
        let correctTile = try XCTUnwrap(sut[0, 1])
            
        XCTAssertNil(sut.belowLeft(tile: wrongTile))
        XCTAssertNotNil(sut.belowLeft(tile: correctTile))
    }
    
    func testBelowRightReturnsCorrectValue() throws {
        let sut = Board()
         
        let wrongTile = try XCTUnwrap(sut[8 - 2, 8 - 1])
        let correctTile = try XCTUnwrap(sut[0, 8 - 2])
        
        XCTAssertNil(sut.belowRight(tile: wrongTile))
        XCTAssertNotNil(sut.belowRight(tile: correctTile))
    }
    
    func testBelowReturnsCorrectValue() throws {
        let sut = Board()
        let wrongTile = try XCTUnwrap(sut[8 - 1, 0])
        let correctTile = try XCTUnwrap(sut[0, 0])
        
        XCTAssertNil(sut.below(tile: wrongTile))
        XCTAssertNotNil(sut.below(tile: correctTile))
    }
    
    func testLeftReturnsCorrectValue() throws {
        let sut = Board()
        let wrongTile = try XCTUnwrap(sut[0, 0])
        let correctTile = try XCTUnwrap(sut[0, 8 - 1])
        
        XCTAssertNil(sut.left(tile: wrongTile))
        XCTAssertNotNil(sut.left(tile: correctTile))
    }
    
    //TODO: refactor tile methods and XCAssert them
    func testRightReturnsCorrectValue() throws {
        let sut = Board()
        let wrongTile = try XCTUnwrap(sut[0, 8 - 1])
        let correctTile = try XCTUnwrap(sut[0, 8 - 2])
        
        XCTAssertNil(sut.right(tile: wrongTile))
        XCTAssertNotNil(sut.right(tile: correctTile))
    }
    
    func testGameStateEqualsWonAfterAllSafeTilesAreRevealed() {
        let sut = Board(tileGenerator: FakeTileGenerator())
        let beeLocations = [1, 2, 3, 5, 8, 13, 21, 34, 55, 61]
        
        XCTAssertEqual(sut.gameState, .ongoing)
        
        // Reveal all the non-bee tiles
        for tileIndex in 0..<sut.tiles.count {
            if !beeLocations.contains(tileIndex) {
                sut.processTap(tile: sut.tiles[tileIndex])
            }
        }
        
        let revealedCount = sut.tiles.lazy.filter({ $0.isRevealed }).count
        print(revealedCount)
        let e = sut.tiles.lazy.filter({ $0.value.isBee }).count
        print(e)
        XCTAssertEqual(sut.gameState, .won)
    }
}
