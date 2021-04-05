//
//  DateExtension.swift
//  ProductsList
//
//  Created by Yahia El-Dow on 05/04/2021.
//

import Foundation

extension NSDate {
    func toDate() -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat="yyyy-MM-dd HH:mm:ss Z"
        return formatter.date(from: self.description) ?? Date()
    }
    
}
