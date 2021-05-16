//
//  CalendarHelper.swift
//  GarBageCalendar2
//
//  Created by Takumi Otsuka on 2021/05/15.
//

import Foundation
import UIKit

class CalendarHelper
{
    var calendar = Calendar.current
    
    func plusMonth(date: Date) -> Date {
        let year = 2021
        let next = calendar.date(byAdding: .month, value: 1, to: date)!
        let components = calendar.dateComponents([.year], from: next)
        if year == components.year {
            return next
        }
        return calendar.date(byAdding: .month, value: 0, to: date)!        
    }
    
    func minusMonth(date: Date) -> Date {
        let year = 2021
        let previous = calendar.date(byAdding: .month, value: -1, to: date)!
        let components = calendar.dateComponents([.year], from: previous)
        if year == components.year {
            return previous
        }
        return calendar.date(byAdding: .month, value: 0, to: date)!
    }
    
    func monthString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        return dateFormatter.string(from: date)
    }
    
    func monthJapaneseString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM"
        return dateFormatter.string(from: date) + "月"
    }
    
    func yearString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: date)
    }
    
    func daysInMonth(date: Date) -> Int {
        let range = calendar.range(of: .day, in: .month, for: date)!
        return range.count
    }
    
    func dayOfMonth(date: Date) -> Int {
        let components = calendar.dateComponents([.day], from: date)
        return components.day!
    }
    
    func firstOfMonth(date: Date) -> Date {
        let components = calendar.dateComponents([.year, .month], from: date)
        return calendar.date(from: components)!
    }
    
    func weekDay(date: Date) -> Int {
        let components = calendar.dateComponents([.weekday], from: date)
        return components.weekday! - 1
    }
}
