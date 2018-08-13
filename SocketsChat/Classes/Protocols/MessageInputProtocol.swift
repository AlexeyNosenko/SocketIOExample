//
//  MessageInputProtocol.swift
//  SocketsChat
//
//  Created by Алексей on 01.08.2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import UIKit

protocol MessageInputProtocol {
    func send(message: String)
    func send(image: UIImage)
    func didBeginChangeMessage(_ textView: UITextView)
    func didEndChangeMessage(_ textView: UITextView)
    func didChangeMessage(_ textView: UITextView)
}
