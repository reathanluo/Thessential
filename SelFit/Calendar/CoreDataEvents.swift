//
//  CoreDataEvents.swift
//  SelFit
//
//  Created by Ng Jun Heng on 3/2/22.
//

import Foundation
import UIKit
import CoreData

class CoreDataEvents{
    
    var id: String!
    var name: String!
    var date: Date!
    
    init(id: String, name:String, date:Date){
        self.id = id
        self.name = name
        self.date = date
    }
}
