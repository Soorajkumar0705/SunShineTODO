//
//  JSONContainer.swift
//  Kado
//
//  Created by Suraj kahar on 27/02/25.
//

import Foundation

// Prior to iOS 13 JSONEncoder and JSONDecoder require the top-level type to be an Array, Dictionary, or Struct.
// Use this container to encode and decode any type by wrapping it in a Struct.
// https://stackoverflow.com/questions/50257242/jsonencoder-wont-allow-type-encoded-to-primitive-value
struct JSONContainer<T: Codable>: Codable {
    let value: T
}
