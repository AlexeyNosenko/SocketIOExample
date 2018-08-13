//
//  ChatViewController.swift
//  SocketsChat
//
//  Created by Алексей on 10.07.2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var infoLabel: UILabel!
    
    @IBOutlet weak var infoLabelHeight: NSLayoutConstraint!
    
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    @IBOutlet weak var messageInputView: MessageInputView!
    
    // MARK: - Properties
    var chat: Chat?
    
    var spam: SocketSpam?
    
    var user: User?
    
    var messageController = [MessageController]()
    
    var titleViewChat: TitleViewChat?
    
    var isConnected: Bool = false
    
    var infoLabelHeightOriginal: CGFloat?
    
    var infoLabelHeightDefault: CGFloat = 20.0
    
    let timeOut = 15.0
    
    // MARK: - Override funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loader(show: true)
        loadChat()
        loadChatView()
        loadSpam()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + timeOut) { [weak self] in
            if !(self?.isConnected ?? false) {
                self?.doneConnect(connected: false, reason: "Не удалось подключиться")
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        collectionView.scrollToButton()
    }
    
    // MARK: - Action funcs
    @IBAction func action(_ sender: Any) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let actionCancel = UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil)
        let actionChatUsers = UIAlertAction(title: "Chat Users", style: .default) { [weak self] (action) in
            guard let `self` = self,
                let viewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "OnlineUsersTableViewController") as? OnlineUsersTableViewController else {
                    return
            }
            
            viewController.chat = self.chat
            self.navigationController?.pushViewController(viewController, animated: true)
        }
        
        let actionLoginUsers = UIAlertAction(title: "Login user", style: .default) { [weak self] (action) in
            let content = InfoTextContent.init(text: "Вошел пользователь Test")
            let message = Message(content: content, from: "", sender: .himself)
            self?.send(message: message)
        }

        let actionSendImage = UIAlertAction(title: "Image from user", style: .default) { [weak self] (action) in
            let content = ImageContent(filename: "image", image:  #imageLiteral(resourceName: "choose_photo"), fileURL: "")
            let message = Message(content: content, from: "", sender: .himself)
            self?.send(message: message)
        }
        
        let actionSpam = UIAlertAction(title: "Commercial break", style: .default) { [weak self] (action) in
            self?.spam?.spaming()
        }
        
        let actionEnterUser = UIAlertAction(title: "Enter user", style: .default) { [weak self] (action) in
            self?.showHowEnterMessage(message: "Test", needShow: true)
        }
        
        alert.addAction(actionChatUsers)
        alert.addAction(actionSpam)
        alert.addAction(actionLoginUsers)
        alert.addAction(actionEnterUser)
        alert.addAction(actionSendImage)
        alert.addAction(actionCancel)
        
        present(alert, animated: true)
    }
    
    // MARK: - Public funcs
    func loader(show: Bool) {
        if show {
            loader.startAnimating()
            loader.isHidden = false
        } else {
            loader.stopAnimating()
            loader.isHidden = true
        }
    }
    
    func loadChatView() {
        collectionView.register(UINib(nibName: MessageCollectionViewCell.indetifier, bundle: nil),
                                forCellWithReuseIdentifier: MessageCollectionViewCell.indetifier)
        
        collectionView.register(UINib(nibName: ContentCollectionViewCell.indetifier, bundle: nil),
                                forCellWithReuseIdentifier: ContentCollectionViewCell.indetifier)
        
        collectionView.register(UINib(nibName: InfoCollectionViewCell.indetifier, bundle: nil),
                                forCellWithReuseIdentifier: InfoCollectionViewCell.indetifier)
        
        messageInputView.delegate = self
        messageInputView.parentViewController = self
        infoLabelHeightOriginal = infoLabelHeight.constant
        hideInformation()
        loadNavigationBar()
    }
    
    func loadData() {
        chat?.loadMessages()
    }
    
    @objc func goAway() {
        chat?.disconnection()
        spam?.disconnection()
        chat = nil
        spam = nil
        SocketIOManager.shared.disconnect()
        if let nc = navigationController {
            nc.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func loadSpam() {
        spam = SocketSpam()
        spam?.delegate = self
        spam?.connection()
    }
    
    func add(message: Message) {
        chat?.addMessage(message: message)
        
        if let controller = MessageController.createMessageController(message: message) {
            messageController.append(controller)
        }
        collectionView.reloadData()
    }
    
    func showInformation(text: String) {
        infoLabel.text = text
        infoLabel.isHidden = false
        infoLabelHeight.constant = infoLabelHeightOriginal ?? infoLabelHeightDefault
        collectionView.scrollToButton()
    }
    
    func hideInformation() {
        infoLabelHeight.constant = 0.0
        infoLabel.text = ""
        infoLabel.isHidden = true
    }
    
    // MARK: - Private funcs
    private func loadNavigationBar() {
        let exitButton = UIBarButtonItem(title: "Exit", style: .done, target: self, action: #selector(goAway))
        exitButton.tintColor = .red

        navigationItem.leftBarButtonItem = exitButton
        self.title = chat?.name ?? self.title
    }
   
    private func loadChat() {
        guard let user = user else {
            return
        }
        
        chat = Chat(name: "Chaaaat", client: user)
        chat?.delegate = self
        chat?.connection()
    }
}


