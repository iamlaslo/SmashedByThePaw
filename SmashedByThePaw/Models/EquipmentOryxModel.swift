//
//  EquipmentOryxModel.swift
//  SmashedByThePaw
//
//  Created by Laslo on 26.08.2023.
//

import Foundation

enum OryxType: String, Codable {
    case aircrafts = "Aircrafts"
    case antiAircraftWarfareSystems = "Anti-aircraft Warfare Systems"
    case armouredPersonnelCarriers = "Armoured Personnel Carriers"
    case artillerySystems = "Artillery Systems"
    case helicopters = "Helicopters"
    case multipleRocketLaunchers = "Multiple Rocket Launchers"
    case specialEquipment = "Special Equipment"
    case tanks = "Tanks"
    case unmannedAerialVehicles = "Unmanned Aerial Vehicles"
    case vehicleAndFuelTank = "Vehicle and Fuel Tank"
    case warshipsBoats = "Warships, Boats"
}

struct Oryx {
    
    var data: [EquipmentOryxModel]
    
    func total(of selectedType: OryxType) -> Int {
        let filtered = self.data.filter { $0.equipmentType == selectedType }
        let count = filtered.reduce(0) {
            $0 + $1.lossesTotal
        }
        return count
    }
}

struct EquipmentOryxModel: Codable, Hashable, Identifiable {
    
    enum Manufacturer: String, Codable {
        case iran = "Iran"
        case israel = "Israel"
        case italy = "Italy"
        case poland = "Poland"
        case russia = "Russia"
        case theCzechRepublic = "the Czech Republic"
        case theSovietUnion = "the Soviet Union"
    }
 
    // MARK: - Properties
    
    let id = UUID()
    
    let oryx: String
    let model: String
    let manufacturer: Manufacturer
    let lossesTotal: Int
    let equipmentType: OryxType
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String, CodingKey {
        case oryx = "equipment_oryx"
        case model
        case manufacturer
        case lossesTotal = "losses_total"
        case equipmentType = "equipment_ua"
    }
}
