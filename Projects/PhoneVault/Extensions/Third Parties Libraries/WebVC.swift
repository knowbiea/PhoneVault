//
//  WebVC.swift
//  SocialApp
//
//  Created by Arvind on 18/04/25.
//

import UIKit
import WebKit

class WebVC: UIViewController {
    
    // MARK: - Properties
    fileprivate let keyLoading = "loading"
    fileprivate let keyEstimateProgress = "estimatedProgress"
    var titleString = ""
    var URLToLoad: String = ""
    var progressTintColor: UIColor?
    var trackTintColor: UIColor?
    var isShare: Bool = false
    var webView: WKWebView
    
    @IBOutlet fileprivate weak var loadingProgress: UIProgressView!
    @IBOutlet fileprivate weak var webViewContainer: UIView!
    
    // MARK: - life cycle
    
    required init?(coder aDecoder: NSCoder) {
        webView = WKWebView()
        super.init(coder: aDecoder)
        webView.navigationDelegate = self
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        webView = WKWebView()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        webView.navigationDelegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: true)
        viewConfigurations()
        registerObservers()
        
        if isShare {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(shareAction))
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        removeObservers()
        visibleActivityIndicator(false)
    }
    
    // MARK: - Bar Button Actions
    @objc func shareAction() {
        guard let documentUrl = URL(string: URLToLoad) else { return }
        let activityViewController = UIActivityViewController(activityItems: [documentUrl], applicationActivities: nil)
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    // MARK: - private functions
    fileprivate func viewConfigurations() {
        
        //These are the changes for UnderTopBars & UnderBottomBars
        edgesForExtendedLayout = []
        extendedLayoutIncludesOpaqueBars = false
        webView.scrollView.contentInsetAdjustmentBehavior = .never
        
        loadingProgress.trackTintColor = trackTintColor
        loadingProgress.progressTintColor = progressTintColor
        
        webViewContainer.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        let attributes: [NSLayoutConstraint.Attribute] = [.top, .bottom, .right, .left]
        
        NSLayoutConstraint.activate(attributes.map {
            NSLayoutConstraint(item: webView, attribute: $0, relatedBy: .equal, toItem: webViewContainer, attribute: $0, multiplier: 1, constant: 0)
        })
        
        guard let url = URL(string: URLToLoad) else {
            print("Couldn't load create NSURL from: " + URLToLoad)
            return
        }
        
        navigationItem.title = titleString.count == 0 ? url.lastPathComponent : titleString
        webView.load(URLRequest(url: url))
        
    }
    
    fileprivate func registerObservers() {
        webView.addObserver(self, forKeyPath: keyLoading, options: .new, context: nil)
        webView.addObserver(self, forKeyPath: keyEstimateProgress, options: .new, context: nil)
    }
    
    fileprivate func removeObservers() {
        webView.removeObserver(self, forKeyPath: keyLoading)
        webView.removeObserver(self, forKeyPath: keyEstimateProgress)
    }
    
    fileprivate func visibleActivityIndicator(_ visible: Bool) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = visible
    }
    
    fileprivate func showAlert(_ title: String, message: String) {
        let alertController: UIAlertController = UIAlertController(title: title,
                                                                   message: message,
                                                                   preferredStyle: UIAlertController.Style.alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Overridden Methods
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if (keyPath == keyEstimateProgress) {
            loadingProgress.isHidden = webView.estimatedProgress == 1
            loadingProgress.setProgress(Float(webView.estimatedProgress), animated: true)
        }
    }
}

extension WebVC: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        visibleActivityIndicator(true)
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        visibleActivityIndicator(false)
        showAlert("", message: error.localizedDescription)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        visibleActivityIndicator(false)
        loadingProgress.setProgress(0.0, animated: false)
    }
    
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        if navigationAction.navigationType == WKNavigationType.linkActivated {
            
            let url = navigationAction.request.url
            let shared = UIApplication.shared
            
            if shared.canOpenURL(url!) {
                shared.open(url!, options: [:], completionHandler: nil)
            }
            
            decisionHandler(WKNavigationActionPolicy.cancel)
        }
        
        decisionHandler(.allow)
    }
}
