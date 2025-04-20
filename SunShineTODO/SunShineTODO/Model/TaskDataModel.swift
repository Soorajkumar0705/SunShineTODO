//
//  TaskDataModel.swift
//  SunShineTODO
//
//  Created by Suraj kahar on 20/04/25.
//

import Foundation


struct TaskDataModel {
 
    var title : String
    var dueDate : Date
    var taskDetails: String?
    var priority: TaskPriority
    var createdAt: Date
}
