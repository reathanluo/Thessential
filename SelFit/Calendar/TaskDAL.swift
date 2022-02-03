//
//  TaskDAL.swift
//  SelFit
//
//  Created by Ng Jun Heng on 3/2/22.
//

import Foundation
import UIKit
import CoreData

class TaskDAL{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    init(){}
    
    func AddEvents(newEvent: CoreDataEvents){
        let context = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "EventsCoreData", in: context)!
        
        let calendar = NSManagedObject(entity: entity, insertInto: context)
        
        calendar.setValue(newEvent.id, forKey: "id")
        calendar.setValue(newEvent.name, forKey: "name")
        calendar.setValue(newEvent.date, forKey: "date")
        
        
        do{
            try context.save()
        }catch let error as NSError{
            print("Could not save. \(error), \(error.userInfo)")
        }

    }
    
    func retrieveAllEvents() -> [CoreDataEvents]{
        var managedWeeklyEventList : [NSManagedObject] = []
        var weeklyEventList:[CoreDataEvents] = []
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "EventsCoreData")
        do {
            managedWeeklyEventList = try context.fetch(fetchRequest)
            
            for e in managedWeeklyEventList{
                let id = e.value(forKeyPath: "id") as! String
                let name = e.value(forKeyPath: "name") as! String
                let date = e.value(forKeyPath: "date") as! Date
                
                let event:CoreDataEvents = CoreDataEvents(id: id, name: name, date: date)
                weeklyEventList.append(event)
            }
        }catch let error as NSError{
            print("Could not save. \(error), \(error.userInfo)")

        }
        return weeklyEventList
    }
    
    func deleteEvent(event: CoreDataEvents){
        var managedEvent: [NSManagedObject] = []
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "EventsCoreData")
        
        do{
            managedEvent = try context.fetch(fetchRequest)
            for e in managedEvent
            {
                let id = e.value(forKey: "id") as! String
                if(id == event.id)
                {
                    context.delete(e)
                }
            }
            try context.save()
        }catch let error as NSError{
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
        
}
