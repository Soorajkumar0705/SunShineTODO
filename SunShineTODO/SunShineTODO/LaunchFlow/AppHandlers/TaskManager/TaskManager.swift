//
//  TaskManager.swift
//  SunShineTODO
//
//  Created by sooraj kahar on 21/04/25.
//

import Foundation

class TaskManager {
    
    static let shared = TaskManager()
    
    private init() {
//        self.taskData = getData()
    }
    
    var taskData: [TaskDataModel] = []{
        didSet {
            NotificationCenter.default.post(name: .reloadData, object: nil)
        }
    }
    
    
    func saveTask(taskData: [TaskDataModel]) {
        self.taskData = taskData
        
        UDHelper.setValue(value: taskData, for: UDStorageKey.taskData)
    }
    
    func getTask() -> [TaskDataModel]{
        
        guard let taskData = UDHelper.getValue(for: .taskData, type: [TaskDataModel].self)
        else { return [] }
        
        self.taskData = taskData
        return taskData
    }
    
    func addTask(taskData: TaskDataModel){
        self.taskData.append(taskData)
        saveTask(taskData: self.taskData)
    }
    
    func favTask(taskData: TaskDataModel){
        
        if let index = self.taskData.firstIndex(where: { $0 == taskData }){
            self.taskData[index].isFavorite = true
        }
        
        saveTask(taskData: self.taskData)
    }
    
    
    func unfavTask(taskData: TaskDataModel){
        if let index = self.taskData.firstIndex(where: { $0 == taskData }){
            self.taskData[index].isFavorite = false
        }
        
        saveTask(taskData: self.taskData)
    }
    
    
    func deleteTask(task : TaskDataModel){
        let filteredTask = self.taskData.filter({ $0 != task })
        
        saveTask(taskData: filteredTask)
    }
    
    func deleteAllData() {
        UDHelper.removeValue(for: .taskData)
    }
    
}

extension Notification.Name {
    static let reloadData = Notification.Name("reloadData")
}
