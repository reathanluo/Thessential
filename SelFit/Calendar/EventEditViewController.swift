//
//  EventEditViewController.swift
//  SelFit
//
//  Created by Ng Jun Heng on 29/1/22.
//

import UIKit

class EventEditViewController: UIViewController
{
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        datePicker.date = selectedDate
    }
    
    @IBAction func saveAction(_ sender: Any)
    {
        let newEvent = Event()
        newEvent.id = eventsList.count
        newEvent.name = nameTF.text
        newEvent.date = datePicker.date
        eventsList.append(newEvent)
        navigationController?.popViewController(animated: true)
    }
}
