//
//  SocketIOManager.swift
//  SocketsChat
//
//  Created by Алексей on 01.08.2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import Foundation
import SocketIO

class SocketIOManager {
    static let shared = SocketIOManager()
    
    var manager: SocketManager?
    
    private init() {
        changeUrl(urlString: ServerConfiguration.fullUrlString)
    }
    
    func changeUrl(urlString: String) {
        if let urlServer = URL(string: urlString) {
            manager?.disconnect()
            manager = SocketManager(socketURL: urlServer, config: [.log(true), .compress])
        }
    }
    
    func disconnect() {
        manager?.disconnect()
    }
    
    func getDefaultSocket() -> SocketIOClient? {
        return manager?.defaultSocket
    }
    
    func getNspSocket(nameSpace: String) -> SocketIOClient? {
        return manager?.socket(forNamespace: nameSpace)
    }
}
