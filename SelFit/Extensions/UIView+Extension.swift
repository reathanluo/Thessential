//
//  UIView+Extension.swift
//  SelFit
//
//  Created by Reathan Luo on 19/1/22.
//

import UIKit

extension UIView{
   @IBInspectable var cornerRadius: CGFloat{
        get {return cornerRadius }
        set {
            self.layer.cornerRadius = newValue
        }
    }
}
