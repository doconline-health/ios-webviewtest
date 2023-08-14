//
//  ViewController.swift
//  Doconlinewebviewtest
//
//  Created by sikandar-doc on 10/08/23.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKUIDelegate {
    
    var webView : WKWebView!
    let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
     
    
    
    override func loadView() {
        super.loadView();

        let webViewConfiguration = WKWebViewConfiguration();
    
        webViewConfiguration.allowsInlineMediaPlayback = true;
        webViewConfiguration.preferences.javaScriptCanOpenWindowsAutomatically = true;
        webViewConfiguration.mediaPlaybackRequiresUserAction = false;

//        webViewConfiguration.mediaTypesRequiringUserActionForPlayback = false;
        
        webView = WKWebView(frame:.zero , configuration: webViewConfiguration);

        webView.uiDelegate = self;

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Do any additional setup after loading the view.
  
        
        
        activityIndicator.startAnimating()
        webView = WKWebView()
        webView.navigationDelegate = self
        self.view = webView
        let loadURL = "https://demo.doconline.com"
        let url = URL(string: loadURL)!
        webView.load(URLRequest(url: url))
        activityIndicator.stopAnimating()
        webView.allowsBackForwardNavigationGestures = true
        
        
      
        
//        webView.allowsInlineMediaPlayback = true
//        webView.mediaType
//        webView.mediaTypesRequiringUserActionForPlayback = []
    }
    @available(iOS 15.0, *)
      func webView(_ webView: WKWebView,
          decideMediaCapturePermissionsFor origin: WKSecurityOrigin,
          initiatedBy frame: WKFrameInfo,
          type: WKMediaCaptureType) async -> WKPermissionDecision {
              return .grant;
      }

}

extension ViewController : WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activityIndicator.startAnimating()
    }
    
//    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) { // triggers when loading is complete
//        backButton.isHidden = !webView.canGoBack
//    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if webView.canGoBack {
             webView.goBack()
           } else {
             self.dismiss(animated: true, completion: nil)
           }
        activityIndicator.stopAnimating()
    }
//    public func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
//           let newWebView = WKWebView(frame: self.webView.frame,
//                            configuration: configuration)
//           view.addSubview(newWebView)
//           return newWebView
//       }
    // this handles target=_blank links by opening them in the same view
    func webView(webView: WKWebView!, createWebViewWithConfiguration configuration: WKWebViewConfiguration!, forNavigationAction navigationAction: WKNavigationAction!, windowFeatures: WKWindowFeatures!) -> WKWebView! {
        if navigationAction.targetFrame == nil {
            webView.load(navigationAction.request)
        }
        return nil
    }
}
