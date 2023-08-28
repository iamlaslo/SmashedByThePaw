//
//  EquipmentOryxModel.swift
//  SmashedByThePaw
//
//  Created by Laslo on 26.08.2023.
//

import Foundation

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
