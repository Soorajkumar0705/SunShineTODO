//
//  UDHelper.swift
//  Kado
//
//  Created by Suraj kahar on 09/09/24.
//

import Foundation

class UDHelper {
    
    static let shared = UDHelper()
    private init() { }
    
    private static let ud = UserDefaults.standard
    
    // SET & GET NORMAL OBJC BASED DATA TYPES IN USER DEFAULT
    
    static func setValue(value : Any, for key : UDStorageKey){
        ud.setValue(value, forKey: key.rawValue)
    }
    
    static func getValue<T>(for key : UDStorageKey, type : T.Type) -> T?{
        ud.value(forKey: key.rawValue) as? T
    }
    
    static func getValue<T>(for key : String, type : T.Type) -> T?{
        ud.value(forKey: key) as? T
    }
    
    // SET & GET CUSTOM STRUCTURE OR CLASSED BASED DATA TYPES IN USER DEFAULT
    
    static func setValue(value : Codable, for key : UDStorageKey){
        
        guard let encodedValue = CodableHelper.encodeData(data: value) else { return }
        
        ud.setValue(encodedValue, forKey: key.rawValue)
    }

    
    static func getValue<T: Codable>(for key : UDStorageKey, type : T.Type) -> T?{
        guard let value = ud.value(forKey: key.rawValue) as? Data else{
            return nil
        }
        
        guard let decodedValue = CodableHelper.decodeData(type: type, data: value) else {
            return nil
        }
        
        return decodedValue
        
    }
    
    static func removeValue(for key : UDStorageKey){
        ud.removeObject(forKey: key.rawValue)
    }
    
    static func removeValue(for key : String){
        ud.removeObject(forKey: key)
    }

    
    static func clearUserDefaultData() {
        for key in UDStorageKey.allCases{
            UserDefaults.standard.removeObject(forKey: key.rawValue)
        }
        
        // ADD ANY SPECIAL CACHING LOGIC TO REMOVE CACHED DATA
        
        /*
        for key in UserDefaults.standard.dictionaryRepresentation().keys {
            
            if key.contains("http") {
                print("Found URL for key = ", key)
                
                UserDefaults.standard.removeObject(forKey: key)
            }
        }   // for key in UserDefaults.standard.dictionaryRepresentation
        
        */
        
    }   // clearUserDefaultData
    
}
