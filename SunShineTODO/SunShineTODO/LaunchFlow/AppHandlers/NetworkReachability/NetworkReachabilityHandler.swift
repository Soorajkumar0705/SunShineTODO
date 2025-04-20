//
//  NetworkReachabilityHandler.swift
//  Kado
//
//  Created by Suraj kahar on 27/02/25.
//

import Foundation

enum NetworkReachabilityConnectionType {
    case wifi
    case cellular
    case ethernet
    case other
    case unknown
}

protocol NetworkReachabilityHandler {
    var isConnected: Bool { get }
    var connectionType: NetworkReachabilityConnectionType { get }
    
    func start()
    func stopMonitoring()
    func isNetworkAvailable() -> Bool
    func getCurrentConnectionType() -> NetworkReachabilityConnectionType
}
