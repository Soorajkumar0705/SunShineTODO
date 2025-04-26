//
//  CreateToDoRequestBuilder.swift
//  SunShineTODO
//
//  Created by Suraj kahar on 20/04/25.
//

import Foundation

class CreateToDoRequestBuilder {
    
    var title : String?
    var dueDate : Date?
    var taskDetails: String?
    var priority: TaskPriority = .low
    var createdAt: Date?
    
    
    func setTitle(_ title : String?) -> Self{
        self.title = title
        return self
    }
    
    func setDueDate(_ dueDate : Date?) -> Self{
        self.dueDate = dueDate
        return self
    }
    
    func setTaskDetails(_ taskDetails : String?) -> Self{
        self.taskDetails = taskDetails
        return self
    }
    
    func setTaskPriority(_ priority : TaskPriority) -> Self{
        self.priority = priority
        return self
    }
    
    func build() throws -> CreateToDoRequest{
        
        guard let title, title != "" else {
            throw BuildErrors.invalidTitle
        }
        
        guard let taskDetails, taskDetails != "" else {
            throw BuildErrors.invalidTaskDetails
        }
        
        guard let dueDate else {
            throw BuildErrors.invalidDueDate
        }
        
        return CreateToDoRequest(
            title: title,
            taskDetails: taskDetails,
            dueDate: dueDate,
            priority: priority,
            isFavorite: false
        )
    }
    
    
    enum BuildErrors : String, ErrorProtocol{
        
        case invalidTitle
        case invalidTaskDetails
        case invalidDueDate
        
        var errorDescription: String? {
            return switch self {
            case .invalidTitle: "Invalid Title"
            case .invalidTaskDetails: "Invalid Task Details"
            case .invalidDueDate: "Due date not selected."
            }
        }
        
        var recoverySuggestion: String? {
            return switch self {
            case .invalidTitle: "Please enter valid Title."
            case .invalidTaskDetails: "Please enter valid Task Details."
            case .invalidDueDate: "Please select a due date."
                
            }
        }
    }
    
}
