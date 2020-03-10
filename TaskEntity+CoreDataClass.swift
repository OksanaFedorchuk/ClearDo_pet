//
//  Project+CoreDataClass.swift
//  ClearDo
//
//  Created by Oksana Fedorchuk on 27.02.2020.
//  Copyright © 2020 Oksana Fedorchuk. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Project)
public class TaskEntity: NSManagedObject {

    convenience init(projectName: String?, isDone: Bool, createdAt: Date, updatedAt: Date, entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        let entity = NSEntityDescription.entity(forEntityName: "TaskEntity", in: context)
        self.init(entity: entity!, insertInto: context)
//        self.aContext = context
        self.projectName = projectName
        self.isDone = isDone
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    
    static func createEmptyProject(with context: NSManagedObjectContext) -> TaskEntity {
//        let aContext: NSManagedObjectContext? = nil
        return TaskEntity(projectName: nil, isDone: false, createdAt: Date(), updatedAt: Date(), entity: entity(), insertIntoManagedObjectContext: context)
    }

}
