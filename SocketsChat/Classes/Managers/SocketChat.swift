//
//  SocketChat.swift
//  SocketsChat
//
//  Created by Алексей on 13.07.2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import SocketIO

enum ChatEvents: String {
    case textMessage
    case infoMessage
    case imageMessage
    case connectUser
    case exitUser
    case updateUserList
    case userConnectUpdate
    case userEnterMessage
    case userTypingUpdate
}

class SocketChat: SocketChatConversation {
    var delegate: SocketChatDelegate?
    
    static let nsp = "/chat"
    
    var client: User
    
    private var socket: SocketIOClient?
    
    init(client: User, autoConnect: Bool = false) {
        self.client = client
        SocketIOManager.shared.manager?.nsps.removeValue(forKey: SocketChat.nsp)
        socket = SocketIOManager.shared.getNspSocket(nameSpace: SocketChat.nsp)
        addListeners()
        
        if autoConnect {
            connection()
        }
    }
    
    func connection() {
        socket?.connect()
    }
    
    func disconnection() {
        socket?.disconnect()
    }
    
    private func addListeners() {
        
        socket?.on(clientEvent: .connect, callback: { [weak self] (data, ack) in
            self?.login()
        })
        
        socket?.on(clientEvent: .disconnect, callback: { [weak self] (data, ack) in
            self?.logout()
            self?.client.isOnline = false
        })
    
        socket?.on(ChatEvents.infoMessage.rawValue, callback: { [weak self] (data, ack) in
            guard let data = data.first as? [String: Any],
                let message = data["message"] as? String else {
                    return
            }
            
            self?.delegate?.showInfoMessage(message: message)
        })
        
        socket?.on(ChatEvents.textMessage.rawValue, callback: { [weak self] (data, ack) in
            guard let data = data.first as? [String: Any],
                let nickname = data["nickname" ] as? String,
                let message = data["message"] as? String,
                let dateSendString = data["sendDate"] as? String else {
                    return
            }
            
            let date = dateSendString.toDate ?? Date()
            self?.delegate?.didGetTextMessage(nickname: nickname, message: message, date: date)
        })
        
        socket?.on(ChatEvents.imageMessage.rawValue, callback: { [weak self] (data, ack) in
            print("Getting image")
            guard let data = data.first as? [String: Any],
                let nickname = data["nickname" ] as? String,
                let dataImage = data["message"] as? Data,
                let image = UIImage.init(data: dataImage),
                let dateSendString = data["sendDate"] as? String else {
                    return
            }
            
            let date = dateSendString.toDate ?? Date()
            self?.delegate?.didGetImageMessage(nickname: nickname, image: image, date: date)
        })
        
        socket?.onAny {
            print("#DebugListener", $0.description)
        }
        
        socket?.on(ChatEvents.updateUserList.rawValue, callback: { [weak self] (data, ack) in
            guard let data = data.first as? [String: Any] else {
                return
            }
            
            let nickname = data["nickname"] as? String
            self?.delegate?.updateUserList(nickname: nickname)
        })
        
        socket?.on(ChatEvents.userTypingUpdate.rawValue, callback: { [weak self] (data, ack) in
            guard let data = data.first as? [String: Any],
                let message = data["message"] as? String,
            let needShow = data["needShow"] as? Bool else {
                return
            }
            
            self?.delegate?.didEnterMessage(message: message, needShow: needShow)
        })
    }
    
    private func login() {
        socket?.emitWithAck(ChatEvents.connectUser.rawValue,
                            client.nickname).timingOut(after: 0,
                                                       callback: { [weak self] (data) in
            guard let data = data.first as? [String: Any],
                let connected = data["connected"] as? Bool,
                let reason = data["reason"] as? String else {
                    return
            }
            
            self?.delegate?.userConnected(connected: connected, reason: reason)
            self?.client.isOnline = connected
        })
    }
    
    private func logout() {
        socket?.emit(ChatEvents.exitUser.rawValue, client.nickname)
    }
    
    func send(isEnterMessage: Bool) {
        socket?.emit(ChatEvents.userEnterMessage.rawValue, client.nickname, isEnterMessage)
    }
    
    func sendImage(nickname: String, imageContent content: ImageContent) {
        if let data = UIImagePNGRepresentation(content.image) {
            socket?.emit(ChatEvents.imageMessage.rawValue, client.nickname, data)
        }
        delegate?.didSendMessage()
    }
    
    func sendText(nickname: String, message: String) {
        socket?.emit(ChatEvents.textMessage.rawValue, nickname, message)
        delegate?.didSendMessage()
    }
}
