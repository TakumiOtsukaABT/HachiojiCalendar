//
//  DistrictCycle.swift
//  GarBageCalendar2
//
//  Created by Takumi Otsuka on 2021/05/16.
//

import Foundation
class CalendarCycle{
    let district1: [[[[[Int]]]]] = // [district][season][0 or 1][day][youso]
        [
            [//district1
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
                    [[0],[1,4],[8,6],[0],[1,2],[3],[0]]
                ],
                [
                    [[0],[1,4],[8,6],[10],[1,2],[0],[0]],
                    [[0],[1,4],[5,9],[11,7],[1],[3],[0]]
                ],
                [
                    [[0],[1,4],[6,8],[10],[1,2],[0],[0]],
                    [[0],[1,4],[5,9],[11,7],[1],[3],[0]]
                ]
            ],
            [//district2
                [
                    [[0],[1,4],[8,6],[10],[1,2],[0],[0]],
                    [[0],[1,4],[5,9],[11,7],[1],[3],[0]]
                ],
                [
                    [[0],[1,4],[5,9],[11,7,10],[1],[3],[0]],
                    [[0],[1,4],[8,6],[0],[1,2],[0],[0]]
                ],
                [
                    [[0],[1,4],[8,6],[10],[1,2],[3],[0]],
                    [[0],[1,4],[5,9],[11,7],[1],[3],[0]]
                ],
                [
                    [[0],[1,4],[5,9],[11,7,10],[1],[3],[0]],
                    [[0],[1,4],[8,6],[0],[1,2],[0],[0]]
                ],
                [
                    [[0],[1,4],[5,9],[11,7,10],[1],[3],[0]],
                    [[0],[1,4],[8,6],[0],[1,2],[0],[0]]
                ]
            ],
            [ //district3
                [
                    [[0],[4],[1,5,9],[11,7],[0],[1,3],[0]],
                    [[0],[4],[1,8,6],[10],[2],[1],[0]]
                ],
                [
                    [[0],[4],[1,8,6],[0],[2],[1],[0]],
                    [[0],[4],[1,5,9],[10,11,7],[0],[1,3],[0]]
                ],
                [
                    [[0],[4],[1,5,9],[11,7],[0],[1,3],[0]],
                    [[0],[4],[1,8,6],[10],[2],[1,3],[0]]
                ],
                [
                    [[0],[4],[1,8,6],[0],[2],[1,3],[0]],
                    [[0],[4],[1,5,9],[10,11,7],[0],[1,3],[0]]
                ],
                [
                    [[0],[4],[1,8,6],[0],[2],[1],[0]],
                    [[0],[4],[1,5,9],[10,11,7],[0],[1,3],[0]]
                ]
            ],
            [// district 4
                [
                    [[0],[1,3],[4],[10,5,9],[1,7,11],[0],[0]],
                    [[0],[1],[4],[8,6],[1],[2],[0]]
                ],
                [
                    [[0],[1],[4],[10,8,6],[1],[2],[0]],
                    [[0],[1,3],[4],[5,9],[1,7,11],[0],[0]]
                ],
                [
                    [[0],[1,3],[4],[10,5,9],[1,7,11],[0],[0]],
                    [[0],[1,3],[4],[8,6],[1],[2],[0]]
                ],
                [
                    [[0],[1],[4],[10,8,6],[1],[2],[0]],
                    [[0],[1,3],[4],[5,9],[1,7,11],[0],[0]]
                ],
                [
                    [[0],[1],[4],[10,8,6],[1],[2],[0]],
                    [[0],[1,3],[4],[5,9],[1,7,11],[0],[0]]
                ]
            ],
            [// district 5
                [
                    [[0],[1],[4],[10,8,6],[1],[2],[0]],
                    [[0],[1,3],[4],[5,9],[1,7,11],[0],[0]]
                ],
                [
                    [[0],[1,3],[4],[10,5,9],[1,7,11],[0],[0]],
                    [[0],[1],[4],[8,6],[1],[2],[0]]
                ],
                [
                    [[0],[1,3],[4],[10,8,6],[1],[2],[0]],
                    [[0],[1,3],[4],[5,9],[1,7,11],[0],[0]]
                ],
                [
                    [[0],[1,3],[4],[10,5,9],[1,7,11],[0],[0]],
                    [[0],[1],[4],[8,6],[1],[2],[0]]
                ],
                [
                    [[0],[1,3],[4],[10,5,9],[1,7,11],[0],[0]],
                    [[0],[1],[4],[8,6],[1],[2],[0]]
                ]
            ],
            [// district 6
                [
                    [[0],[3],[1,4],[5,9],[7,11],[1],[0]],
                    [[0],[0],[1,4],[10,8,6],[0],[1,2],[0]]
                ],
                [
                    [[0],[0],[1,4],[8,6],[0],[1,2],[0]],
                    [[0],[3],[1,4],[10,5,9],[7,11],[1],[0]]
                ],
                [
                    [[0],[3],[1,4],[5,9],[7,11],[1],[0]],
                    [[0],[3],[1,4],[10,8,6],[0],[1,2],[0]]
                ],
                [
                    [[0],[0],[1,4],[8,6],[0],[1,2],[0]],
                    [[0],[3],[1,4],[10,5,9],[7,11],[1],[0]]
                ],
                [
                    [[0],[0],[1,4],[8,6],[0],[1,2],[0]],
                    [[0],[3],[1,4],[10,11,7],[7,11],[1],[0]]
                ]
            ],
            [// district 7
                [
                    [[0],[0],[1,4],[8,6],[0],[1,2],[0]],
                    [[0],[3],[1,4],[10,5,9],[7,11],[1],[0]]
                ],
                [
                    [[0],[3],[1,4],[5,9],[7,11],[1],[0]],
                    [[0],[0],[1,4],[10,8,6],[0],[1,2],[0]]
                ],
                [
                    [[0],[3],[1,4],[8,6],[0],[1,2],[0]],
                    [[0],[3],[1,4],[10,5,9],[7,11],[1],[0]]
                ],
                [
                    [[0],[3],[1,4],[5,9],[7,11],[1],[0]],
                    [[0],[0],[1,4],[10,8,6],[0],[1,2],[0]]
                ],
                [
                    [[0],[3],[1,4],[5,9],[7,11],[1],[0]],
                    [[0],[0],[1,4],[10,8,6],[0],[1,2],[0]]
                ]
            ],
            [// district 8
                [
                    [[0],[1],[3],[10,4],[1,5,9],[7,11],[0]],
                    [[0],[1,2],[0],[4],[1,8,6],[0],[0]]
                ],
                [
                    [[0],[1,2],[0],[10,4],[1,8,6],[0],[0]],
                    [[0],[1],[3],[4],[1,5,9],[7,11],[0]]
                ],
                [
                    [[0],[1],[3],[10,4],[1,5,9],[7,11],[0]],
                    [[0],[1,2],[3],[4],[1,8,6],[0],[0]]
                ],
                [
                    [[0],[1,2],[0],[10,4],[1,8,6],[0],[0]],
                    [[0],[1],[3],[4],[1,5,9],[7,11],[0]]
                ],
                [
                    [[0],[1,2],[0],[10,4],[1,8,6],[0],[0]],
                    [[0],[1],[3],[4],[1,5,9],[11,7],[0]]
                ]
            ],
            [// district 9
                [
                    [[0],[1,2],[0],[10,4],[1,8,6],[0],[0]],
                    [[0],[1],[3],[4],[1,5,9],[7,11],[0]]
                ],
                [
                    [[0],[1],[3],[10,4],[1,5,9],[7,11],[0]],
                    [[0],[1,2],[0],[4],[1,8,6],[0],[0]]
                ],
                [
                    [[0],[1,2],[3],[10,4],[1,8,6],[0],[0]],
                    [[0],[1],[3],[4],[1,5,9],[7,11],[0]]
                ],
                [
                    [[0],[1],[3],[10,4],[1,5,9],[7,11],[0]],
                    [[0],[1,2],[0],[4],[1,8,6],[0],[0]]
                ],
                [
                    [[0],[1],[3],[10,4],[1,5,9],[7,11],[0]],
                    [[0],[1,2],[0],[4],[1,8,6],[0],[0]]
                ]
            ],
            [// district 10
                [
                    [[0],[0],[1,3],[4],[5,9],[1,7,11],[0]],
                    [[0],[2],[1],[10,4],[8,6],[1],[0]]
                ],
                [
                    [[0],[2],[1],[4],[8,6],[1],[0]],
                    [[0],[0],[1,3],[10,4],[5,9],[1,7,11],[0]]
                ],
                [
                    [[0],[0],[1,3],[4],[5,9],[1,7,11],[0]],
                    [[0],[2],[1,3],[10,4],[8,6],[1],[0]]
                ],
                [
                    [[0],[2],[1],[4],[8,6],[1],[0]],
                    [[0],[0],[1,3],[10,4],[5,9],[1,7,11],[0]]
                ],
                [
                    [[0],[2],[1],[4],[8,6],[1],[0]],
                    [[0],[0],[1,3],[10,4],[5,9],[1,7,11],[0]]
                ]
            ],
            [// district 11
                [
                    [[0],[2],[1],[4],[8,6],[1],[0]],
                    [[0],[0],[1,3],[10,4],[5,9],[1,7,11],[0]]
                ],
                [
                    [[0],[0],[1,3],[4],[5,9],[1,7,11],[0]],
                    [[0],[2],[1],[10,4],[8,6],[1],[0]]
                ],
                [
                    [[0],[2],[1,3],[4],[8,6],[1],[0]],
                    [[0],[0],[1,3],[10,4],[5,9],[1,7,11],[0]]
                ],
                [
                    [[0],[0],[1,3],[4],[5,9],[1,7,11],[0]],
                    [[0],[2],[1],[10,4],[8,6],[1],[0]]
                ],
                [
                    [[0],[0],[1,3],[4],[5,9],[1,7,11],[0]],
                    [[0],[2],[1],[10,4],[8,6],[1],[0]]
                ]
            ],
            [// district 12
                [
                    [[0],[1,7,11],[0],[10,3],[1,4],[5,9],[0]],
                    [[0],[1],[2],[0],[1,4],[8,6],[0]]
                ],
                [
                    [[0],[1],[2],[10],[1,4],[8,6],[0]],
                    [[0],[1,7,11],[0],[3],[1,4],[5,9],[0]]
                ],
                [
                    [[0],[1,7,11],[0],[10,3],[1,4],[5,9],[0]],
                    [[0],[1],[2],[3],[1,4],[8,6],[0]]
                ],
                [
                    [[0],[1],[2],[10],[1,4],[8,6],[0]],
                    [[0],[1,7,11],[0],[3],[1,4],[5,9],[0]]
                ],
                [
                    [[0],[1],[2],[10],[1,4],[8,6],[0]],
                    [[0],[1,7,11],[0],[3],[1,4],[5,9],[0]]
                ]
            ],
            [// district 13
                [
                    [[0],[1],[2],[10],[1,4],[8,6],[0]],
                    [[0],[1,7,11],[0],[3],[1,4],[5,9],[0]]
                ],
                [
                    [[0],[1,7,11],[0],[10,3],[1,4],[5,9],[0]],
                    [[0],[1],[2],[0],[1,4],[8,6],[0]]
                ],
                [
                    [[0],[1],[2],[10,3],[1,4],[8,6],[0]],
                    [[0],[1,7,11],[0],[3],[1,4],[5,9],[0]]
                ],
                [
                    [[0],[1,7,11],[0],[10,3],[1,4],[5,9],[0]],
                    [[0],[1],[2],[0],[1,4],[8,6],[0]]
                ]
            ],
            [// district 14
                [
                    [[0],[7,11],[1],[3],[4],[1,5,9],[0]],
                    [[0],[0],[1,2],[10],[4],[1,8,6],[0]]
                ],
                [
                    [[0],[0],[1,2],[0],[4],[1,8,6],[0]],
                    [[0],[7,11],[1],[10,3],[4],[1,5,9],[0]]
                ],
                [
                    [[0],[7,11],[1],[3],[4],[1,5,9],[0]],
                    [[0],[0],[1,2],[10,3],[4],[1,8,6],[0]]
                ],
                [
                    [[0],[0],[1,2],[0],[4],[1,8,6],[0]],
                    [[0],[7,11],[1],[10,3],[4],[1,5,9],[0]]
                ]
            ],
            [// district 15
                [
                    [[0],[0],[1,2],[0],[4],[1,8,6],[0]],
                    [[0],[7,11],[1],[10,3],[4],[1,5,9],[0]]
                ],
                [
                    [[0],[7,11],[1],[3],[4],[1,5,9],[0]],
                    [[0],[0],[1,2],[10],[4],[1,8,6],[0]]
                ],
                [
                    [[0],[0],[1,2],[3],[4],[1,8,6],[0]],
                    [[0],[7,11],[1],[10,3],[4],[1,5,9],[0]]
                ],
                [
                    [[0],[7,11],[1],[3],[4],[1,5,9],[0]],
                    [[0],[0],[1,2],[10],[4],[1,8,6],[0]]
                ]
            ],
            [// district 16
                [
                    [[0],[1,5,9],[7,11],[10],[1,3],[4],[0]],
                    [[0],[1,8,6],[0],[2],[1],[4],[0]]
                ],
                [
                    [[0],[1,8,6],[0],[10,2],[1],[4],[0]],
                    [[0],[1,5,9],[7,11],[0],[1,3],[4],[0]]
                ],
                [
                    [[0],[1,5,9],[7,11],[10],[1,3],[4],[0]],
                    [[0],[1,8,6],[0],[2],[1,3],[4],[0]]
                ],
                [
                    [[0],[1,8,6],[0],[10,2],[1],[4],[0]],
                    [[0],[1,5,9],[7,11],[0],[1,3],[4],[0]]
                ]
            ],
            [// district 17
                [
                    [[0],[1,8,6],[0],[10,2],[1],[4],[0]],
                    [[0],[1,5,9],[7,11],[0],[1,3],[4],[0]]
                ],
                [
                    [[0],[1,5,9],[7,11],[10],[1,3],[4],[0]],
                    [[0],[1,8,6],[0],[2],[1],[4],[0]]
                ],
                [
                    [[0],[1,8,6],[0],[10,2],[1,3],[4],[0]],
                    [[0],[1,5,9],[7,11],[0],[1,3],[4],[0]]
                ],
                [
                    [[0],[1,5,9],[7,11],[10],[1,3],[4],[0]],
                    [[0],[1,8,6],[0],[2],[1],[4],[0]]
                ]
            ],
            [// district 18
                [
                    [[0],[5,9],[1,7,11],[0],[3],[1,4],[0]],
                    [[0],[8,6],[1],[10,2],[0],[1,4],[0]]
                ],
                [
                    [[0],[8,6],[1],[2],[0],[1,4],[0]],
                    [[0],[5,9],[1,7,11],[10],[3],[1,4],[0]]
                ],
                [
                    [[0],[5,9],[1,7,11],[0],[3],[1,4],[0]],
                    [[0],[8,6],[1],[10,2],[3],[1,4],[0]]
                ],
                [
                    [[0],[8,6],[1],[2],[0],[1,4],[0]],
                    [[0],[5,9],[1,7,11],[10],[3],[1,4],[0]]
                ]
            ],
            [// district 19
                [
                    [[0],[8,6],[1],[2],[0],[1,4],[0]],
                    [[0],[5,9],[1,7,11],[10],[3],[1,4],[0]]
                ],
                [
                    [[0],[5,9],[1,7,11],[0],[3],[1,4],[0]],
                    [[0],[8,6],[1],[10,2],[0],[1,4],[0]]
                ],
                [
                    [[0],[8,6],[1],[2],[3],[1,4],[0]],
                    [[0],[5,9],[1,7,11],[10],[3],[1,4],[0]]
                ],
                [
                    [[0],[5,9],[1,7,11],[0],[3],[1,4],[0]],
                    [[0],[8,6],[1],[10,2],[0],[1,4],[0]]
                ]
            ]
            
            
            
            
            
            
            
            
            
            
            
        ]
    
    
    
    
    
    
    
    
    let startIndex:[Int] = [0,1,1,0,0,1,0,0,1,0,1,1]
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
