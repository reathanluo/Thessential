//
//  LoginViewController.swift
//  SelFit
//
//  Created by Reathan Luo on 30/1/22.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var errorLbl: UILabel!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpElements()

    }
    func setUpElements(){
        errorLbl.alpha = 0
        // Style for the elements
        Utilities.styleTextField(emailTF)
        Utilities.styleTextField(passwordTF)
        Utilities.styleFilledButton(loginBtn)
        
    }
    func transitionToMain(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "HomeNC") as! UITabBarController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
        
    }

    @IBAction func transToSignUp(_ sender: Any) {
        transToSignUp()
    }
    
    
    @IBAction func loginTapped(_ sender: Any) {
        let email = emailTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        Auth.auth().signIn(withEmail: email, password: password, completion: {(result, error) in
            if error != nil{
                self.errorLbl.text = error!.localizedDescription
                self.errorLbl.alpha = 1
            }
            else{
                self.transitionToMain()
            }
        })
    }
    
    func transToSignUp(){
        let storyboard = UIStoryboard(name: "SignInSignUp", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SignUp")
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    

}
