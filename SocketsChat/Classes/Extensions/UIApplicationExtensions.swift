//
//  UIApplicationExtensions.swift
//  SocketsChat
//
//  Created by Алексей on 30.07.2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import UIKit

extension UIApplication {
    class func topViewController(controller: UIViewController?
        = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}
