//
//  Chat.swift
//  SocketsChat
//
//  Created by Алексей on 28.07.2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import UIKit

class Chat: SocketChatConversation {
    var name: String
    var users: [User]?
    var client: User
    private(set) var messages: [Message]?
    private var socket: SocketChat?
    weak var delegate: ChatUpdaterProtocol?
    
    init(name: String, client: User, autoConnect: Bool = false) {
        self.client = client
        self.name = name
        load()
        socket = SocketChat(client: client, autoConnect: autoConnect)
        socket?.delegate = self
    }
    
    func connection() {
        socket?.connection()
    }
    
    func disconnection() {
        socket?.disconnection()
    }
    
    func load() {
        loadUsers()
        loadMessages()
    }
    
    func loadUsers() {
        users = []
        delegate?.updateUsers(users: users)
    }
    
    func loadMessages() {
        
    }
    
    func sendMessage(message: Message) {
        if let content = message.content as? TextContent {
            socket?.sendText(nickname: message.from, message: content.text)
        }
        
        if let content = message.content as? ImageContent {
            socket?.sendImage(nickname: message.from, imageContent: content)
        }
    }
    
    func sendText(nickname: String, message: String) {
        socket?.sendText(nickname: nickname, message: message)
    }
    
    func addMessage(message: Message) {
        messages?.append(message)
    }
    
    func enterMessage(isEnterMessage: Bool) {
        socket?.send(isEnterMessage: isEnterMessage)
    }
    
    func userConnected(connected: Bool, reason: String?) {
        delegate?.doneConnect(connected: connected, reason: reason)
    }
}

extension Chat: SocketChatDelegate {
    func didGetImageMessage(nickname: String, image: UIImage, date: Date) {
        delegate?.add(nickname: nickname, image: image, date: date)
    }
    
    func updateUserList(nickname: String?) {
        loadUsers()
    }
    
    func showInfoMessage(message: String) {
        delegate?.show(infoMessage: message)
    }
    
    func didLoginUser(nickname: String) {

    }
    
    func didEnterMessage(message: String, needShow: Bool) {
        delegate?.showHowEnterMessage(message: message, needShow: needShow)
    }
    
    func didSendMessage() {
        
    }
    
    func didGetTextMessage(nickname: String, message: String, date: Date) {
        delegate?.add(nickname: nickname, message: message, date: date)
    }
}
