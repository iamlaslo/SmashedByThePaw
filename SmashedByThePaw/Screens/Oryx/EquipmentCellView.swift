//
//  EquipmentCellView.swift
//  SmashedByThePaw
//
//  Created by Laslo on 27.08.2023.
//

import SwiftUI

struct EquipmentCellView: View {
    
    // MARK: - Variables
    
    let type: OryxType
    let count: Int
    let increasement: Int
    
    let whiteColor = Color.white.opacity(0.6)
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            self.backgroundView
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
            
            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    self.iconView
                    Spacer()
                    if increasement > 0 {
                        self.increasementView
                    }
                }
                Spacer()
                self.infoView
            }
            .padding([.leading, .top, .bottom], 15)
            .padding(.trailing, 12)
        }
        .aspectRatio(1, contentMode: .fit)
    }
    
    // MARK: - Views
    
    private var backgroundView: some View {
        RoundedRectangle(cornerRadius: 25, style: .continuous)
            .foregroundColor(.clear)
    }
    
    private var iconView: some View {
        self.type.icon
            .resizable()
            .scaledToFit()
            .frame(height: 60)
            .foregroundColor(.custom.white)
    }
    
    private var infoView: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("\(self.count)")
                .font(.largeTitle.monospacedDigit())
                .foregroundColor(.custom.white)
            
            Text(self.type.title)
                .foregroundColor(.custom.white)
        }
    }
    
    private var increasementView: some View {
        Text("+\(self.increasement)")
            .monospacedDigit()
            .foregroundColor(.custom.white)
            .padding(.horizontal, 10)
            .background {
                RoundedRectangle(cornerRadius: 40, style: .continuous)
                    .foregroundColor(.custom.darkGreen)
                    .frame(height: 25)
            }
    }
}
