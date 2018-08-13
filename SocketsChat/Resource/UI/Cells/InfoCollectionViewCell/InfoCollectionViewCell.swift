//
//  InfoCollectionViewCell.swift
//  SocketsChat
//
//  Created by Алексей on 31.07.2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import UIKit

class InfoCollectionViewCell: UICollectionViewCell {
 
    static let indetifier = "InfoCollectionViewCell"
    
    @IBOutlet weak var infoLabel: UILabel!
    
    var messageController: MessageInfoController? {
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
        
        infoLabel.text = messageController.info
    }
}
