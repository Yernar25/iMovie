//
//  TrailerViewController.swift
//  iMovie
//
//  Created by Yernar Dyussenbekov on 28.11.2024.
//

import UIKit
import WebKit
import SVProgressHUD

class TrailerViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var webView: WKWebView!
    
    var key = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        
        let url = URL(string: "https://www.youtube.com/embed/\(key)")
        let urlRequest = URLRequest(url: url!)
        
        webView.load(urlRequest)
        // Do any additional setup after loading the view.
        
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        SVProgressHUD.show()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        SVProgressHUD.dismiss()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: any Error) {
        SVProgressHUD.dismiss()
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: any Error) {
        SVProgressHUD.dismiss()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
