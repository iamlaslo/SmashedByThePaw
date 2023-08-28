//
//  OryxManufacturer.swift
//  SmashedByThePaw
//
//  Created by Laslo on 28.08.2023.
//

import Foundation

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
