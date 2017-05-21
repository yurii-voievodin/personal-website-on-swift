//
//  Date.swift
//  PersonalWebSiteOnSwift
//
//  Created by Yura Voevodin on 21.05.17.
//
//

import Foundation

extension Date {
    
    /// Generate string representation of date with format "dd MMMM yyyy"
    var humanReadable: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, dd MMMM yyyy"
        return formatter.string(from: self)
    }
    
    /// "dd MMMM yyyy"
    var dayMonthYear: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        return formatter.string(from: self)
    }
    
    /// Components od day, month, year as Int from date
    var calendarComponents: (day: Int, month: Int, year: Int)? {
        let components = Calendar.current.dateComponents([.day, .month, .year], from: self)
        guard let day = components.day, let month = components.month, let year = components.year else { return nil }
        return (day, month, year)
    }
}
