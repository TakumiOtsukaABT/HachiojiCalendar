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
    
    static var sched = [DateWithSchedule]()
    
    var calendar = Calendar.current
    
    func plusMonth(date: Date) -> Date {
        let year = 2022
        let month = 3
        let next = calendar.date(byAdding: .month, value: 1, to: date)!
        let components = calendar.dateComponents([.year], from: next)
        let monthcomponents = calendar.dateComponents([.month], from: next)
        if year == components.year {
            return next
        }else if month >= monthcomponents.month!{
            return next
        }
        return calendar.date(byAdding: .month, value: 0, to: date)!
    }
    
    func minusMonth(date: Date) -> Date {
        let year = 2022
        let month = 3
        let previous = calendar.date(byAdding: .month, value: -1, to: date)!
        let components = calendar.dateComponents([.year], from: previous)
        let monthcomponents = calendar.dateComponents([.month], from: previous)
        if year == components.year {
            return previous
        }else if month >= monthcomponents.month!{
            return previous
        }
        return calendar.date(byAdding: .month, value: 0, to: date)!
    }
    
    func getSeason(date:Date) -> Int {
        let year = 2022

        let components = calendar.dateComponents([.month], from: date)
        let yearcomponents = calendar.dateComponents([.year], from: date)
        if year == yearcomponents.year{
            return (components.month!-1)/3
        } else {
            return 4
        }
    }
    
    func garbageTypeString(typeInt: GarbageType) -> String? {
        switch typeInt {
        case .non:
            return nil
        case .burn:
            return "gomibukuro_blue"
        case .nonburn:
            return "gomibukuro_yellow"
        case .bottle:
            return "bottle"
        case .plastic:
            return "plastic"
        case .bin:
            return "bin"
        case .can:
            return "can"
        case .box:
            return "box"
        case .cloth:
            return "cloth"
        case .yuugai:
            return "yuugai"
        case .newspaper:
            return "newspaper"
        case .magazine:
            return "magazine"
        case .paperPack:
            return "paperPack"
        case .branch:
            return "branch"
        }
    }
    
    func getGarbageTypeString(garbage: GarbageType) -> String? {
        switch garbage {
        case .non:
            return nil
        case .burn:
            return "????????????"
        case .nonburn:
            return "????????????"
        case .bottle:
            return "??????????????????"
        case .plastic:
            return "??????????????????"
        case .bin:
            return "??????"
        case .can:
            return "???"
        case .box:
            return "????????????"
        case .cloth:
            return "???"
        case .yuugai:
            return "???????????????????????????????????????"
        case .newspaper:
            return "?????????"
        case .magazine:
            return "???????????????"
        case .paperPack:
            return "????????????"
        case .branch:
            return "?????????"
        }
    }
    
    func monthString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        return dateFormatter.string(from: date)
    }
    
    func monthJapaneseString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM"
        return dateFormatter.string(from: date) + "???"
    }
    
    func getOnlyMonth(date: Date) -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM"
        return Int(dateFormatter.string(from: date))!
    }
    
    func getOnlyDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        return dateFormatter.string(from: date)
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
