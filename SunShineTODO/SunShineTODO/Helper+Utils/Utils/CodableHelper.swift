//
//  CodableHelper.swift
//  Kado
//
//  Created by Suraj kahar on 01/01/25.
//

import Foundation

struct CodableHelper {
    
    static func encodeData<T:Codable>(data : T) -> Data?{
        do{
            return try JSONEncoder().encode(data)
        }catch let error{
            print("Error found while encoding ",error)
        }
        return nil
    }
    
    static func decodeData<T: Codable>(type : T.Type, data: Data) -> T?{
        do{
            return try JSONDecoder().decode(T.self, from: data)
        }catch let error{
            print("Error found while encoding ",error)
        }
        return nil
    }
    
    
}


extension String{
    
    func toJSON() -> StringAnyDict{
        guard let jsonData = self.data(using: .utf8) else{
            return [:]
        }
        return jsonData.toJSON() ?? [:]
    }   // func toJSON(){
    
    func toJSONArray() -> StringAnyDictArray{
        guard let jsonData = self.data(using: .utf8) else{
            return []
        }
        return jsonData.toJSONArray()
    }   // func toJSON(){
    
}   // extension String{

extension Data{
    
    func toJSON() -> StringAnyDict?{
        
        do {
            if let jsonDict = try JSONSerialization.jsonObject(with: self, options: []) as? StringAnyDict {
//                print(jsonDict)
                return jsonDict
            }
        } catch let error {
            print("Error deserializing JSON: \(error)")
        }
        return nil
    }
    
    func toJSONArray() -> StringAnyDictArray{
        
        do {
            if let jsonDict = try JSONSerialization.jsonObject(with: self, options: []) as? StringAnyDictArray {
//                print(jsonDict)
                return jsonDict
            }
        } catch {
            print("Error deserializing JSON: \(error)")
        }
        return []
    }
    
}
