//
//  ContentCollectionViewCell.swift
//  SocketsChat
//
//  Created by Алексей on 30.07.2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import UIKit

class ContentCollectionViewCell: UICollectionViewCell {
    
    static let indetifier = "ContentCollectionViewCell"
    
    @IBOutlet weak var nicknameLabel: UILabel!
    
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var filenameLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var rightInsetsView: NSLayoutConstraint!
    
    @IBOutlet weak var leftInsetsView: NSLayoutConstraint!
    
    var messageController: MessageImageController? {
        didSet {
            updateCell()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 10
    }
    
    func updateCell() {
        guard let messageController = messageController else {
            return
        }
        
        nicknameLabel.text = messageController.title
        image.image = messageController.image
        filenameLabel.text = messageController.filename
        timeLabel.text = messageController.message.dateSend.time
        leftInsetsView.constant = messageController.leftInsets
        rightInsetsView.constant = messageController.rightInsets
    }
}
