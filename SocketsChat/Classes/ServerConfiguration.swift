//
//  ServerConfiguration.swift
//  SocketsChat
//
//  Created by Алексей on 01.08.2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import Foundation

enum ServerType {
    case rost
    case home
    case work
}

struct ServerConfiguration {
    private init() {
        
    }
    
    static var typeServer: ServerType = .home
    
    static var urlString: String {
        switch typeServer {
        case .rost:
            return "http://rost.pw"
        case .home:
            return "http://192.168.1.217"
        case .work:
            return "http://172.30.2.84"
        }
    }
    
    static var port: String {
        switch typeServer {
        case .rost:
            return "80"
        case .home:
            return "3000"
        case .work:
            return "3000"
        }
    }
    
    static var fullUrlString: String {
        return urlString + ":\(port)"
    }
}
