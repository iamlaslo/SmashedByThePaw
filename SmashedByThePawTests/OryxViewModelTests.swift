//
//  OryxViewModelTests.swift
//  SmashedByThePawTests
//
//  Created by Laslo on 27.08.2023.
//

import XCTest
@testable import SmashedByThePaw

final class OryxViewModelTests: XCTestCase {
    
    // MARK: - Properties
    
    var networkManager: NetworkManager!
    var viewModel: OryxViewModel!
    
    // MARK: - Init & Deinit
    
    @MainActor
    override func setUp() {
        super.setUp()
        self.networkManager = NetworkManager()
        self.viewModel = OryxViewModel(networkManager: self.networkManager)
    }
    
    override func tearDown() {
        super.tearDown()
        self.networkManager = nil
        self.viewModel = nil
    }
    
    // MARK: - Tests
    
    @MainActor
    func testTodayCount() {
        let expectedResult: Int = 3
        let equipmentMock = [
            EquipmentModel(count: 0),
            EquipmentModel(count: expectedResult)
        ]
        self.viewModel.setup(equipment: equipmentMock)
        
        XCTAssertEqual(
            self.viewModel.todayCount(for: .aircrafts),
            expectedResult,
            "Expected proper equipment's last count."
        )
    }
    
    @MainActor
    func testTodayDifference() {
        let firstValue = 2
        let secondValue = 3
        let equipmentMock = [
            EquipmentModel(count: firstValue),
            EquipmentModel(count: secondValue)
        ]
        self.viewModel.setup(equipment: equipmentMock)
        
        XCTAssertEqual(
            self.viewModel.todayDifference(for: .aircrafts),
            secondValue - firstValue,
            "Expected proper equipment's difference calculation."
        )
    }
    
    @MainActor
    func testOryxTypeCount() {
        let lossesMock = 5
        let equipmentOryxMock = EquipmentOryxModel(
            oryx: "Oryx",
            model: "Model",
            manufacturer: .theCzechRepublic,
            lossesTotal: lossesMock,
            equipmentType: .aircrafts
        )
        
        let arrayCountMock = 3
        let oryxMock = Oryx(
            data: Array(
                repeating: equipmentOryxMock,
                count: arrayCountMock
            )
        )
        
        self.viewModel.setup(oryx: oryxMock)
        
        XCTAssertEqual(
            self.viewModel.count(oryxType: .aircrafts),
            lossesMock * arrayCountMock,
            "Expected proper Oryx type's counting."
        )
    }
    
    @MainActor
    func testOryxFiltering() {
        let equipmentOryxMock = EquipmentOryxModel(
            oryx: "Oryx",
            model: "Model",
            manufacturer: .theCzechRepublic,
            lossesTotal: 99,
            equipmentType: .aircrafts
        )
        
        let anotherEquipmentOryxMock = EquipmentOryxModel(
            oryx: "Oryx",
            model: "Model",
            manufacturer: .theCzechRepublic,
            lossesTotal: 99,
            equipmentType: .tanks
        )
        
        let oryxMock = Oryx(
            data: [equipmentOryxMock, anotherEquipmentOryxMock]
        )
        
        self.viewModel.setup(oryx: oryxMock)
        
        XCTAssertEqual(
            self.viewModel.oryx(for: .aircrafts).first,
            equipmentOryxMock,
            "Expected proper Oryx type's filtering."
        )
    }
}
