//
//  UIViewControllerExtensions.swift
//  SocketsChat
//
//  Created by Алексей on 01.08.2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import UIKit

extension UIViewController {
    func showInfoAlert(_ title: String?,
                       message: String?,
                       okString: String?,
                       okAction: ((UIAlertAction) -> Swift.Void)?) {
        let alertVC = UIAlertController(title: title,
                                        message: message,
                                        preferredStyle: .alert)
        
        let firstAction = UIAlertAction(title: okString, style: .default, handler: okAction)
        
        alertVC.addAction(firstAction)
        self.present(alertVC, animated: true, completion: nil)
    }
    
    func showAlert(_ title: String?,
                   message: String?,
                   okString: String?,
                   cancelString: String?,
                   okAction: ((UIAlertAction) -> Swift.Void)?) {
        
        let alertVC = UIAlertController(title: title,
                                        message: message,
                                        preferredStyle: .alert)
        
        let firstAction = UIAlertAction(title: okString, style: .default, handler: okAction)
        let cancel = UIAlertAction(title: cancelString, style: .cancel, handler: nil)
        
        alertVC.addAction(firstAction)
        alertVC.addAction(cancel)
        self.present(alertVC, animated: true)
    }
}
