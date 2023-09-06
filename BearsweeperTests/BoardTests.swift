//
//  BearsweeperTests.swift
//  BearsweeperTests
//
//  Created by Daniel on 2023-08-18.
//

import XCTest
@testable import Bearsweeper

final class BoardTests: XCTestCase {
    func testTileAtReturnsNilForNegativeIndices() {
        let sut = Board(gameType: .beginner)
         
        XCTAssertNil(sut[-1, 0])
        XCTAssertNil(sut[0, -1])
    }
    
    func testTileAtReturnsNilForIndicesThatAreTooLarge() {
        let sut = Board(gameType: .beginner)
         
        XCTAssertNil(sut[sut.gameType.numRows, 0])
        XCTAssertNil(sut[0, sut.gameType.numColumns])
    }
    
    func testTileAtReturnsNotNilForIndicesThatFitInsideBoard() {
        let sut = Board(gameType: .beginner)
         
        XCTAssertNotNil(sut[0, 0])
        XCTAssertNotNil(sut[0, 1])
        XCTAssertNotNil(sut[0, 2])
        XCTAssertNotNil(sut[1, 0])
        XCTAssertNil(sut[3, sut.gameType.numColumns + 1])
        XCTAssertNotNil(sut[sut.gameType.numRows - 1, 5])
    }
    
    func testAboveLeftReturnsValidTileWhenNotOnBorder() throws {
        let sut = Board(gameType: .beginner)
         
        let wrongTile = try XCTUnwrap(sut[0, 0])
        let correctTile = try XCTUnwrap(sut[sut.gameType.numRows - 1,
                                            sut.gameType.numColumns - 1])
        
        XCTAssertNil(sut.aboveLeft(tile: wrongTile))
        XCTAssertNotNil(sut.aboveLeft(tile: correctTile))
    }
    
    func testAboveRightReturnsValidTileWhenNotOnBorder() throws {
        let sut = Board(gameType: .beginner)
         
        let wrongTile = try XCTUnwrap(sut[0, sut.gameType.numColumns - 1])
        let correctTile = try XCTUnwrap(sut[sut.gameType.numRows - 1, 0])
        
        XCTAssertNil(sut.aboveRight(tile: wrongTile))
        XCTAssertNotNil(sut.aboveRight(tile: correctTile))
    }
    
    func testAboveReturnsValidTileWhenNotOnBorder() throws {
        let sut = Board(gameType: .beginner)
         
        let wrongTile = try XCTUnwrap(sut[0, 0])
        let correctTile = try XCTUnwrap(sut[sut.gameType.numRows - 1, 0])
        
        XCTAssertNil(sut.above(tile: wrongTile))
        XCTAssertNotNil(sut.above(tile: correctTile))
    }
    
    func testBelowLeftReturnsValidTileWhenNotOnBorder() throws {
        let sut = Board(gameType: .beginner)
        let wrongTile = try XCTUnwrap(sut[sut.gameType.numRows - 2, 0])
        let correctTile = try XCTUnwrap(sut[0, 1])
            
        XCTAssertNil(sut.belowLeft(tile: wrongTile))
        XCTAssertNotNil(sut.belowLeft(tile: correctTile))
    }
    
    func testBelowRightReturnsValidTileWhenNotOnBorder() throws {
        let sut = Board(gameType: .beginner)
         
        let wrongTile = try XCTUnwrap(sut[sut.gameType.numRows - 1,
                                          sut.gameType.numColumns - 1])
        let correctTile = try XCTUnwrap(sut[0, sut.gameType.numColumns - 2])
        
        XCTAssertNil(sut.belowRight(tile: wrongTile))
        XCTAssertNotNil(sut.belowRight(tile: correctTile))
    }
    
    func testBelowReturnsValidTileWhenNotOnBorder() throws {
        let sut = Board(gameType: .beginner)
        let wrongTile = try XCTUnwrap(sut[sut.gameType.numRows - 1, 0])
        let correctTile = try XCTUnwrap(sut[0, 0])
        
        XCTAssertNil(sut.below(tile: wrongTile))
        XCTAssertNotNil(sut.below(tile: correctTile))
    }
    
    func testLeftReturnsValidTileWhenNotOnBorder() throws {
        let sut = Board(gameType: .beginner)
        let wrongTile = try XCTUnwrap(sut[0, 0])
        let correctTile = try XCTUnwrap(sut[0, sut.gameType.numColumns - 1])
        
        XCTAssertNil(sut.left(tile: wrongTile))
        XCTAssertNotNil(sut.left(tile: correctTile))
    }
    
    func testRightReturnsValidTileWhenNotOnBorder() throws {
        let sut = Board(gameType: .beginner)
        let wrongTile = try XCTUnwrap(sut[0, sut.gameType.numColumns - 1])
        let correctTile = try XCTUnwrap(sut[0, sut.gameType.numColumns - 2])
        
        XCTAssertNil(sut.right(tile: wrongTile))
        XCTAssertNotNil(sut.right(tile: correctTile))
    }
    
    func testGameStateEqualsWonAfterAllSafeTilesAreRevealed() {
        let sut = Board(gameType: .beginner, tileGenerator: FakeTileGenerator())
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
