//
//  TitleViewChat.swift
//  SocketsChat
//
//  Created by Алексей on 29.07.2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import UIKit

class TitleViewChat: UIView {
    private var view: UIView?
    
    @IBOutlet private weak var titleLabel: UILabel!
    
    @IBOutlet private weak var informationLabel: UILabel!
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "TitleViewChat", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    
    var title: String? {
        get {
            return titleLabel.text
        }
        set {
            titleLabel.text = newValue
        }
    }
    
    var infoText: String? {
        get {
            return informationLabel.text
        }
        set {
            informationLabel.text = newValue
        }
    }
}
