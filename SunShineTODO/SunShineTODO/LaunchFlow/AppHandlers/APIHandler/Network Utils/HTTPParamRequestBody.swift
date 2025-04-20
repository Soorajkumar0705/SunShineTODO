//
//  HTTPParamRequestBody.swift
//  Kado
//
//  Created by Suraj kahar on 13/03/25.
//

import Foundation

/// httpBody can be accepted as Data or Encodable

struct HTTPParamRequestBody {
    
    var body : HTTPParamType
    var cachePolicy: URLRequest.CachePolicy?
    var timeoutInterval: TimeInterval?
    
    init(
        body: HTTPParamType,
        cachePolicy: URLRequest.CachePolicy? = nil,
        timeoutInterval: TimeInterval? = nil
    ){
        self.body = body
        self.cachePolicy = cachePolicy
        self.timeoutInterval = timeoutInterval
    }
    
}
