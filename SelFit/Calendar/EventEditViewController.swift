//
//  EventEditViewController.swift
//  SelFit
//
//  Created by Ng Jun Heng on 29/1/22.
//

import UIKit

class EventEditViewController: UIViewController
{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let taskDAL:TaskDAL = TaskDAL()
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        datePicker.date = appDelegate.selectedDate
    }
    
    @IBAction func saveAction(_ sender: Any)
    {
        let id = randomString(length: 5)
//        let newEvent = Event()
//        newEvent.id = eventsList.count
//        newEvent.name = nameTF.text
//        newEvent.date = datePicker.date
//        eventsList.append(newEvent
        
        if(nameTF.text != "")
        {
            self.taskDAL.AddEvents(newEvent: CoreDataEvents(id:id ,name: nameTF?.text as! String, date: datePicker.date))
            
            let alert = UIAlertController(title: "Success",message: "Task Created", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: { action in
                               //perform any action you want on click of OK
                                self.navigationController?.popViewController(animated: true)
                                       }))
                           self.present(alert, animated: true, completion: nil)
        }
        else
        {
            var alert = UIAlertController(title: "Error Adding!", message: "Please enter a text", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
        }
        navigationController?.popViewController(animated: true)
        
        
    }
    
    func randomString(length: Int) -> String {
          let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
          return String((0..<length).map{ _ in letters.randomElement()! })
        }
}
