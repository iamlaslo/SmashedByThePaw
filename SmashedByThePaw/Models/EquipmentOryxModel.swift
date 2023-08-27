//
//  EquipmentOryxModel.swift
//  SmashedByThePaw
//
//  Created by Laslo on 26.08.2023.
//

import Foundation

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

struct ModelWithLosses: Identifiable, Hashable {
    let id = UUID()
    var model: String
    var losses: Int
}

enum OryxManufacturer: String, Codable {
    case iran = "Iran"
    case israel = "Israel"
    case italy = "Italy"
    case poland = "Poland"
    case russia = "Russia"
    case theCzechRepublic = "the Czech Republic"
    case theSovietUnion = "the Soviet Union"
    
    var title: String {
        switch self {
        case .iran:
            return self.rawValue
        case .israel:
            return self.rawValue
        case .italy:
            return self.rawValue
        case .poland:
            return self.rawValue
        case .russia:
            return self.rawValue.lowercased()
        case .theCzechRepublic:
            return "Czech Republic"
        case .theSovietUnion:
            return "soviet union"
        }
    }
}

struct EquipmentOryxModel: Codable, Hashable, Identifiable {
 
    // MARK: - Properties
    
    let id = UUID()
    
    let oryx: String
    let model: String
    let manufacturer: OryxManufacturer
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
