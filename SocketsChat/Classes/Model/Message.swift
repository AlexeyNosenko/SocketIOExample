//
//  Message.swift
//  SocketsChat
//
//  Created by Алексей on 10.07.2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import UIKit

enum MessageSender {
    case himself
    case someone
}

class Message {
    let dateSend: Date
    var content: Content
    var sender: MessageSender = .someone
    var from: String
    
    init(content: Content, from: String, sender: MessageSender, dateSend: Date) {
        self.content = content
        self.from = from
        self.sender = sender
        self.dateSend = dateSend
    }
    
    convenience init(content: Content, from: String) {
        self.init(content: content, from: from, sender: .someone, dateSend: Date())
    }
    
    convenience init(content: Content, from: String, sender: MessageSender) {
        self.init(content: content, from: from, sender: sender, dateSend: Date())
    }
    
    convenience init(content: Content, from: String, dateSend: Date) {
        self.init(content: content, from: from, sender: .someone, dateSend: dateSend)
    }
}
