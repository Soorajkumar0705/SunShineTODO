//
//  TaskPriority.swift
//  SunShineTODO
//
//  Created by Suraj kahar on 20/04/25.
//


enum TaskPriority : String, CaseIterable, CodableResponseModel{
    
    case low
    case medium
    case high
    
    var title : String {
        return switch self {
        case .low: "Low"
        case .medium: "Medium"
        case .high: "High"
        }
    }
    
    enum CodingKeys : String, CodingKey {
        case low = "low"
        case medium = "medium"
        case high = "high"
    }
    
}
