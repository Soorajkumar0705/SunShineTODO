//
//  CreateToDoResponseModel.swift
//  SunShineTODO
//
//  Created by sooraj kahar on 26/04/25.
//


struct CreateToDoResponseModel: CodableResponseModel {
    
    var id: Int
    var userId: Int
    var title, description: String
    var priority : TaskPriority
    var updatedAt, createdAt: String

    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case priority, title, description
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case id
    }
    
    func toToDoTaskModel() -> ToDoTask {
        ToDoTask(
            id: id,
            userId: userId,
            title: title,
            description: description,
            priority: priority,
            updatedAt: updatedAt,
            createdAt: createdAt
        )
    }
    
}
