//
//  HTTPHeader.swift
//  Kado
//
//  Created by Suraj kahar on 10/02/25.
//


struct HTTPHeader{
    
    var httpFieldName: String
    var value: String

    init(
        httpFieldName: String = "",
        value: String = ""
    ) {
        self.httpFieldName = httpFieldName
        self.value = value
    }
    
}
