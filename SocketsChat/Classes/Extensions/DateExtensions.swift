//
//  DateExtensions.swift
//  SocketsChat
//
//  Created by Алексей on 11.07.2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import Foundation

extension Date {
    var time: String {
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
}
