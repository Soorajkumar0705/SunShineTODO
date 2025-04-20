//
//  Storage.swift
//  Kado
//
//  Created by Suraj kahar on 27/02/25.
//


import Foundation

// Inspired by https://medium.com/better-programming/create-the-perfect-userdefaults-wrapper-using-property-wrapper-42ca76005ac8
@propertyWrapper
struct Storage<T: Codable> {
    
    private let key: String
    private let defaultValue: T
    private let userDefaults = UserDefaults.standard

    init(key: UDStorageKey, defaultValue: T) {
        self.key = key.rawValue
        self.defaultValue = defaultValue
    }
    
    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: T {
        get {
            guard
                let data = userDefaults.object(forKey: key) as? Data,
                let container = try? JSONDecoder().decode(JSONContainer<T>.self, from: data)
                else {
                    return defaultValue
            }

            return container.value
        }
        set {
            let data = try? JSONEncoder().encode(JSONContainer(value: newValue))
            userDefaults.set(data, forKey: key)
        }
    }
    
}
