//
//  EquipmentModel.swift
//  SmashedByThePaw
//
//  Created by Laslo on 26.08.2023.
//

import Foundation

struct EquipmentModel: Decodable, Hashable, Identifiable {
    
    // MARK: - Properties
    
    var id: String {
        self.rawDate
    }
    
    let rawDate: String
    var date: Date? {
        self.rawDate.asDate()
    }
    
    let day: Int
    var aircraft: Int
    var helicopter: Int
    var tank: Int
    var apc: Int
    var artillery: Int
    var mrl: Int
    var drone: Int
    var navalShip: Int
    var aaw: Int
    var totalVehiclesAndFuelTanks: Int?
    var specialEquipment: Int?
    var cruiseMissiles: Int?
    var srbm: Int?
    var direction: String?
    
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
        case militaryAuto = "military auto"
        case fuelTank = "fuel tank"
        case vehiclesAndFuelTanks = "vehicles and fuel tanks"
        case specialEquipment = "special equipment"
        case cruiseMissiles = "cruise missiles"
        case srbm = "mobile SRBM system"
        case direction = "greatest losses direction"
    }
    
    // MARK: - Init
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.rawDate = try container.decode(String.self, forKey: .rawDate)
        self.day = try container.decode(Int.self, forKey: .day)
        self.aircraft = try container.decode(Int.self, forKey: .aircraft)
        self.helicopter = try container.decode(Int.self, forKey: .helicopter)
        self.tank = try container.decode(Int.self, forKey: .tank)
        self.apc = try container.decode(Int.self, forKey: .apc)
        self.artillery = try container.decode(Int.self, forKey: .artillery)
        self.mrl = try container.decode(Int.self, forKey: .mrl)
        self.drone = try container.decode(Int.self, forKey: .drone)
        self.navalShip = try container.decode(Int.self, forKey: .navalShip)
        self.aaw = try container.decode(Int.self, forKey: .aaw)
        self.specialEquipment = try container.decodeIfPresent(Int.self, forKey: .specialEquipment)
        self.cruiseMissiles = try container.decodeIfPresent(Int.self, forKey: .cruiseMissiles)
        self.srbm = try container.decodeIfPresent(Int.self, forKey: .srbm)
        self.direction = try container.decodeIfPresent(String.self, forKey: .direction)
        
        if let vehiclesAndFuelTanks = try container.decodeIfPresent(Int.self, forKey: .vehiclesAndFuelTanks)
        {
            self.totalVehiclesAndFuelTanks = vehiclesAndFuelTanks
        } else if let militaryAuto = try container.decodeIfPresent(Int.self, forKey: .militaryAuto),
                  let fuelTank = try container.decodeIfPresent(Int.self, forKey: .fuelTank)
        {
            self.totalVehiclesAndFuelTanks = militaryAuto + fuelTank
        }
    }
    
    // MARK: - Methods
    
    mutating func correct(source: EquipmentCorrectionModel) {
        self.aircraft += source.aircraft
        self.helicopter += source.helicopter
        self.tank += source.tank
        self.apc += source.apc
        self.artillery += source.artillery
        self.mrl += source.mrl
        self.drone += source.drone
        self.navalShip += source.navalShip
        self.aaw += source.aaw
        
        if self.specialEquipment != nil {
            self.specialEquipment! += source.specialEquipment
        }
        
        if self.totalVehiclesAndFuelTanks != nil {
            self.totalVehiclesAndFuelTanks! += source.vehiclesAndFuelTanks
        }
        
        if self.cruiseMissiles != nil {
            self.cruiseMissiles! += source.cruiseMissiles
        }
    }
}
