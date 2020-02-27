//
//  Project+CoreDataProperties.swift
//  ClearDo
//
//  Created by Oksana Fedorchuk on 27.02.2020.
//  Copyright © 2020 Oksana Fedorchuk. All rights reserved.
//
//

import Foundation
import CoreData


extension Project {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<Project> {
        return NSFetchRequest<Project>(entityName: "Project")
    }

    @NSManaged public var projectName: String?
    @NSManaged public var isDone: Bool
    @NSManaged public var createdAt: Date
    @NSManaged public var updatedAt: Date
    
}
