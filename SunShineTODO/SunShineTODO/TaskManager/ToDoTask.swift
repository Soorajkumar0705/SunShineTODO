//
//  ToDoTask.swift
//  SunShineTODO
//
//  Created by sooraj kahar on 26/04/25.
//


struct ToDoTask: CodableResponseModel {
    
    var id: Int
    var userId: Int
    var title, description : String
    var priority : TaskPriority
    var isCompleted: Int? = 0
    var isFavorite: Int = 0
    var updatedAt, createdAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case priority, title, description
        
        case isCompleted = "isCompleted"
        case isFavorite = "isFavorite"
        
        case updatedAt = "updated_at"
        case createdAt = "created_at"
    }
}
