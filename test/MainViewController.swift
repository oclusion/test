//
//  MainViewController.swift
//  test
//
//  Created by Ricardo García on 8/9/19.
//  Copyright © 2019 Oclusion. All rights reserved.
//

import UIKit
import WebKit
import JavaScriptCore

class MainViewController: UIViewController, WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler {
    
    @IBOutlet weak var viewWebView: WKWebView!
    @IBOutlet weak var victoryUIButton: UIButton!
    @IBOutlet weak var defeatUIButton: UIButton!
    
    let activityWrapperView: UIView = UIView()
    let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var isUnloadingWebView = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.startUI()
        self.startLoading()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func startUI() {
        viewWebView.isHidden = true
        viewWebView.uiDelegate = self
        viewWebView.navigationDelegate = self
        viewWebView.scrollView.bounces = false
        viewWebView.scrollView.isScrollEnabled = true
        viewWebView.allowsBackForwardNavigationGestures = false
        viewWebView.contentMode = .scaleToFill
        viewWebView.scrollView.contentInsetAdjustmentBehavior = .never
        viewWebView.configuration.preferences.setValue(true, forKey: "allowFileAccessFromFileURLs")
        viewWebView.configuration.userContentController.add(self, name: "jsHandler")
        victoryUIButton.addTarget(self, action: #selector(victoryTapButton), for: .touchUpInside)
        defeatUIButton.addTarget(self, action: #selector(defeatTapButton), for: .touchUpInside)
    }
    
    @objc func victoryTapButton(_ sender: UIButton) {
        isUnloadingWebView = false
        let url = Bundle.main.url(forResource: "index", withExtension: "html", subdirectory: "Website")!
        viewWebView.loadFileURL(url, allowingReadAccessTo: url)
        let request = URLRequest(url: url)
        viewWebView.load(request)
    }
    
    @objc func defeatTapButton(_ sender: UIButton) {
        isUnloadingWebView = false
        let url = Bundle.main.url(forResource: "index", withExtension: "html", subdirectory: "Website")!
        viewWebView.loadFileURL(url, allowingReadAccessTo: url)
        let request = URLRequest(url: url)
        viewWebView.load(request)
    }
    
    func startLoading() {
        activityWrapperView.backgroundColor = .black
        view.addSubview(activityWrapperView)
        activityWrapperView.translatesAutoresizingMaskIntoConstraints = false
        activityWrapperView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        activityWrapperView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        activityWrapperView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        activityWrapperView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.whiteLarge
        activityWrapperView.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        UIView.animate(withDuration: 1.0 , delay: 4.0, options: .curveEaseOut, animations: {
            self.activityWrapperView.alpha = 0
        }, completion: { _ in
            self.activityWrapperView.removeFromSuperview()
            self.activityIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
        })
    }
    
    func animateWebViewOut() {
        UIView.animate(withDuration: 0.4 , delay: 0, options: .curveEaseOut, animations: {
            self.viewWebView.alpha = 0
        }, completion: { _ in
            self.viewWebView.isHidden = false
            self.viewWebView.loadHTMLString("", baseURL: nil)
        })
    }
    
    // MARK START: WKNavigationDelegate
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if isUnloadingWebView == false {
            let javascriptStyle = "var css = '*{-webkit-touch-callout:none;-webkit-user-select:none;margin:0;padding:0;} html{background:#000;color:#fff;}'; var head = document.head || document.getElementsByTagName('head')[0]; var style = document.createElement('style'); style.type = 'text/css'; style.appendChild(document.createTextNode(css)); head.appendChild(style);"
            webView.evaluateJavaScript(javascriptStyle, completionHandler: nil)
            
//            let safeAreaHeight = self.view.frame.height
//            let jsSize = "var width = \(UIScreen.main.bounds.width); var height = \(safeAreaHeight); init();"
//            webView.evaluateJavaScript(jsSize, completionHandler: nil)
            
            viewWebView.alpha = 0
            viewWebView.isHidden = false
            UIView.animate(withDuration: 0.4 , delay: 0, options: .curveEaseOut, animations: {
                self.viewWebView.alpha = 1
            }, completion: { _ in
                
            })
        }
    }
    
    // MARK START: WKScriptMessageHandler
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "jsHandler" {
            print(message.body)
            isUnloadingWebView = true
            self.animateWebViewOut()
        }
    }
    
}
