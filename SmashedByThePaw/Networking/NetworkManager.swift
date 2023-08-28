//
//  NetworkManager.swift
//  SmashedByThePaw
//
//  Created by Laslo on 26.08.2023.
//

import Foundation

struct NetworkManager {
    enum Endpoint: String {
        static let base = "https://raw.githubusercontent.com/MacPaw/2022-Ukraine-Russia-War-Dataset/main/data/"
        
        case equipment = "russia_losses_equipment.json"
        case equipmentCorrection = "russia_losses_equipment_correction.json"
        case oryx = "russia_losses_equipment_oryx.json"
        case personnel = "russia_losses_personnel.json"
        case totalPersonnel = "https://russianwarship.rip/api/v1/statistics/latest"
        
        var urlString: String {
            if self == .totalPersonnel {
                return self.rawValue
            } else {
                return Self.base + self.rawValue
            }
        }
    }
    
    func fetch<T: Decodable>(from endpoint: Endpoint) async throws -> T {
        guard let url = URL(string: endpoint.urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let result = try JSONDecoder().decode(T.self, from: data)
        
        return result
    }
}
