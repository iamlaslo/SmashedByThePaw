//
//  CalendarViewModelTests.swift
//  SmashedByThePawTests
//
//  Created by Laslo on 27.08.2023.
//

import XCTest
@testable import SmashedByThePaw

final class CalendarViewModelTests: XCTestCase {
    
    // MARK: - Properties
    
    var networkManager: NetworkManager!
    var viewModel: CalendarViewModel!
    
    // MARK: - Init & Deinit
    
    @MainActor
    override func setUp() {
        super.setUp()
        self.networkManager = NetworkManager()
        self.viewModel = CalendarViewModel(networkManager: self.networkManager)
    }
    
    override func tearDown() {
        super.tearDown()
        self.networkManager = nil
        self.viewModel = nil
    }
    
    // MARK: - Tests
    
    @MainActor
    func testEquipmentIncreasement() {
        let previousDateStringMock = "2001-01-01"
        let dateStringMock = "2001-01-02"
        let dateMock = dateStringMock.asDate()
        
        let equipmentMock = [
            EquipmentModel(date: previousDateStringMock, count: 1),
            EquipmentModel(date: dateStringMock, count: 2),
            EquipmentModel(date: "2001-01-03", count: 3)
        ]
        self.viewModel.setup(equipment: equipmentMock)
        
        let expectedResult = EquipmentDayData(
            type: .aircrafts,
            increasement: 1,
            total: 2
        )
        
        XCTAssertEqual(
            self.viewModel.equipment(for: dateMock!).first,
            expectedResult,
            "Expected proper equipment's increasement calculation."
        )
    }
}
