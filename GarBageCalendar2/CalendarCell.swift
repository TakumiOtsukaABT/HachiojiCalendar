//
//  CalendarCell.swift
//  GarBageCalendar2
//
//  Created by Takumi Otsuka on 2021/05/15.
//

import UIKit

class CalendarCell : UICollectionViewCell {
    @IBOutlet weak var dayOfMonth:UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var cellView: UIView!
    var garbage: [Int] = []
}
