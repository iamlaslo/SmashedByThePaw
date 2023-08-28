//
//  ModelWithLosses.swift
//  SmashedByThePaw
//
//  Created by Laslo on 28.08.2023.
//

import Foundation

struct ModelWithLosses: Identifiable, Hashable {
    let id = UUID()
    var model: String
    var losses: Int
}
