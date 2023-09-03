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
        // TODO: test different game types as well
        let sut = Board()
        
        XCTAssert(sut.tiles.count == 64)
        
        let mineCount = sut.tiles.lazy.filter({ $0.value.isBee }).count
        XCTAssert(mineCount == 10)
    }
}
