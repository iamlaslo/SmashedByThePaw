//
//  HomeViewModel.swift
//  SmashedByThePaw
//
//  Created by Laslo on 26.08.2023.
//

import Foundation

@MainActor
final class HomeViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published private(set) var totalPersonnel: Int?
    @Published private(set) var equipment: [EquipmentModel] = []
    @Published private(set) var oryx: Oryx?
    
    let networkManager = NetworkManager()
    
    init() {
        Task {
            await self.fetchTotalPersonnel()
            await self.fetchEquipment()
            await self.fetchOryx()
        }
    }
    
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
