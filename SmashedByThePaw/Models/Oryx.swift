//
//  Oryx.swift
//  SmashedByThePaw
//
//  Created by Laslo on 28.08.2023.
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
