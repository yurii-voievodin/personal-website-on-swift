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
}
