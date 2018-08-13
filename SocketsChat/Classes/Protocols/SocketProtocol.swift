//
//  SocketProtocol.swift
//  SocketsChat
//
//  Created by Алексей on 01.08.2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import UIKit

protocol SocketProtocol: class {
    func connection()
    func disconnection()
}

protocol SocketChatConversation: SocketProtocol {
    func sendText(nickname: String, message: String)
}

protocol SocketChatDelegate: SocketProtocol {
    func didSendMessage()
    func didGetTextMessage(nickname: String, message: String, date: Date)
    func didGetImageMessage(nickname: String, image: UIImage, date: Date)
    func didEnterMessage(message: String, needShow: Bool)
    func didLoginUser(nickname: String)
    func showInfoMessage(message: String)
    func userConnected(connected: Bool, reason: String?)
    func updateUserList(nickname: String?)
}
