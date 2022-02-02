//
//  Colors.swift
//  SelFit
//
//  Created by Reathan Luo on 2/2/22.
//

import UIKit

enum CategoryColor {
    case generalColor
    case healthColor
    case entertainColor
    case sportsColor
}
extension CategoryColor: RawRepresentable {
    typealias RawValue = UIColor
    
    init?(rawValue: RawValue) {
        switch rawValue {
        case #colorLiteral(red: 0.1176470588, green: 0.6980392157, blue: 0.6509803922, alpha: 1): self = .generalColor
        case #colorLiteral(red: 1, green: 0.9215686275, blue: 0.6, alpha: 1): self = .healthColor
        case #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1): self = .entertainColor
        case #colorLiteral(red: 0.4980392157, green: 0.4705882353, blue: 0.8235294118, alpha: 1): self = .sportsColor
            
        default: return nil
        }
    }
    
    var rawValue: RawValue {
        switch self {
        case .generalColor: return #colorLiteral(red: 0.1176470588, green: 0.6980392157, blue: 0.6509803922, alpha: 1)
        case .healthColor: return #colorLiteral(red: 1, green: 0.9215686275, blue: 0.6, alpha: 1)
        case .entertainColor: return #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        case .sportsColor: return #colorLiteral(red: 0.4980392157, green: 0.4705882353, blue: 0.8235294118, alpha: 1)
            
        }
    }
}
