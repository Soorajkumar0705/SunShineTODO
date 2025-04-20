//
//  HandlerProtocols.swift
//  Kado
//
//  Created by Suraj kahar on 02/01/25.
//

import Foundation

//MARK: - Codable & Parsable ResponseModel

protocol CodableResponseModel: Codable { }

protocol ParsableResponseModel: CodableResponseModel {
    static func parseData(from data: Any) -> Self?
}
