//
//  EquipmentModelTests.swift
//  SmashedByThePawTests
//
//  Created by Laslo on 27.08.2023.
//

import XCTest
@testable import SmashedByThePaw

final class EquipmentModelTests: XCTestCase {
    
    // MARK: - Properties
    
    var equipmentModel: EquipmentModel!
    
    // MARK: - Init & Deinit
    
    override func setUp() {
        super.setUp()
        self.equipmentModel = EquipmentModel(count: 3)
    }
    
    override func tearDown() {
        super.tearDown()
        self.equipmentModel = nil
    }
    
    // MARK: - Tests
    
    func testDateConvertion() {
        let rawDate = "2022-02-24"
        self.equipmentModel.rawDate = rawDate
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        let expectedDate = dateFormatter.date(from: rawDate)
        
        XCTAssertEqual(
            self.equipmentModel.date,
            expectedDate,
            "Expected proper date convertion."
        )
    }
    
    func testCorrection() {
        let rawDate = "2022-02-24"
        let correction = EquipmentCorrectionModel(
            rawDate: rawDate,
            day: 1,
            aircraft: -1,
            helicopter: -1,
            tank: -1,
            apc: -1,
            artillery: -1,
            mrl: -1,
            drone: -1,
            navalShip: -1,
            aaw: -1,
            specialEquipment: -1,
            vehiclesAndFuelTanks: -1,
            cruiseMissiles: -1
        )
        
        let expectedEquipment = EquipmentModel(count: 2)
        self.equipmentModel.correct(
            source: correction
        )
        
        XCTAssertEqual(
            self.equipmentModel,
            expectedEquipment,
            "Expected proper day correction."
        )
    }
}
