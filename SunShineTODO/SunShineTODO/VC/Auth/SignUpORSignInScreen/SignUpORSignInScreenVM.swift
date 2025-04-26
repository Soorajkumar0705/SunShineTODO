//
//  SignUpORSignInScreenVM.swift
//  SunShineTODO
//
//  Created by sooraj kahar on 26/04/25.
//

import Foundation

class SignUpORSignInScreenVM : NSObject {
    
    let apiService = APIServiceFactory().makeAPIService()
    
    
    var didRecieveError : ((_ errorMessage : String) -> Void)?
    
    var didRecieveSignUpResponse : (() -> Void)?
    var didRecieveSignInResponse : (() -> Void)?
    
    
    func signIn(requestBuilder : AuthenticationRequestBuilder){
        Task{
            do{
                let req = try requestBuilder.build()
                
                let apiResponse = try await apiService.getData(
                    endpoint: AuthenticationEndPointEnum.signIn(paramBody: req),
                    useCustomParser: false,
                    successResponseModelType: APISuccessCodableResponseModel<SignInResponseModel>.self
                )
                
                if (apiResponse.isError ?? true) == false {
                    AuthenticationHandler.shared.isSignedIn = true
                    AuthenticationHandler.shared.sessionToken = apiResponse.data?.token ?? "-111"
                    didRecieveSignInResponse?()
                    
                }else{
                    didRecieveError?("Invalid Credentials")
                }
                
                
            }catch let error{
                
                let error = DefaultAPICallErrorHandling.retrieveErrorMessage(error)
                didRecieveError?(error)
            }
            
        }
    }
    
    func signUp(requestBuilder : AuthenticationRequestBuilder){
        Task{
            do{
                let req = try requestBuilder.build()
                
                let apiResponse = try await apiService.getData(
                    endpoint: AuthenticationEndPointEnum.registerUser(paramBody: req),
                    useCustomParser: false,
                    successResponseModelType: APISuccessCodableResponseModel<SignUpResponseModel>.self
                )
                
                if (apiResponse.isError ?? true) == false {
                    
                    let req = requestBuilder
                    req.isSignUp = false
                    signIn(requestBuilder: req)
                    
                }else{
                    didRecieveError?("Invalid Credentials")
                }
                
                
            }catch let error{
                
                let error = DefaultAPICallErrorHandling.retrieveErrorMessage(error)
                didRecieveError?(error)
            }
            
        }
    }

}

class AuthenticationRequestBuilder {
    
    var isSignUp : Bool = true
    
    var name : String?
    var email : String?
    var password : String?
    
    
    func setIsSignUp(_ isSignUp : Bool) -> Self{
        self.isSignUp = isSignUp
        return self
    }
    
    func setName(_ name : String?) -> Self{
        self.name = name
        return self
    }
    
    func setEmail(_ email : String?) -> Self{
        self.email = email
        return self
    }
    
    func setPassword(_ password : String?) -> Self{
        self.password = password
        return self
    }
    
    
    func build() throws -> AuthenticationRequestBody{
        
        if name == nil && isSignUp{
            throw RequestBuildErrors.missingName
        }
        
        if email == nil {
            throw RequestBuildErrors.missingEmail
        }
        
        if password == nil {
            throw RequestBuildErrors.missingPassword
        }
        
        return AuthenticationRequestBody(
            name: isSignUp ? name! : nil,
            email: email!,
            password: password!
        )
    }
    
    
    enum RequestBuildErrors : ErrorProtocol{
        
        case missingName
        case missingEmail
        case missingPassword
        
        
        var errorDescription: String? {
            switch self {
            case .missingName: "Missing required field Name."
            case .missingEmail: "Missing required field Email."
            case .missingPassword: "Missing required field Password."
            }
        }
        
        var recoverySuggestion: String? {
            switch self {
            case .missingName: "Please enter your name."
            case .missingEmail: "Please enter a valid email address."
            case .missingPassword: "Please enter a valid password."
            }
        }
        
    }
}

struct AuthenticationRequestBody: JsonRequestBodyType {
    
    var name : String?
    var email : String
    var password : String
    
    init(name: String?, email: String, password: String) {
        self.name = name
        self.email = email
        self.password = password
    }
    
    func toJson() -> StringAnyDict {
        
        var json = StringAnyDict()
        
        if let name = name{
            json["name"] = name
        }
        
        json["email"] = email
        json["password"] = password
        
        return json
    }
}


struct SignUpResponseModel: CodableResponseModel {
    var id: Int
    var name, email, updatedAt, createdAt: String

    enum CodingKeys: String, CodingKey {
        case name, email
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case id
    }
}

struct SignInResponseModel: CodableResponseModel {
    
    var id: Int
    var userId: Int
    var token, updatedAt, createdAt: String

    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case token
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case id
    }
}

