//
//  ForSocketsExample.swift
//  SocketsChat
//
//  Created by Алексей on 08.08.2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import Foundation
import SocketIO

    class ManagerBad {
        func addHandlers() {
            let manager = SocketManager(socketURL: URL(string: "http://somesocketioserver.com")!)
            
            manager.defaultSocket.on("myEvent") {data, ack in
                print(data)
            }
        }
    }

    class ManagerGood {
        let manager = SocketManager(socketURL: URL(string: "http://somesocketioserver.com")!)
        
        func addHandlers() {
            manager.defaultSocket.on("myEvent") {data, ack in
                print(data)
            }
        }
    }
