//
//  APIFieldValidationErrorResponseModel.swift
//  Kado
//
//  Created by Suraj kahar on 07/01/25.
//


//MARK: - GenericAPIErrorResponseModel


protocol APIFieldValidationErrorCodableType : CodableResponseModel{
    
}

typealias APIFieldValidationErrorParsableType = APIFieldValidationErrorCodableType & ParsableResponseModel
