//
//  OryxViewModel.swift
//  SmashedByThePaw
//
//  Created by Laslo on 26.08.2023.
//

import Foundation

@MainActor
final class OryxViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published private(set) var totalPersonnel: Int?
    @Published private(set) var equipment: [EquipmentModel] = []
    @Published private(set) var oryx: Oryx?
    
    let networkManager: NetworkManager
    
    // MARK: - Init
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
        Task {
            await self.fetchTotalPersonnel()
            await self.fetchEquipment()
            await self.fetchOryx()
        }
    }
    
    // MARK: - Public
    
    // For testing purposes only
    #if DEBUG
        public func setup(equipment: [EquipmentModel]) {
            self.equipment = equipment
        }
        
        public func setup(oryx: Oryx) {
            self.oryx = oryx
        }
    #endif
    
    public func todayCount(for oryxType: OryxType) -> Int? {
        oryxType.equipmentCount(for: self.equipment.last)
    }
    
    public func todayDifference(for oryxType: OryxType) -> Int? {
        if let todayCount = oryxType.equipmentCount(for: self.equipment.last),
           let yesterdayCount = oryxType.equipmentCount(for: self.equipment[self.equipment.count - 2])
        {
            return todayCount - yesterdayCount
        } else {
            return nil
        }
    }
    
    public func count(oryxType: OryxType) -> Int {
        self.oryx?.total(of: oryxType) ?? 0
    }
    
    public func oryx(for type: OryxType) -> [EquipmentOryxModel] {
        self.oryx?.data.filter { $0.equipmentType == type } ?? []
    }
    
    // MARK: - Private
    
    private func fetchTotalPersonnel() async {
        do {
            let result: TotalPersonnelModel = try await self.networkManager.fetch(from: .totalPersonnel)
            
            await MainActor.run {
                self.totalPersonnel = result.data.stats.units
            }
        } catch {
            Log.error(error)
        }
    }
    
    private func fetchEquipment() async {
        do {
            var result: [EquipmentModel] = try await self.networkManager.fetch(from: .equipment)
            
            let correction: [EquipmentCorrectionModel] = try await self.networkManager.fetch(from: .equipmentCorrection)
            correction.forEach { dayCorrection in
                if let index = result.firstIndex(where: { $0.rawDate == dayCorrection.rawDate }) {
                    result[index].correct(source: dayCorrection)
                }
            }
            
            await MainActor.run {
                self.equipment = result
            }
        } catch {
            Log.error(error)
        }
    }
    
    private func fetchOryx() async {
        do {
            let result: [EquipmentOryxModel] = try await self.networkManager.fetch(from: .oryx)
            
            await MainActor.run {
                self.oryx = Oryx(data: result)
            }
        } catch {
            Log.error(error)
        }
    }
}
