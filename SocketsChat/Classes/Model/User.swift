//
//  user.swift
//  SocketsChat
//
//  Created by Алексей on 28.07.2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import Foundation

struct User {
    var nickname: String
    var isOnline: Bool = false
    
    var online: String {
        return isOnline ? "Online" : "Offline"
    }
}
