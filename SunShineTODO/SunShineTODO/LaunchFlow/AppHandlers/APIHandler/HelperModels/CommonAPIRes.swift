//
//  CommonAPIRes.swift
//  Kado
//
//  Created by Suraj kahar on 07/11/24.
//

struct CommonAPIRes : ParsableResponseModel{
    
    var isError: Bool?
    var message: String?
    var pageCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case isError = "is_error"
        case message
        case pageCount = "page_count"
    }
    
    static func parseData(from data : Any) -> Self? {
        guard let json = data as? StringAnyDict else { return nil}
        
        return Self(
            isError: json[CodingKeys.isError.rawValue] as? Bool ?? true,
            message: json[CodingKeys.message.rawValue] as? String ?? "-111",
            pageCount: json[CodingKeys.pageCount.rawValue] as? Int ?? -111
        )
    }
    
}
