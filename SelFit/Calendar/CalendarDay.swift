//
//  CalendarDay.swift
//  SelFit
//
//  Created by Reathan Luo on 2/2/22.
//

import Foundation

class CalendarDay
{
    var day: String!
    var month: Month!
    
    enum Month
    {
        case previous
        case current
        case next
    }
}
