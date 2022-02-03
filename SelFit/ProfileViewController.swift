//
//  ProfileViewController.swift
//  SelFit
//
//  Created by Reathan Luo on 30/1/22.
//

import UIKit
import Firebase
import FirebaseStorage

class ProfileViewController: UIViewController {
    let db = Firestore.firestore()

    @IBOutlet weak var bioLblData: UILabel!
    @IBOutlet weak var bioLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        self.emailLbl.text = Auth.auth().currentUser!.email
        self.bioLbl.alpha = 0
        self.bioLblData.alpha = 0
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated) // call super
            
            getName { (name) in
                if let name = name {
                    self.nameLbl.text = name
                    print("success")
                }
            }
        
            getBio { (bio) in
                if let bio = bio {
                    self.bioLblData.text = bio
                    print("success")
                    self.bioLbl.alpha = 1
                    self.bioLblData.alpha = 1

                }
            }
        }
    
    func getName(completion: @escaping (_ name: String?) -> Void) {
            guard let uid = Auth.auth().currentUser?.uid else { // safely unwrap the uid; avoid force unwrapping with !
                completion(nil) // user is not logged in; return nil
                return
            }
            Firestore.firestore().collection("users").document(uid).getDocument { (docSnapshot, error) in
                if let doc = docSnapshot {
                    if let name = doc.get("firstname") as? String {
                        completion(name) // success; return name
                    } else {
                        print("error getting field")
                        completion(nil) // error getting field; return nil
                    }
                } else {
                    if let error = error {
                        print(error)
                    }
                    completion(nil) // error getting document; return nil
                }
            }
        }
    
    func getBio(completion: @escaping (_ bio: String?) -> Void) {
            guard let uid = Auth.auth().currentUser?.uid else { // safely unwrap the uid; avoid force unwrapping with !
                completion(nil) // user is not logged in; return nil
                return
            }
            Firestore.firestore().collection("users").document(uid).getDocument { (docSnapshot, error) in
                if let doc = docSnapshot {
                    if let name = doc.get("bio") as? String {
                        completion(name) // success; return name
                    } else {
                        print("error getting field")
                        completion(nil) // error getting field; return nil
                    }
                } else {
                    if let error = error {
                        print(error)
                    }
                    completion(nil) // error getting document; return nil
                }
            }
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
