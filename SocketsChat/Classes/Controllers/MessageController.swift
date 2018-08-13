//
//  MessageController.swift
//  SocketsChat
//
//  Created by Алексей on 11.07.2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import UIKit

class MessageController {
    var message: Message
    
    let defaultInsets: CGFloat = 60.0
    
    class func createMessageController(message: Message) -> MessageController? {
        switch message.content {
            case _ where message.content is ImageContent:
                return MessageImageController(message: message)
            case _ where message.content is InfoTextContent:
                return MessageInfoController(message: message)
            case _ where message.content is TextContent:
                return MessageTextController(message: message)
        default:
                return nil
        }
    }
    
    var leftInsets: CGFloat {
        return message.sender == .himself ? defaultInsets : 0.0
    }
    
    var rightInsets: CGFloat {
        return message.sender == .someone ? defaultInsets : 0.0
    }
    
    var title: String {
        return message.sender == .himself ? "You" : message.from
    }
    
    init(message: Message) {
        self.message = message
    }
}
    
class MessageImageController: MessageController {
    var imageContent: ImageContent? {
        return message.content as? ImageContent
    }
    
    var filename: String? {
        return imageContent?.filename
    }
    
    var fileurl: String? {
        return imageContent?.fileURL
    }
    
    var image: UIImage? {
        return imageContent?.image
    }
}

class MessageTextController: MessageController {
    var textContent: TextContent? {
        return message.content as? TextContent
    }
    
    var text: String? {
        return textContent?.text
    }
}
    
class MessageInfoController: MessageController {
    var infoContent: InfoTextContent? {
        return message.content as? InfoTextContent
    }
    
    var info: String? {
        return infoContent?.text
    }
}
