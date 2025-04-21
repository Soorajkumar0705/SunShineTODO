//
//  TaskDataModel.swift
//  SunShineTODO
//
//  Created by Suraj kahar on 20/04/25.
//

import Foundation


struct TaskDataModel : Codable, Equatable{
 
    var title : String
    var taskDetails: String?
    var dueDate : Date
    var priority: TaskPriority
    var isFavorite: Bool
    var isCompleted: Bool
    var createdAt: Date
    
    static func == (lhs: TaskDataModel, rhs: TaskDataModel) -> Bool {
        return (
            lhs.title == rhs.title &&
            lhs.dueDate == rhs.dueDate &&
            lhs.priority == rhs.priority &&
            lhs.isFavorite == rhs.isFavorite &&
            lhs.isCompleted == rhs.isCompleted
        )
    }
}
