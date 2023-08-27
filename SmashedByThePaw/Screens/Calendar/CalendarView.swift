//
//  CalendarView.swift
//  SmashedByThePaw
//
//  Created by Laslo on 27.08.2023.
//

import SwiftUI

struct CalendarView: View {
    
    // MARK: - Variables
    
    @EnvironmentObject var viewModel: CalendarViewModel
    @Environment(\.calendar) private var calendar
    @State private var selectedDate = Date()
    
    var calendarBounds: ClosedRange<Date> {
        if let startDate = self.calendar.date(
            from: DateComponents(
                timeZone: .gmt,
                year: 2022,
                month: 2,
                day: 24
            )
        ),
           let endDate = self.viewModel.equipment.last?.date
        {
            return startDate...endDate
        } else {
            return Date.now...Date.now
        }
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
        
        .onChange(of: self.viewModel.equipment) { newEquipment in
            self.selectedDate = newEquipment.last?.date ?? Date.now
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
        VStack {
            ZStack {
                Rectangle()
                self.datePicker
            }
            .foregroundColor(.custom.lightGreen)
            .opacity(0.6)
            .background(.ultraThinMaterial)
            .shadow(color: .black.opacity(0.2), radius: 16, x: 0, y: 0)
            
            self.statsView
        }
        .ignoresSafeArea(edges: .top)
    }
    
    private var datePicker: some View {
        DatePicker(
            "Date",
            selection: self.$selectedDate,
            in: self.calendarBounds,
            displayedComponents: .date
        )
        .datePickerStyle(.graphical)
        .padding(.horizontal, 24)
    }
    
    private var statsView: some View {
        List {
            ForEach(self.viewModel.equipment(for: self.selectedDate), id: \.self) { dayData in
                if let increasement = dayData.increasement, increasement > 0 {
                    self.cell(for: dayData)
                }
            }
        }
        .listStyle(.plain)
        .scrollIndicators(.never)
        .padding(.horizontal, 20)
    }
    
    private func cell(for dayData: EquipmentDayData) -> some View {
        HStack(alignment: .bottom) {
            Text(dayData.type.title)
                .foregroundColor(.custom.white)
            Spacer()
            if let increasement = dayData.increasement {
                Text("+\(increasement)")
                    .font(.title3)
                    .foregroundColor(.custom.white)
            }
        }
        .listRowBackground(Color.clear)
    }
}

#Preview {
    CalendarView()
}
