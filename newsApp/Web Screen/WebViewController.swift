//
//  WebViewController.swift
//  newsApp
//
//  Created by manukant tyagi on 22/10/22.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    //MARK: - Properties
    var urlString = ""
    @IBOutlet weak var webView: WKWebView!
    
    //MARK: - lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        loadURL()
        setNavBar()
    }
    
    //MARK: - set navigation Item
    func setNavBar(){
        let leftButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeWebView))
        navigationItem.leftBarButtonItem = leftButton
    }
    
    // close VC
    @objc func closeWebView(){
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - load the URL
    func loadURL(){
        guard let url = URL(string: urlString) else {
            showToast(message: "Invalid Url")
            return
        }
        self.view.activityStartAnimating()
        DispatchQueue.main.async {[weak self] in
            self?.webView.load(URLRequest(url: url))
        }
    }
}


//MARK: - web view navigation delegate
extension WebViewController: WKNavigationDelegate{
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        DispatchQueue.main.async {
            self.view.activityStopAnimating()
        }
        
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        DispatchQueue.main.async {
            self.view.activityStopAnimating()
//            self.showToast(message: error.localizedDescription)
        }
        
    }
}
