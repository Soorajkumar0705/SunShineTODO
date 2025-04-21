//
//  TaskBuilder.swift
//  SunShineTODO
//
//  Created by Suraj kahar on 20/04/25.
//

import Foundation


class TaskBuilder {
    
    var title : String?
    var dueDate : Date?
    var taskDetails: String?
    var priority: TaskPriority = .low
    var createdAt: Date?
    
    
    func setTitle(_ title : String?) -> TaskBuilder{
        self.title = title
        return self
    }
    
    func setDueDate(_ dueDate : Date?) -> TaskBuilder{
        self.dueDate = dueDate
        return self
    }
    
    func setTaskDetails(_ taskDetails : String?) -> TaskBuilder{
        self.taskDetails = taskDetails
        return self
    }
    
    func setTaskPriority(_ priority : TaskPriority) -> TaskBuilder{
        self.priority = priority
        return self
    }
    
    func build() throws -> TaskDataModel{
        
        guard let title else {
            throw BuildErrors.invalidTitle
        }
        
        guard let dueDate else {
            throw BuildErrors.invalidDueDate
        }
        
        return TaskDataModel(
            title: title,
            taskDetails: taskDetails,
            dueDate: dueDate,
            priority: priority,
            isFavorite: false,
            isCompleted: false,
            createdAt: Date()
        )
    }
    
    
    enum BuildErrors : String, ErrorProtocol{
        
        case invalidTitle
        case invalidDueDate
        
        var errorDescription: String? {
            return switch self {
            case .invalidTitle: "Invalid Title"
            case .invalidDueDate: "Due date not selected."
            }
        }
        
        var recoverySuggestion: String? {
            return switch self {
            case .invalidTitle: "Please enter valid Title."
            case .invalidDueDate: "Please select a due date."
                
            }
        }
    }
    
}
