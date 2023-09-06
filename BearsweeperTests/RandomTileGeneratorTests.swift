//
//  RandomTileGeneratorTests.swift
//  BearsweeperTests
//
//  Created by Daniel on 2023-09-03.
//

import XCTest
@testable import Bearsweeper

final class RandomTileGeneratorTests: XCTestCase {
    func testRandomTileGeneratorGeneratesCorrectAmountOfTiles() {
        let sut = Board(gameType: .beginner)
        
        XCTAssert(sut.tiles.count == sut.gameType.numTiles)
        
        let mineCount = sut.tiles.lazy.filter({ $0.value.isBee }).count
        XCTAssert(mineCount == sut.gameType.numBees)
    }
}
