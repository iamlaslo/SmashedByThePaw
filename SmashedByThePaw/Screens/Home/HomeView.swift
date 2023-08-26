//
//  HomeView.swift
//  SmashedByThePaw
//
//  Created by Laslo on 26.08.2023.
//

import SwiftUI

struct HomeView: View {
    
    // MARK: - Variables
    
    @ObservedObject var viewModel = HomeViewModel()
    
    @State private var personnelCount: Int = 0
    @State private var personnelCountTimer = Timer.publish(every: 2.5, on: .main, in: .common)
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(alignment: .center) {
                self.personnelCountView
                    .font(.largeTitle.bold())
                    .foregroundColor(.red)
                
                HStack {
                    self.equipmentCellView
                    self.equipmentCellView
                }
                
                Spacer()
            }
            .padding()
        }
    }
    
    // MARK: - Views
    
    private var personnelCountView: some View {
        Text("\(self.personnelCount)")
            .monospacedDigit()
            .animation(.linear, value: self.personnelCount)
            .onChange(of: self.viewModel.totalPersonnel) { newValue in
                if let newValue {
                    self.personnelCount = newValue
                    self.startPersonnelIncreateTimer()
                }
            }
            .onReceive(self.personnelCountTimer) { _ in
                self.personnelCount += 1
            }
    }
    
    private var equipmentCellView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .foregroundColor(.gray)
            
            
            VStack {
                Spacer()
                
                Image.custom.missile
                    .resizable()
                    .scaledToFit()
                    .frame(width: 75)
                    .foregroundColor(.black)
                
                Spacer()
                
                Text("\(self.viewModel.oryx?.total(of: .aircrafts) ?? 0)")
                    .font(.largeTitle)
                    .overlay {
                        ZStack {
                            RoundedRectangle(cornerRadius: 40, style: .continuous)
                                .foregroundColor(.black)
                                .frame(width: 35, height: 25)
                            
                            Text("+1")
                                .italic()
                                .foregroundColor(.white)
                        }
                        .offset(x: 40, y: -10)
                    }
            }
            .padding()
        }
        .aspectRatio(1, contentMode: .fit)
    }
    
    // MARK: - Methods
    
    private func startPersonnelIncreateTimer() {
        let _ = self.personnelCountTimer.connect()
    }
}

#Preview {
    HomeView()
}
