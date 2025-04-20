//
//  APISuccessResponseModel.swift
//  Kado
//
//  Created by Suraj kahar on 09/01/25.
//

import Foundation

extension Array: CodableResponseModel where Element: CodableResponseModel {}

extension Array: ParsableResponseModel where Element: ParsableResponseModel {
    static func parseData(from data: Any) -> Array<Element>? {
        guard let data = data as? StringAnyDictArray else {return nil}
        return data.compactMap({ Element.parseData(from: $0 ) })
    }
}

struct EmptyData : CodableResponseModel { }

extension Int : CodableResponseModel { }

struct APISuccessCodableResponseModel<T: CodableResponseModel> : CodableResponseModel{
    
    var isError : Bool?
    var message : String?
    var data: T?
    
    enum CodingKeys : String, CodingKey{
        case isError = "is_error"
        case message
        case data
    }
}


struct APISuccessParsableResponseModel<T: ParsableResponseModel> : ParsableResponseModel{
    
    var isError : Bool?
    var message : String?
    var data: T?
    
    enum CodingKeys : String, CodingKey{
        case isError = "is_error"
        case message
        case data
    }
    
    static func parseData(from dict: Any) -> Self? {
        guard let json = dict as? StringAnyDict else { return nil }
        
        return Self(
            isError: json[CodingKeys.isError.rawValue] as? Bool ?? true,
            message: json[CodingKeys.message.rawValue] as? String ?? "-111",
            data: T.parseData(
                from: json[CodingKeys.data.rawValue] as Any
            )
        )
    }
    
}
