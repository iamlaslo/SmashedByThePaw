//
//  CalendarViewModel.swift
//  SmashedByThePaw
//
//  Created by Laslo on 27.08.2023.
//

import Foundation

@MainActor
final class CalendarViewModel: ObservableObject {
    
    // MARK: - Variables
    
    @Published private(set) var equipment: [EquipmentModel] = []
    
    let networkManager: NetworkManager
    
    // MARK: - Init
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
        Task {
            await self.fetchEquipment()
        }
    }
    
    // MARK: - Public
    
    // For testing purposes only
    #if DEBUG
        public func setup(equipment: [EquipmentModel]) {
            self.equipment = equipment
        }
    #endif
    
    public func equipment(for selectedDate: Date) -> [EquipmentDayData] {
        if let currentDay = self.equipment.first(where: { $0.date?.formatted(date: .abbreviated, time: .omitted) == selectedDate.formatted(date: .abbreviated, time: .omitted)}),
            let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: selectedDate),
           let previousDay = self.equipment.first(where: { $0.date?.formatted(date: .abbreviated, time: .omitted) == yesterday.formatted(date: .abbreviated, time: .omitted)})
        {
            return self.equipment(currentDay: currentDay, previousDay: previousDay)
        } else {
            return []
        }
    }
    
    // MARK: - Private
    
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
    
    private func equipment(currentDay: EquipmentModel, previousDay: EquipmentModel) -> [EquipmentDayData] {
        var result: [EquipmentDayData] = [
            EquipmentDayData(
                type: .aircrafts,
                increasement: currentDay.aircraft - previousDay.aircraft,
                total: currentDay.aircraft
            ),
            EquipmentDayData(
                type: .helicopters,
                increasement: currentDay.helicopter - previousDay.helicopter,
                total: currentDay.helicopter
            ),
            EquipmentDayData(
                type: .tanks,
                increasement: currentDay.tank - previousDay.tank,
                total: currentDay.tank
            ),
            EquipmentDayData(
                type: .armouredPersonnelCarriers,
                increasement: currentDay.apc - previousDay.apc,
                total: currentDay.apc
            ),
            EquipmentDayData(
                type: .artillerySystems,
                increasement: currentDay.artillery - previousDay.artillery,
                total: currentDay.artillery
            ),
            EquipmentDayData(
                type: .multipleRocketLaunchers,
                increasement: currentDay.mrl - previousDay.mrl,
                total: currentDay.mrl
            ),
            EquipmentDayData(
                type: .unmannedAerialVehicles,
                increasement: currentDay.drone - previousDay.drone,
                total: currentDay.drone
            ),
            EquipmentDayData(
                type: .warshipsBoats,
                increasement: currentDay.navalShip - previousDay.navalShip,
                total: currentDay.navalShip
            ),
            EquipmentDayData(
                type: .antiAircraftWarfareSystems,
                increasement: currentDay.aaw - previousDay.aaw,
                total: currentDay.aaw
            )
        ]
        
        if let currentDaySpecialEquipment = currentDay.specialEquipment {
            result.append(
                EquipmentDayData(
                    type: .specialEquipment,
                    increasement: currentDaySpecialEquipment - (previousDay.specialEquipment ?? 0),
                    total: currentDaySpecialEquipment
                )
            )
        }
        
        if let currentDayVehicles = currentDay.totalVehiclesAndFuelTanks {
            result.append(
                EquipmentDayData(
                    type: .vehicleAndFuelTank,
                    increasement: currentDayVehicles - (previousDay.totalVehiclesAndFuelTanks ?? 0),
                    total: currentDayVehicles
                )
            )
        }
        
        return result
    }
}
