//
//  SessionTabDates.swift
//  DroidconKe
//
//  Created by @sirodevs on 23/10/2025.
//

import SwiftUI

struct SessionTabDates: View {
    let availableDates: [String]
    @Binding var selectedDate: String
    
    public init(availableDates: [String], selectedDate: Binding<String>) {
        self.availableDates = availableDates
        self._selectedDate = selectedDate
    }
    
    public var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(Array(availableDates.enumerated()), id: \.offset) { index, date in
                    DateChip(
                        date: date,
                        dayNumber: index + 1,
                        isSelected: selectedDate == date
                    ) {
                        selectedDate = date
                    }
                }
            }
        }
    }
}

struct DateChip: View {
    let date: String
    let dayNumber: Int
    let isSelected: Bool
    let action: () -> Void
    
    private var daySuffix: String {
        let day = getDayFromDate(date)
        switch day {
        case 1, 21, 31: return "st"
        case 2, 22: return "nd"
        case 3, 23: return "rd"
        default: return "th"
        }
    }
    
    private func getDayFromDate(_ dateString: String) -> Int {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let date = formatter.date(from: dateString) else { return 0 }
        
        let calendar = Calendar.current
        return calendar.component(.day, from: date)
    }
    
    private var formattedDate: String {
        let day = getDayFromDate(date)
        return "\(day)\(daySuffix)"
    }
    
    private var formattedDay: String {
        return "Day \(dayNumber)"
    }
    
    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 2) {
                Text(formattedDate)
                    .font(.subheadline)
                    .fontWeight(.bold)
                
                Text(formattedDay)
                    .font(.caption2)
                    .fontWeight(.medium)
            }
            .foregroundColor(isSelected ? .white : .primary)
            .padding(.horizontal, 5)
            .padding(.vertical, 5)
            .background(isSelected ? .redOrange : Color(.systemGray6))
            .cornerRadius(5)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    TestTab(sessions: SessionEntity.sampleSessions)
}
