//
//  OryxView.swift
//  SmashedByThePaw
//
//  Created by Laslo on 26.08.2023.
//

import SwiftUI

struct OryxView: View {
    
    // MARK: - Variables
    
    @EnvironmentObject private var viewModel: OryxViewModel
    @State private var personnelCount: Int = 0
    @State private var personnelCountTimer = Timer.publish(every: 2.5, on: .main, in: .common)
    
    private var gridColumns: [GridItem] {
        return Array(repeating: GridItem(spacing: 15), count: 2)
    }
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            self.backgroundGradientView
            self.contentView
            
            if self.viewModel.isLoading {
                self.loaderView
            }
        }
        .navigationDestination(for: OryxType.self) { selectedType in
            DetailsView(
                type: selectedType,
                models: self.viewModel.oryx(for: selectedType)
            )
            .navigationTitle(selectedType.title)
            .navigationBarTitleDisplayMode(.large)
        }
    }
    
    // MARK: - Views
    
    private var loaderView: some View {
        ZStack {
            Color.black.opacity(0.3)
                .background(.ultraThinMaterial)
            ProgressView()
                .progressViewStyle(.circular)
        }
        .ignoresSafeArea()
    }
    
    private var backgroundGradientView: some View {
        LinearGradient(
            colors: [.custom.lightGreen, .custom.midGreen],
            startPoint: .top,
            endPoint: .bottom
        )
            .ignoresSafeArea()
    }
    
    private var contentView: some View {
        ZStack(alignment: .top) {
            VStack {
                self.equipmentGrid
                    .padding(.vertical, 30)
            }
            .padding(.horizontal, 20)
            .ignoresSafeArea()
            
            ZStack {
                Rectangle()
                    .foregroundColor(.custom.lightGreen)
                    .opacity(0.6)
                    .frame(height: 200)
                    .background(.ultraThinMaterial)
                    .shadow(color: .black.opacity(0.2), radius: 16, x: 0, y: 0)
                
                self.personnelCountView
                    .offset(y: 30)
            }
            .frame(height: 200)
            .ignoresSafeArea(edges: .top)
        }
    }
    
    private var personnelCountView: some View {
        VStack(spacing: 5) {
            Text("\(self.personnelCount)")
                .font(.largeTitle.bold())
                .foregroundColor(.custom.white)
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
                .scaleEffect(CGSize(width: 1.5, height: 1.5), anchor: .center)
            
            Text("Personnel")
                .font(.title2)
                .foregroundColor(.custom.white)
        }
        
    }
    
    private var equipmentGrid: some View {
        ScrollView(showsIndicators: false) {
            Spacer(minLength: 195)
            LazyVGrid(columns: self.gridColumns, spacing: 15) {
                ForEach(OryxType.allCases, id: \.self) { type in
                    NavigationLink(value: type) {
                        EquipmentCellView(
                            type: type,
                            count: self.viewModel.todayCount(for: type) ?? 0,
                            increasement: self.viewModel.todayDifference(for: type) ?? 0
                        )
                    }
                }
            }
            Spacer(minLength: 70)
        }
    }
    
    // MARK: - Methods
    
    private func startPersonnelIncreateTimer() {
        let _ = self.personnelCountTimer.connect()
    }
}

struct OryxView_Preview: PreviewProvider {
    static var previews: some View {
        OryxView()
    }
}
