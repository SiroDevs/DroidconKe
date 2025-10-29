//
//  DateUtils.swift
//  DroidconKe
//
//  Created by @sirodevs on 23/10/2025.
//

import Foundation

class DateUtils {
    static func formatTime(_ timeString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        
        guard let date = formatter.date(from: timeString) else { return timeString }
        
        formatter.dateFormat = "h:mm a"
        return formatter.string(from: date)
    }
}
