//
//  UIApplication+Ext.swift
//  SocialApp
//
//  Created by Arvind on 19/04/25.
//

import SwiftUI

extension SceneDelegate {
    static var shared: SceneDelegate {
        guard let firstScene = UIApplication.shared.connectedScenes.first,
              let sceneDelegate = firstScene.delegate as? SceneDelegate else {
            fatalError("Failed to find SceneDelegate - this should never happen")
        }
        
        return sceneDelegate
    }
}

extension UIApplication {
    
    class func topViewController(_ viewController: UIViewController? = SceneDelegate.shared.window?.rootViewController) -> UIViewController? {
        
        if let nav = viewController as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        
        if let tab = viewController as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }
        
        if let presented = viewController?.presentedViewController {
            return topViewController(presented)
        }
        
        return viewController
    }
}
