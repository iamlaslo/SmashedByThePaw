//
//  SmashedByThePawApp.swift
//  SmashedByThePaw
//
//  Created by Laslo on 26.08.2023.
//

import SwiftUI

@main
struct SmashedByThePawApp: App {
    
    enum Tab {
        case oryx
        case calendar
    }
    
    // MARK: - Variables
    
    @State private var selectedTab: Tab = .oryx
    private let networkManager = NetworkManager()
    
    // MARK: - Body
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                TabView(selection: self.$selectedTab) {
                    self.oryxTab
                    self.calendarTab
                }
            }
            .accentColor(.white)
        }
    }
    
    // MARK: - Views
    
    @MainActor
    private var oryxTab: some View {
        var viewModel: OryxViewModel {
            OryxViewModel(networkManager: self.networkManager)
        }
        
        return OryxView()
            .environmentObject(viewModel)
            .tabItem {
                Label(
                    title: { Text("Oryx") },
                    icon: { Image.custom.oryxTabIcon }
                )
            }
            .toolbar(.visible, for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
    }
    
    @MainActor
    private var calendarTab: some View {
        var viewModel: CalendarViewModel {
            CalendarViewModel(networkManager: self.networkManager)
        }
        
        return CalendarView()
            .environmentObject(viewModel)
            .tabItem {
                Label(
                    title: { Text("Calendar") },
                    icon: { Image(systemName: "calendar") }
                )
            }
            .toolbar(.visible, for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
    }
}
