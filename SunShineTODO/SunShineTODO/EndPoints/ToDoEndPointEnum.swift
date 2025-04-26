//
//  ToDoEndPointEnum.swift
//  SunShineTODO
//
//  Created by sooraj kahar on 26/04/25.
//

import Foundation

enum ToDoEndPointEnum  {
    
    case storeToDo(paramBody : JsonRequestBodyType)
    case getToDoList
    case updateToDo(todoId : Int, paramBody : JsonRequestBodyType)
    case deleteToDo(todoId : Int)
    
        
}

extension ToDoEndPointEnum: APIEndpointEnumType {
    
    func getEndpoint() -> (any APIEndpointType) {
        
        switch self {
            
        case .storeToDo(paramBody: let paramBody):
            APIEndpoint(
                baseURL: baseURL,
                versionURL: versionURL,
                path: "todo/store",
                method: HTTPMethod.POST,
                headers: [
                    headers_wildCard,
                    headers_applicationJson,
                    getSessionTokenHeader()
                ],
                params: HTTPParamRequestBody(body: paramBody)
            )
            
        case .getToDoList:
            APIEndpoint(
                baseURL: baseURL,
                versionURL: versionURL,
                path: "todo",
                method: HTTPMethod.GET,
                headers: [
                    headers_wildCard,
                    headers_applicationJson,
                    getSessionTokenHeader()
                ],
                params: nil
            )
            
            
        case .updateToDo(todoId : let todoId, paramBody: let paramBody):
            APIEndpoint(
                baseURL: baseURL,
                versionURL: versionURL,
                path: "todo/\(todoId)/update",
                method: HTTPMethod.POST,
                headers: [
                    headers_wildCard,
                    headers_applicationJson,
                    getSessionTokenHeader()
                ],
                params: HTTPParamRequestBody(body: paramBody)
            )
            
        case .deleteToDo(todoId : let todoId):
            APIEndpoint(
                baseURL: baseURL,
                versionURL: versionURL,
                path: "todo/\(todoId)/delete",
                method: HTTPMethod.POST,
                headers: [
                    headers_wildCard,
                    headers_applicationJson,
                    getSessionTokenHeader()
                ],
                params: nil
            )
            
        }
    }
    
}
