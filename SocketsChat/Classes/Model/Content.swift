//
//  Content.swift
//  SocketsChat
//
//  Created by Алексей on 02.08.2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import UIKit

protocol Content {
    
}

class InfoTextContent: Content {
    var text: String
    
    init(text: String) {
        self.text = text
    }
}

class TextContent: Content {
    var text: String
    
    init(text: String) {
        self.text = text
    }
}

class ImageContent: Content {
    let fileUUID = UUID().uuidString
    var filename: String
    var image: UIImage
    var fileURL: String
    
    init(filename: String, image: UIImage, fileURL: String) {
        self.filename = filename
        self.image = image
        self.fileURL = fileURL
    }
}
