//
//  SignUpViewController.swift
//  SelFit
//
//  Created by Reathan Luo on 30/1/22.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController {

    @IBOutlet weak var errorLbl: UILabel!
    @IBOutlet weak var signupBtn: UIButton!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var surnameTF: UITextField!
    @IBOutlet weak var firstnameTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpElements()
    }
    
    func setUpElements(){
        errorLbl.alpha = 0
        // Style for the elements
        Utilities.styleTextField(firstnameTF)
        Utilities.styleTextField(surnameTF)
        Utilities.styleTextField(emailTF)
        Utilities.styleTextField(passwordTF)
        Utilities.styleFilledButton(signupBtn)
        
    }
    //Check the fields and validate the data is correct
    func validateField() -> String?{
        if (firstnameTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            surnameTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "")
        {
            return "Please fill in the fields"
        }
        
        let cleanedPassword = passwordTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(cleanedPassword) == false{
            return "Please make sure your password is at least 8 characters with special character"
        }
        
        return nil
        
    }
    @IBAction func transToSignIn(_ sender: Any) {
        transToSignIn()
    }
    

    @IBAction func signUpTabbed(_ sender: Any) {
        //validate the fields
        
        let error = validateField()
        if error != nil{
            showError(error!)
        }
        else{
            //Create the user
            let firstName = firstnameTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let surname = surnameTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)

            Auth.auth().createUser(withEmail: email, password: password, completion: {(result,err) in
                if err != nil{
                    self.showError("Error creating a user")
                }
                else{
                    let db = Firestore.firestore()
                    db.collection("users").document(result!.user.uid).setData(["firstname":firstName,"surname":surname,"uid":result!.user.uid])
                    
                }
            })
            
        }
        
    }
    
    func showError(_ message:String){
        errorLbl.text = message
        errorLbl.alpha = 1
    }


    
    func transToSignIn(){
        let storyboard = UIStoryboard(name: "SignInSignUp", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SignIn")
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
}
