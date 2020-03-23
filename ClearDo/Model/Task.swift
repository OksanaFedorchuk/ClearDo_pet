//
//  Task.swift
//  ClearDo
//
//  Created by Yevgen Sagidulin on 03.02.2020.
//  Copyright © 2020 Oksana Fedorchuk. All rights reserved.


import Foundation
import CoreData

class Task {

    var objectId: NSManagedObjectID?
    var text: String?
    var isDone: Bool
    var createdAt: Date
    var updatedAt: Date

    init(objectId: NSManagedObjectID?, text: String?, isDone: Bool = false, createdAt: Date, updatedAt: Date) {
        self.objectId = objectId
        self.isDone = isDone
        self.text = text
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }

    static func empty() -> Task {
        Task(objectId: nil, text: nil, createdAt: Date(), updatedAt: Date())
    }

}
