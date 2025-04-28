//
//  SignUpORSignInScreenVM.swift
//  SunShineTODO
//
//  Created by sooraj kahar on 26/04/25.
//

import Foundation
import Combine

class SignUpORSignInScreenVMFactory {
    func make() -> SignUpORSignInScreenVM {
        SignUpORSignInScreenVM(
            apiService: APIServiceFactory().makeAPIService()
        )
    }
}

class SignUpORSignInScreenVM : NSObject, ObservableObject {
    
    let apiService : APIServiceProtocol
    
    init(apiService: APIServiceProtocol) {
        self.apiService = apiService
    }
    
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    
    @Published var isValidEmail: Bool = true
    @Published var isValidPassword: Bool = true
    
    @Published var isChecked = false
    @Published var isPasswordVisible: Bool = false
    
    
    func validateEmail(email: String) {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        isValidEmail = emailTest.evaluate(with: email)
    }
    
    
    func authenticate(authType : AuthType){
        Task{
            do{
                
                let req = try AuthenticationRequestBuilder(authType: authType)
                    .setName(name)
                    .setEmail(email)
                    .setPassword(password)
                    .build()
                
                let endpoint = (authType == .signUp) ?
                AuthenticationEndPointEnum.registerUser(paramBody: req) :
                AuthenticationEndPointEnum.signIn(paramBody: req)
                
                
                let responseType : CodableResponseModel.Type = (authType == .signUp) ?
                APISuccessCodableResponseModel<SignUpResponseModel>.self :
                APISuccessCodableResponseModel<SignInResponseModel>.self
                
                
                let apiResponse = try await apiService.getData(
                    endpoint: endpoint,
                    useCustomParser: false,
                    successResponseModelType: responseType
                )
                
                if authType == .signUp {
                    guard let apiResponse = apiResponse as? APISuccessCodableResponseModel<SignUpResponseModel> else {
                        return
                    }
                    if (apiResponse.isError ?? true) == false {
                        authenticate(authType: .signIn)
                        
                    }else{
                        Toast.show(apiResponse.message ?? somethingWentWrongErrorMessage)
                    }
                    
                }else{
                    guard let apiResponse = apiResponse as? APISuccessCodableResponseModel<SignInResponseModel> else {
                        return
                    }
                    if (apiResponse.isError ?? true) == false {
                        AuthenticationHandler.shared.isSignedIn = true
                        AuthenticationHandler.shared.sessionToken = apiResponse.data?.token ?? "-111"
                        
                        DispatchQueue.main.async {
                            TabBarVCFactory().makeVC().rootVC()
                        }
                        
                    }else{
                        Toast.show(apiResponse.message ?? somethingWentWrongErrorMessage)
                    }
                }
                
                
            }catch let error{
                
                let error = DefaultAPICallErrorHandling.retrieveErrorMessage(error)
                Toast.show(error)
            }
            
        }
    }

}

class AuthenticationRequestBuilder {
    
    var authType : AuthType
    
    init(authType: AuthType) {
        self.authType = authType
    }
    
    private var name : String?
    private var email : String?
    private var password : String?
    
    private var isSignUp : Bool {
        return authType == .signUp
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

