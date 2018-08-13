//
//  StringExtensions.swift
//  SocketsChat
//
//  Created by Алексей on 29.07.2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import Foundation

extension String {
    var containsNonWhitespace: Bool {
        return !self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var jsonToDictionary: [String: Any]? {
        guard let dataParse = self.data(using: .utf8),
            let json = try? JSONSerialization.jsonObject(with: dataParse, options: []),
            let jsonArray = json as? [String: Any] else {
                return nil
        }
        return jsonArray
    }
    
    var toDate: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let date = dateFormatter.date(from: self) else {
            return nil
        }
        
        return date
    }
}
