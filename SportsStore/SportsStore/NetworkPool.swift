//
//  NetworkPool.swift
//  SportsStore
//
//  Created by jumpei on 2017/03/19.
//  Copyright © 2017年 Apress. All rights reserved.
//

import Foundation

final class NetworkPool {
    private let connectionCount = 3
    private var connections = [NetworkConnection]()
    private var semaphore = DispatchSemaphore(value: 0)
    private var serialQueue = DispatchQueue(label: "network-queue")

    private init() {
        for _ in 0..<connectionCount {
            connections.append(NetworkConnection())
        }
        semaphore = DispatchSemaphore(value: connectionCount)
    }

    private func doGetConnection() -> NetworkConnection {
        semaphore.wait()
        var result: NetworkConnection? = nil
        serialQueue.sync {
            result = self.connections.remove(at: 0)
        }
        return result!
    }

    private func doReturnConnection(conn: NetworkConnection) {
        serialQueue.sync {
            self.connections.append(conn)
            semaphore.signal()
        }
    }

    class func getConnection() -> NetworkConnection {
        return sharedInstance.doGetConnection()
    }

    class func returnConnection(conn: NetworkConnection) {
        sharedInstance.doReturnConnection(conn: conn)
    }

    private class var sharedInstance: NetworkPool {
        get {
            struct SingletonWrapper {
                static let singleton = NetworkPool()
            }
            return SingletonWrapper.singleton
        }
    }
}
