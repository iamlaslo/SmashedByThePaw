//
//  DetailsView.swift
//  SmashedByThePaw
//
//  Created by Laslo on 27.08.2023.
//

import SwiftUI

struct DetailsView: View {
    
    // MARK: - Variables
    
    let type: OryxType
    let models: [EquipmentOryxModel]
    
    var filteredModels: [OryxManufacturer : [ModelWithLosses]] {
        var result: [OryxManufacturer : [ModelWithLosses]] = [:]
        self.models.forEach {
            result[$0.manufacturer, default: []].append(
                ModelWithLosses(model: $0.model, losses: $0.lossesTotal)
            )
        }
        return result
    }
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [.custom.lightGreen, .custom.midGreen],
                startPoint: .top,
                endPoint: .bottom
            )
                .ignoresSafeArea()
            
            List {
                ForEach(Array(self.filteredModels.keys), id: \.self) { key in
                    Section {
                        if let country = self.filteredModels[key] {
                            ForEach(country.sorted(by: { $0.model < $1.model })) { model in
                                self.cell(for: model)
                            }
                        } else {
                            EmptyView()
                        }
                    } header: {
                        Text(key.title)
                            .font(.title)
                            .foregroundColor(.white)
                    }
                }
            }
            .listStyle(.plain)
        }
    }
    
    // MARK: - Views
    
    private func cell(for model: ModelWithLosses) -> some View {
        HStack {
            Text(model.model)
                .foregroundColor(.custom.white)
            
            Spacer()
            
            Text("\(model.losses)")
                .font(.title3)
                .foregroundColor(.custom.white)
        }
        .listRowBackground(Color.clear)
    }
}

struct DetailsView_Preview: PreviewProvider {
    static var previews: some View {
        DetailsView(type: .aircrafts, models: [])
    }
}
