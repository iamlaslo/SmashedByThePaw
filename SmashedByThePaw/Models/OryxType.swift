//
//  OryxType.swift
//  SmashedByThePaw
//
//  Created by Laslo on 27.08.2023.
//

import SwiftUI

enum OryxType: String, Codable, CaseIterable {
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
    
    // MARK: - Methods
    
    var icon: Image {
        switch self {
        case .aircrafts:
            return Image.custom.aircraft
        case .antiAircraftWarfareSystems:
            return Image("")
        case .armouredPersonnelCarriers:
            return Image.custom.armouredVehicle
        case .artillerySystems:
            return Image.custom.artillery
        case .helicopters:
            return Image.custom.helicopter
        case .multipleRocketLaunchers:
            return Image.custom.mrl
        case .specialEquipment:
            return Image.custom.specialEquipment
        case .tanks:
            return Image.custom.tank
        case .unmannedAerialVehicles:
            return Image.custom.drone
        case .vehicleAndFuelTank:
            return Image.custom.fuelTank
        case .warshipsBoats:
            return Image.custom.warship
        }
    }
    
    var title: String {
        switch self {
        case .aircrafts:
            return "Aircrafts"
        case .antiAircraftWarfareSystems:
            return "AAWS"
        case .armouredPersonnelCarriers:
            return "APC"
        case .artillerySystems:
            return "Artillery Systems"
        case .helicopters:
            return "Helicopters"
        case .multipleRocketLaunchers:
            return "MRL"
        case .specialEquipment:
            return "Special Equipment"
        case .tanks:
            return "Tanks"
        case .unmannedAerialVehicles:
            return "Drones"
        case .vehicleAndFuelTank:
            return "Vehicles"
        case .warshipsBoats:
            return "Warships"
        }
    }
    
    func equipmentCount(for equipment: EquipmentModel?) -> Int? {
        switch self {
        case .aircrafts:
            return equipment?.aircraft
        case .antiAircraftWarfareSystems:
            return equipment?.aaw
        case .armouredPersonnelCarriers:
            return equipment?.apc
        case .artillerySystems:
            return equipment?.artillery
        case .helicopters:
            return equipment?.helicopter
        case .multipleRocketLaunchers:
            return equipment?.mrl
        case .specialEquipment:
            return equipment?.specialEquipment
        case .tanks:
            return equipment?.tank
        case .unmannedAerialVehicles:
            return equipment?.drone
        case .vehicleAndFuelTank:
            return equipment?.totalVehiclesAndFuelTanks
        case .warshipsBoats:
            return equipment?.navalShip
        }
    }
}
