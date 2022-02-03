//
//  EditProfileViewController.swift
//  SelFit
//
//  Created by Reathan Luo on 3/2/22.
//

import UIKit
import Firebase
import FirebaseStorage


class EditProfileViewController: UIViewController {

    let db = Firestore.firestore()
    @IBOutlet weak var pwTF: UITextField!
    @IBOutlet weak var bioTF: UITextField!
    @IBOutlet weak var nameTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    @IBAction func saveBtn(_ sender: Any) {
        let username = nameTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let bio = bioTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = pwTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)

        if (username != "") {
            updateNameData(name: username!)
        }

        
        if (bio != "") {
            updateBioData(bio: bio!)
        }
        if (password != "") {
            
            if (Utilities.isPasswordValid(password!) == true){
                self.resetPassword(pw: password!)
                _ = navigationController?.popViewController(animated: true)
            }
            else{
                showAler(sender)
            }
            
        }
        else{
            _ = navigationController?.popViewController(animated: true)

        }
        
        
    }
    
    @IBAction func showAler(_ sender:Any){
        let alertView = UIAlertController(title: "Error", message: "Please input a correct password (8 chars with a special char)", preferredStyle: UIAlertController.Style.alert)
        alertView.addAction(UIAlertAction(title: "Noted", style: UIAlertAction.Style.default, handler: { _ in }))
        self.present(alertView, animated: true, completion: nil)

    }
    
    func resetPassword(pw:String){
        Auth.auth().currentUser?.updatePassword(to: pw) { error in
            if let error = error {
                print(error)
            }
        }
    }
    
    func updateNameData(name:String){
        db.collection("users").document(Auth.auth().currentUser!.uid).setData([ "firstname": name ], merge: true)
    }

    func updateBioData(bio:String){
        db.collection("users").document(Auth.auth().currentUser!.uid).setData([ "bio": bio ], merge: true)
    }
}
