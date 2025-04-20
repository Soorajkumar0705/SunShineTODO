//
//  PaginatedModel.swift
//  Kado
//
//  Created by Suraj kahar on 19/03/25.
//


struct PaginatedCodableResponseModel<T: CodableResponseModel> : CodableResponseModel{
    
    var currentPage : Int?
    var lastPage : Int?
    var perPage : Int?
    var totalItems : Int?
    var data : [T]?
    
    enum CodingKeys : String, CodingKey{
        case currentPage = "current_page"
        case lastPage = "last_page"
        case data
        case perPage = "per_page"
        case totalItems = "total"
    }
    
}


struct PaginatedParsableResponseModel<T: ParsableResponseModel> : ParsableResponseModel{
    
    var currentPage : Int?
    var lastPage : Int?
    var perPage : Int?
    var totalItems : Int?
    var data : [T]?
    
    enum CodingKeys : String, CodingKey{
        case currentPage = "current_page"
        case lastPage = "last_page"
        case data
        case perPage = "per_page"
        case totalItems = "total"
    }
    
    static func parseData(from dict: Any) -> Self? {
        guard let json = dict as? StringAnyDict else { return nil }
        
        let data = (json[CodingKeys.data.rawValue] as? [[String:Any]] ?? [])
            .compactMap({ T.parseData(
                from: $0 as Any
            ) })
        
        return Self(
            
            currentPage: json[CodingKeys.currentPage.rawValue] as? Int ?? 0,
            lastPage: json[CodingKeys.lastPage.rawValue] as? Int ?? 0,
            perPage: json[CodingKeys.perPage.rawValue] as? Int ?? 0,
            data: data
        )
    }
    
}
