//
//  ConnectivityManager.swift
//  TestConnectivity
//
//  Created by Eslam Shaker on 21/01/2024.
//

import Foundation
import Network

final class ConnectivityManager {
    
    static let shared = ConnectivityManager()
    var connectivityObject: ConnectionObject = .init(status: .satisfied, isLowPowerMode: false, isCellularOrHotspot: false)
    
    private init() { }
    
    /// call it at App start point. eg: AppDelegate
    func startMonitor() {
        let monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { [weak self] path in
            self?.handlePath(path)
        }
        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
    }
    
    private func handlePath(_ path: NWPath) {
        print("Internet connection status is: \(path.status).")
        
        connectivityObject.status = path.status
        connectivityObject.isLowPowerMode = path.isConstrained
        connectivityObject.isCellularOrHotspot = path.isExpensive
        
        NotificationCenter.default.post(name: .connectionStatusChanged, object: connectivityObject)
    }
}

struct ConnectionObject {
    var status: NWPath.Status
    var isLowPowerMode: Bool
    var isCellularOrHotspot: Bool
}

extension NSNotification.Name {
    static let connectionStatusChanged = Notification.Name("connectionStatusChanged")
}
