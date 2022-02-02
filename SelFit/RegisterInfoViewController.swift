//
//  RegisterInfoViewController.swift
//  SelFit
//
//  Created by Reathan Luo on 30/1/22.
//

import UIKit
import Firebase
import FirebaseStorage

class RegisterInfoViewController: UIViewController {

    @IBOutlet weak var submitBn: UIButton!
    @IBOutlet weak var errorLbl: UILabel!
    @IBOutlet weak var ageTF: UITextField!
    @IBOutlet weak var heightTF: UITextField!
    @IBOutlet weak var weightTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()


    }
    func setUpElements(){
        errorLbl.alpha = 0
        // Style for the elements
        Utilities.styleTextField(ageTF)
        Utilities.styleTextField(heightTF)
        Utilities.styleTextField(weightTF)
        Utilities.styleFilledButton(submitBn)
        
    }
    
    
    func validateField() -> String?{
        if (ageTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            heightTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            weightTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "")
        {
            return "Please fill in the fields"
        }
        return nil
    }
    func showError(_ message:String){
        errorLbl.text = message
        errorLbl.alpha = 1
    }
    
    @IBAction func SubmitBtn(_ sender: Any) {
        let weight = weightTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let height = heightTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let age = ageTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)

        
        let error = validateField()
        if error != nil{
            showError(error!)
        }
        let db = Firestore.firestore()
        db.collection("users").document(Auth.auth().currentUser!.uid).setData(["weight":weight,"height":height,"age":age],merge:true)
        self.transitionToMain()
        }
    
    
        func transitionToMain(){
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "HomeNC") as! UITabBarController
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }
    
}
