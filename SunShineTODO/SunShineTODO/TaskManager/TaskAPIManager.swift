//
//  TaskAPIManager.swift
//  SunShineTODO
//
//  Created by sooraj kahar on 26/04/25.
//

import Foundation

protocol TaskAPIManagerDelegate: AnyObject {
    
    func didRecieveTodoListDataResponse()
    
    func didRecieveCreateToDoResponse()
    func didRecievUpdateTodoRespobse()
    
    func didRecieveDeleteToDoResponse()

}

class TaskAPIManager{
    
    var apiService: APIServiceProtocol!
    
    init(apiService: APIServiceProtocol) {
        self.apiService = apiService
    }
    
    var toDoList: [ToDoTask] = [] {
        didSet{
            delegate?.didRecieveTodoListDataResponse()
        }
    }
    
    var delegate: TaskAPIManagerDelegate?
    
    
    func getToDoList(){
        Task{
            do{
                let apiResponse = try await apiService.getData(
                    endpoint: ToDoEndPointEnum.getToDoList,
                    useCustomParser: false,
                    successResponseModelType: APISuccessCodableResponseModel<PaginatedCodableResponseModel<ToDoTask>>.self
                )
                
                if (apiResponse.isError ?? true) == false,
                let data = apiResponse.data?.data
                {
                    toDoList = data
                    
                }else{
                    DispatchQueue.main.async{
                        Toast.show(apiResponse.message ?? "Something went wrong. Please try again later.")
                    }
                }
                
                
            }catch let error{
                let error = DefaultAPICallErrorHandling.retrieveErrorMessage(error)
                Toast.show(error)
            }
        }
    }
    
    func createToDoTask(task: CreateToDoRequestBuilder){
        Task{
            do{
                
                let req = try task.build()
                
                let apiResponse = try await apiService.getData(
                    endpoint: ToDoEndPointEnum.storeToDo(paramBody: req),
                    useCustomParser: false,
                    successResponseModelType: APISuccessCodableResponseModel<CreateToDoResponseModel>.self
                )
                
                if (apiResponse.isError ?? true) == false{
                    delegate?.didRecieveCreateToDoResponse()
                    
                }else{
                    DispatchQueue.main.async{
                        Toast.show(apiResponse.message ?? "Something went wrong. Please try again later.")
                    }
                }
                
                
            }catch let error{
                let error = DefaultAPICallErrorHandling.retrieveErrorMessage(error)
                Toast.show(error)
            }
        }
    }
    
    func favoriteToDoTask(taskId: Int, isFavorite: Bool){
        Task{
            do{
                
                let paramBody = UpdateToDoRequestBody(isFavorite: isFavorite)
                
                let apiResponse = try await apiService.getData(
                    endpoint: ToDoEndPointEnum.updateToDo(todoId : taskId, paramBody : paramBody),
                    useCustomParser: false,
                    successResponseModelType: APISuccessCodableResponseModel<CreateToDoResponseModel>.self
                )
                
                if (apiResponse.isError ?? true) == false{
                    
                    if let index = toDoList.firstIndex(where: { $0.id == taskId }) {
                        toDoList[index].isFavorite = isFavorite ? 1 : 0
                    }
                    
                }else{
                    DispatchQueue.main.async{
                        Toast.show(apiResponse.message ?? "Something went wrong. Please try again later.")
                    }
                }
                
                
            }catch let error{
                let error = DefaultAPICallErrorHandling.retrieveErrorMessage(error)
                Toast.show(error)
            }
        }
    }
    
    func markCompleteToDoTask(taskId: Int, isCompleted: Bool){
        Task{
            do{
                
                let paramBody = UpdateToDoRequestBody(isCompleted: isCompleted)
                
                let apiResponse = try await apiService.getData(
                    endpoint: ToDoEndPointEnum.updateToDo(todoId : taskId, paramBody : paramBody),
                    useCustomParser: false,
                    successResponseModelType: APISuccessCodableResponseModel<CreateToDoResponseModel>.self
                )
                
                if (apiResponse.isError ?? true) == false{
                    
                    if let index = toDoList.firstIndex(where: { $0.id == taskId }) {
                        toDoList[index].isCompleted = isCompleted ? 1 : 0
                    }
                    
                }else{
                    DispatchQueue.main.async{
                        Toast.show(apiResponse.message ?? "Something went wrong. Please try again later.")
                    }
                }
                
                
            }catch let error{
                let error = DefaultAPICallErrorHandling.retrieveErrorMessage(error)
                Toast.show(error)
            }
        }
    }
    
    func deleteToDoTask(taskId: Int){
        Task{
            do{
                
                let apiResponse = try await apiService.getData(
                    endpoint: ToDoEndPointEnum.deleteToDo(todoId : taskId),
                    useCustomParser: false,
                    successResponseModelType: CommonAPIRes.self
                )
                
                if (apiResponse.isError) == false{
                    
                    toDoList.removeAll(where: { $0.id == taskId })
                    
                }else{
                    Toast.show(apiResponse.message ?? "Something went wrong. Please try again later.")
                }
                
                
            }catch let error{
                let error = DefaultAPICallErrorHandling.retrieveErrorMessage(error)
                Toast.show(error)
            }
        }
    }
    
    
    struct UpdateToDoRequestBody : JsonRequestBodyType{
        
        var isFavorite : Bool? = nil
        var isCompleted : Bool? = nil
        
        init(isFavorite: Bool? = nil, isCompleted: Bool? = nil) {
            self.isFavorite = isFavorite
            self.isCompleted = isCompleted
        }
        
        func toJson() -> StringAnyDict {
            var json = StringAnyDict()
            
            if let isFavorite = isFavorite{
                json["isFavorite"] = isFavorite ? 1 : 0
            }
            
            if let isCompleted = isCompleted{
                json["isCompleted"] = isCompleted ? 1 : 0
            }
            return json
        }
    }
    
}

