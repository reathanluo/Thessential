//
//  RegisterLoginViewController.swift
//  SelFit
//
//  Created by Reathan Luo on 30/1/22.
//

import UIKit

class RegisterLoginViewController: UIViewController {
    @IBOutlet weak var signUpBtn: UIButton!
    
    @IBOutlet weak var SignInBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()


        setUpElements()
    }

    func setUpElements(){

        // Style for the elements

        Utilities.styleFilledButton(signUpBtn)
        Utilities.styleHollowButton(SignInBtn)
        
    }

}
