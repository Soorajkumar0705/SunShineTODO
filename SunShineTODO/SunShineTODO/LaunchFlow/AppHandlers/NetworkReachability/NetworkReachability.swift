//
//  NetworkReachability.swift
//  Kado
//
//  Created by Suraj kahar on 24/02/25.
//

import Foundation
import Network

class NetworkReachability : LaunchFlow, NetworkReachabilityHandler {
    
    static let shared = NetworkReachability()
    
    private let monitor: NWPathMonitor
    private let queue: DispatchQueue
    
    private(set) var isConnected: Bool
    private(set) var connectionType: NetworkReachabilityConnectionType
    

    enum ConnectionType {
        case wifi
        case cellular
        case ethernet
        case other
        case unknown
    }
    
    private init(){
        self.monitor = NWPathMonitor()
        self.queue = DispatchQueue.global(qos: .background)
        self.isConnected = false
        self.connectionType = .unknown
    }
    
    func start() {
        startMonitoring()
        Logger.logMessage("\(className) is started successfully.")
    }
    
    private func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self = self else { return }
            
            let newStatus = path.status == .satisfied
            let newConnectionType = self.getConnectionType(from: path)
            
            guard self.isConnected != newStatus ||
                    self.connectionType != newConnectionType
            else {
                return
            }
            
            self.isConnected = newStatus
            self.connectionType = newConnectionType
            
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                
                NotificationCenter.default.post(name: .NetworkReachabilityStore.networkReachabilityDidChanged,
                                                object: [
                                                    "isConnected" : isConnected,
                                                    "connectionType" : connectionType
                                                ])
                print("Network status changed: \(isConnected ? "Connected" : "Disconnected")")
                print("Connection Type: \(connectionType)")
            }
        }
        monitor.start(queue: queue)
    }
    
    private func getConnectionType(from path: NWPath) -> NetworkReachabilityConnectionType {
        if path.usesInterfaceType(.wifi) {
            return .wifi
        } else if path.usesInterfaceType(.cellular) {
            return .cellular
        } else if path.usesInterfaceType(.wiredEthernet) {
            return .ethernet
        } else if path.usesInterfaceType(.other) {
            return .other
        }
        return .unknown
    }
    
    func stopMonitoring() {
        monitor.cancel()
    }
    
    func isNetworkAvailable() -> Bool {
        return isConnected
    }
    
    func getCurrentConnectionType() -> NetworkReachabilityConnectionType {
        return connectionType
    }
}

fileprivate var metaName = String(describing: NetworkReachability.self)

extension Notification.Name {
    
    struct NetworkReachabilityStore {
        
        static let networkReachabilityDidChanged = Notification.Name("\(metaName)+DidChanged")
    }
    
}

