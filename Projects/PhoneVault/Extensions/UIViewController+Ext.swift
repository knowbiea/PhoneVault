//
//  UIViewController+Ext.swift
//  SocialApp
//
//  Created by Arvind on 18/04/25.
//

import UIKit

extension UIViewController {
    func showDocumentURL(_ documentUrl: String, title: String = "", isShare: Bool = false) {
        let webViewController = WebVC()
        
        var urlString = documentUrl
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        guard let urlStrings = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        
        print("Url: \(urlStrings)")
        webViewController.URLToLoad = urlStrings // Configure WebViewController
        webViewController.progressTintColor = .green
        webViewController.trackTintColor = .red
        webViewController.titleString = title
        webViewController.isShare = isShare
        webViewController.hidesBottomBarWhenPushed = true
        
        navigationController?.pushViewController(webViewController, animated: true)
    }
}
