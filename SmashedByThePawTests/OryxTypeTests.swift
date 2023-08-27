//
//  OryxTypeTests.swift
//  SmashedByThePawTests
//
//  Created by Laslo on 27.08.2023.
//

import XCTest
@testable import SmashedByThePaw

final class OryxTypeTests: XCTestCase {
    
    // MARK: - Properties
    
    var oryxType: OryxType!
    
    // MARK: - Init & Deinit
    
    override func setUp() {
        super.setUp()
        self.oryxType = .aircrafts
    }
    
    override func tearDown() {
        super.tearDown()
        self.oryxType = nil
    }
    
    // MARK: - Tests
    
    func testEquipmentCount() {
        let expectedResult: Int = 3
        
        var equipmentMock = EquipmentModel(count: 0)
        equipmentMock.aircraft = expectedResult
        
        XCTAssertEqual(
            self.oryxType.equipmentCount(
                for: equipmentMock
            ),
            expectedResult,
            "Expected proper equipment counting."
        )
    }
}
