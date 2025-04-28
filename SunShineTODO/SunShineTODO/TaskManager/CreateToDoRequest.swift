//
//  CreateToDoRequest.swift
//  SunShineTODO
//
//  Created by sooraj kahar on 26/04/25.
//

import Foundation

struct CreateToDoRequest : JsonRequestBodyType{
    
    var title : String
    var taskDetails: String
    var dueDate : Date
    var priority: TaskPriority
    var isFavorite: Bool
    
    
    func toJson() -> StringAnyDict {
        var json = StringAnyDict()
        
        json["title"] = title
        json["description"] = taskDetails
        json["due_date"] = dueDate.formatted()
        json["priority"] = priority.rawValue
        json["isFavorite"] = isFavorite
        
        return json
    }
    
}
