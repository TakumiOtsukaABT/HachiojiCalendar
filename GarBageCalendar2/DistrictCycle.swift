//
//  DistrictCycle.swift
//  GarBageCalendar2
//
//  Created by Takumi Otsuka on 2021/05/16.
//

import Foundation
class CalendarCycle{
    let district1: [[[[Int]]]] = // [season][0 or 1][day][youso]
        [
            [
                [[0],[1,4],[5,9],[11,7,10],[1],[3],[0]],
                [[0],[1,4],[8,6],[0],[1,2],[0],[0]]
            ],
            [
                [[0],[1,4],[8,6],[10],[1,2],[0],[0]],
                [[0],[1,4],[5,9],[11,7],[1],[3],[0]]
            ],
            [
                [[0],[1,4],[5,9],[11,7,10],[1],[3],[0]],
                [[0],[1,4],[8,6],[0],[1,2],[0],[0]]
            ],
            [
                [[0],[1,4],[8,6],[10],[1,2],[0],[0]],
                [[0],[1,4],[5,9],[11,7],[1],[3],[0]]            ]
        ]
}

enum GarbageType:Int{
    case non = 0
    case burn = 1
    case nonburn = 2
    case bottle = 3
    case plastic = 4
    case bin = 5
    case can = 6
    case box = 7
    case cloth = 8
    case yuugai = 9
    case newspaper = 10
    case magazine = 11
}
