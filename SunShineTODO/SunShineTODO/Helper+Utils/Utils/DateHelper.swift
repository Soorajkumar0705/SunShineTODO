//
//  DateHelper.swift
//  Kado
//
//  Created by Suraj kahar on 22/03/25.
//


import Foundation


struct DateHelper {
   
    static let shared = DateHelper()
    
    func someTimeAgo(from date: Date) -> String {
        
        let now = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date, to: now)

        if let year = components.year, year > 0 {
            return year == 1 ? "1 year ago" : "\(year) years ago"
        }
        if let month = components.month, month > 0 {
            return month == 1 ? "1 month ago" : "\(month) months ago"
        }
        if let day = components.day, day > 0 {
            return day == 1 ? "1 day ago" : "\(day) days ago"
        }
        if let hour = components.hour, hour > 0 {
            return hour == 1 ? "1 hour ago" : "\(hour) hours ago"
        }
        if let minute = components.minute, minute > 0 {
            return minute == 1 ? "1 minute ago" : "\(minute) minutes ago"
        }
        if let second = components.second, second > 5 {
            return "\(second) seconds ago"
        }
        return "Just now"
    }
    
    func getISODateString() -> String?{
        
        let isoFormatter = ISO8601DateFormatter()
        isoFormatter.formatOptions = [
            .withFullDate,
            .withDashSeparatorInDate,
            .withTime,
            .withColonSeparatorInTime,
            .withTimeZone
        ]

        let currentDate = Date()
        return isoFormatter.string(from: currentDate)
    }

}
