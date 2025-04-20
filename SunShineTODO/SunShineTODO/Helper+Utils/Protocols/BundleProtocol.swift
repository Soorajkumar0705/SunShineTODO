//
//  BundleProtocol.swift
//  Kado
//
//  Created by Suraj kahar on 27/02/25.
//

import Foundation

protocol BundleProtocol: AnyObject {
    func object(forInfoDictionaryKey key: String) -> Any?
}

extension Bundle: BundleProtocol {}
