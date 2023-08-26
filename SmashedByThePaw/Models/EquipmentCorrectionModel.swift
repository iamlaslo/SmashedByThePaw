//
//  EquipmentCorrectionModel.swift
//  SmashedByThePaw
//
//  Created by Laslo on 26.08.2023.
//

import Foundation

struct EquipmentCorrectionModel: Codable, Hashable, Identifiable {
    
    // MARK: - Properties
    
    var id: String {
        self.rawDate
    }
    
    let rawDate: String
    var date: Date? {
        self.rawDate.asDate()
    }
    
    let day: Int
    let aircraft: Int
    let helicopter: Int
    let tank: Int
    let apc: Int
    let artillery: Int
    let mrl: Int
    let drone: Int
    let navalShip: Int
    let aaw: Int
    let specialEquipment: Int
    let vehiclesAndFuelTanks: Int
    let cruiseMissiles: Int
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String, CodingKey {
        case rawDate = "date"
        case day
        case aircraft
        case helicopter
        case tank
        case apc = "APC"
        case artillery = "field artillery"
        case mrl = "MRL"
        case drone
        case navalShip = "naval ship"
        case aaw = "anti-aircraft warfare"
        case specialEquipment = "special equipment"
        case vehiclesAndFuelTanks = "vehicles and fuel tanks"
        case cruiseMissiles = "cruise missiles"
    }
}
