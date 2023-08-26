//
//  TotalPersonnelModel.swift
//  SmashedByThePaw
//
//  Created by Laslo on 26.08.2023.
//

import Foundation

struct TotalPersonnelModel: Codable {
    let data: TotalPersonnelData
    
    struct TotalPersonnelData: Codable {
        let stats: TotalPersonnelStats
        
        struct TotalPersonnelStats: Codable {
            let units: Int
            
            enum CodingKeys: String, CodingKey {
                case units = "personnel_units"
            }
        }
    }
}
