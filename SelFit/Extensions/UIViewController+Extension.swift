//
//  File.swift
//  SelFit
//
//  Created by Reathan Luo on 22/1/22.
//

import UIKit
extension UIViewController{
    static var identifier:String{
        return String(describing: self)
    }
    
    static func instantiate() ->Self{
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier) as! Self
    }
//    static func logOut() ->Self{
//        let storyboard = UIStoryboard(name: "SignInSignUp", bundle: nil)
//        return storyboard.instantiateViewController(withIdentifier: identifier) as! Self
//    }
}
