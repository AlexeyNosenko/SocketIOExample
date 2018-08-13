//
//  ChatUpdaterProtocol.swift
//  SocketsChat
//
//  Created by Алексей on 01.08.2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import UIKit

protocol ChatUpdaterProtocol: class {
    func updateMessages(messages: [Message]?)
    func updateUsers(users: [User]?)
    func add(nickname: String, message: String, date: Date)
    func add(nickname: String, image: UIImage, date: Date)
    func showHowEnterMessage(message: String, needShow: Bool)
    func show(infoMessage message: String)
    func doneConnect(connected: Bool, reason: String?)
}
