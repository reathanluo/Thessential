//
//  ProfileViewController.swift
//  SelFit
//
//  Created by Reathan Luo on 30/1/22.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func logOutBtn(_ sender: Any) {
        let auth = Auth.auth()
        
        do{
            try auth.signOut()
            transToSignIn()
        }catch let signoutError as NSError {
            print("Could not log out. \(signoutError.userInfo)")
            
        }
    }
    
    func transToSignIn(){
        let storyboard = UIStoryboard(name: "SignInSignUp", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "RegisterLoginViewController")
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
}
