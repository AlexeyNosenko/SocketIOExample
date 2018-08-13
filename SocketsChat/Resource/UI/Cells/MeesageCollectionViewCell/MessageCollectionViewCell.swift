//
//  MessageTableViewCell.swift
//  SocketsChat
//
//  Created by Алексей on 10.07.2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import UIKit

class MessageCollectionViewCell: UICollectionViewCell {

    static let indetifier = "MessageCollectionViewCell"
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var timeSendLabel: UILabel!
    
    @IBOutlet weak var rightInsetsView: NSLayoutConstraint!
    
    @IBOutlet weak var leftInsetsView: NSLayoutConstraint!
    
    var messageController: MessageTextController? {
        didSet{
            config(messageController: messageController!)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 10
    }

    private func config(messageController: MessageTextController) {
        nameLabel.text = messageController.title
        messageLabel.text = messageController.text
        timeSendLabel.text = messageController.message.dateSend.time
        leftInsetsView.constant = messageController.leftInsets
        rightInsetsView.constant = messageController.rightInsets
    }
}
