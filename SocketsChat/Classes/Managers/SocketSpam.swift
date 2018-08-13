//
//  SocketSpam.swift
//  SocketsChat
//
//  Created by Алексей on 02.08.2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import Foundation
import SocketIO

enum SpamEvent: String {
    case spaming
    case spam
}

struct Spam {
    var title: String
    var message: String
    var url: URL
    var btnOk: String
    var btnCancel: String
}

class SpamManager {
    var socket: SocketSpam
    
    init() {
        socket = SocketSpam()
    }
    
    func spaming() {
        socket.spaming()
    }
}

protocol SpamSocketProtocol {
    func showSpam(spam: Spam)
}

class SocketSpam {
    
    static let nsp = "/spam"
    
    private var socket: SocketIOClient?
    
    var delegate: SpamSocketProtocol?
    
    init() {
        socket = SocketIOManager.shared.getNspSocket(nameSpace: SocketSpam.nsp)
        addListeners()
    }
    
    func connection() {
        socket?.connect()
    }
    
    func disconnection() {
        socket?.disconnect()
    }
    
    func addListeners() {
        socket?.on(SpamEvent.spam.rawValue, callback: { [weak self] (data, ack) in
            guard let spam = data.first as? [String: Any],
                let title = spam["title"] as? String,
                let message = spam["message"] as? String,
                let urlString = spam["url"] as? String,
                let url = URL(string: urlString),
                let btnOk = spam["btnOk"] as? String,
                let btnCancel = spam["btnCancel"] as? String else {
                return
            }
            let spm = Spam(title: title, message: message, url: url, btnOk: btnOk, btnCancel: btnCancel)
            self?.delegate?.showSpam(spam: spm)
        })
    }
    
    func spaming() {
        socket?.emit(SpamEvent.spaming.rawValue)
    }
}
