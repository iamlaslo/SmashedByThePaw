//
//  PersonnelModel.swift
//  SmashedByThePaw
//
//  Created by Laslo on 26.08.2023.
//

import Foundation

struct PersonnelModel: Codable, Hashable, Identifiable {
    
    enum PersonnelModifier: String, Codable {
        case about
        case more
    }
    
    // MARK: - Properties
    
    var id: String {
        self.rawDate
    }
    
    let rawDate: String
    var date: Date? {
        self.rawDate.asDate()
    }
    
    let day: Int
    let personnelValue: Int
    let personnelModifier: PersonnelModifier
    let pow: Int?
    
    // MARK: - Coding Keys
    
    enum CodingKeys: String, CodingKey {
        case rawDate = "date"
        case day
        case personnelValue = "personnel"
        case personnelModifier = "personnel*"
        case pow = "POW"
    }
}
