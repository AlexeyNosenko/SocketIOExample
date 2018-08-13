//
//  UIViewExtesions.swift
//  SocketsChat
//
//  Created by Алексей on 10.07.2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import UIKit

extension UIView {
    func loadNib() -> UIView? {
        return Bundle.main.loadNibNamed(String(describing: type(of: self)),
                                        owner: self,
                                        options: nil)?.first as? UIView
    }
}
