//
//  ChatViewControllerExtensions.swift
//  SocketsChat
//
//  Created by Алексей on 01.08.2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import UIKit

// MARK: Delegate - ChatUpdaterProtocol
extension ChatViewController: ChatUpdaterProtocol {
    func doneConnect(connected: Bool, reason: String? = nil) {
        if connected {
            loader(show: false)
            loadData()
        } else {
            self.showInfoAlert("Error", message: reason, okString: "Ok", okAction: { [weak self] _ in
                self?.goAway()
            })
        }
        isConnected = connected
    }
    
    func show(infoMessage message: String) {
        let content = InfoTextContent(text: message)
        let message = Message(content: content, from: "")
        send(message: message)
    }
    
    func updateUsers(users: [User]?) {
        print("#User update with GET")
    }
    
    func showHowEnterMessage(message: String, needShow: Bool) {
        if needShow {
            showInformation(text: message)
        } else {
            hideInformation()
        }
    }
    
    func add(nickname: String, image: UIImage,  date: Date) {
        guard let selfNickname = user?.nickname,
            nickname != selfNickname else {
                return
        }
        
        let content = ImageContent(filename: "Filename1", image: image, fileURL: "https")
        let msg = Message(content: content, from: nickname, dateSend: date)
        add(message: msg)
    }
    
    func add(nickname: String, message: String, date: Date) {
        guard let selfNickname = user?.nickname,
            nickname != selfNickname else {
                return
        }
        
        let content = TextContent(text: message)
        let msg = Message(content: content, from: nickname, dateSend: date)
        add(message: msg)
    }
    
    func updateMessages(messages: [Message]?) {
        guard let messages = messages else {
            return
        }
        
//        messageController.removeAll()
        messages.forEach{
            add(message: $0)
        }
        
        
        collectionView.reloadData()
        collectionView.scrollToButton()
    }
}

// MARK: Delegate - MessageInputProtocol
extension ChatViewController: MessageInputProtocol {
    func didChangeMessage(_ textView: UITextView) {
//        chat?.enterMessage(isEnterMessage: true)
    }
    
    func didBeginChangeMessage(_ textView: UITextView) {
        chat?.enterMessage(isEnterMessage: true)
    }
    
    func didEndChangeMessage(_ textView: UITextView) {
        chat?.enterMessage(isEnterMessage: false)
    }
    
    func send(image: UIImage) {
        let content = ImageContent(filename: image.description, image: image, fileURL: "")
        let message = Message(content: content, from: user?.nickname ?? "", sender: .himself)
        send(message: message)
    }
    
    func send(message: Message) {
        add(message: message)
        chat?.sendMessage(message: message)
        collectionView.scrollToButton()
    }
    
    func send(message: String) {
        guard message.containsNonWhitespace else {
            return
        }
        
        let content = TextContent(text: message)
        let msg = Message(content: content, from: user?.nickname ?? "", sender: .himself)
        send(message: msg)
    }
}

// MARK: Delegate - UICollectionViewDelegate, UICollectionViewDataSource
extension ChatViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messageController.count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MessageCollectionViewCell.indetifier,
                                                         for: indexPath) as? MessageCollectionViewCell,
            let textMessageController = messageController[indexPath.row] as? MessageTextController {
            cell.messageController = textMessageController
            return cell
        }
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCollectionViewCell.indetifier,
                                                         for: indexPath) as? ContentCollectionViewCell,
            let imageMessageController = messageController[indexPath.row] as? MessageImageController {
            cell.messageController = imageMessageController
            
            return cell
        }
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InfoCollectionViewCell.indetifier,
                                                         for: indexPath) as? InfoCollectionViewCell,
            let infoMessageController = messageController[indexPath.row] as? MessageInfoController {
            cell.messageController = infoMessageController
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let messageController = messageController[indexPath.row] as? MessageTextController {
            let size = CGSize(width: UIScreen.main.bounds.size.width - leftRightInsets * 2.0, height: 1000)
            let message = messageController.textContent?.text ?? ""
            let attributes = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15)]
            let estimateFrame = NSString(string: message).boundingRect(with: size,
                                                                       options: .usesLineFragmentOrigin,
                                                                       attributes: attributes,
                                                                       context: nil)
            let cellSize = CGSize(width: UIScreen.main.bounds.size.width, height: estimateFrame.height + 50)
            return cellSize
        }
        
        if let imageMessageController = messageController[indexPath.row] as? MessageImageController {
            let width = UIScreen.main.bounds.size.width  - leftRightInsets * 2.0
            var height = width
            if let size = imageMessageController.image?.size {
                height = width * (size.height / size.width)
            }
            let cellSize = CGSize(width: width, height: height)
            return cellSize
        }
        
        if let infoMessageController = messageController[indexPath.row] as? MessageInfoController {
            let size = CGSize(width: UIScreen.main.bounds.size.width, height: 1000)
            let message = infoMessageController.infoContent?.text ?? ""
            let attributes = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15)]
            let estimateFrame = NSString(string: message).boundingRect(with: size,
                                                                       options: .usesLineFragmentOrigin,
                                                                       attributes: attributes,
                                                                       context: nil)
            let cellSize = CGSize(width: UIScreen.main.bounds.size.width, height: estimateFrame.height + 5.0)
            return cellSize
        }
        
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let cellSize = CGSize(width: UIScreen.main.bounds.size.width, height: 10)
        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        let cellSize = CGSize(width: UIScreen.main.bounds.size.width, height: 10)
        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 7
    }
}

// MARK: - Delegate SpamSocketProtocol
extension ChatViewController: SpamSocketProtocol {
    func showSpam(spam: Spam) {
        self.showAlert(spam.title,
                       message: spam.message,
                       okString: spam.btnOk,
                       cancelString: spam.btnCancel) { (_) in
            UIApplication.shared.open(spam.url, options: [:], completionHandler: nil)
        }
    }
}

