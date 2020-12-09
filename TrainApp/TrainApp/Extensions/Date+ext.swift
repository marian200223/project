//
//  Date+ext.swift
//  TrainApp
//
//  Created by Marian Iconaru on 9/12/20.
//

import Foundation

extension Date {
    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }
    
    static func difference(lhs: Date, rhs: Date) -> DateComponents {
        let differenceComp = Calendar.current.dateComponents([.hour, .minute], from: lhs, to: rhs)
        return differenceComp
    }
}
