//
//  TermsConditionViewController.swift
//  SNAK4EV
//
//  Created by Apple  on 13/05/22.
//

import UIKit
import WebKit

class TermsConditionViewController: BaseViewController, WKUIDelegate, WKNavigationDelegate {

    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.didBeginLoading()
        webView.navigationDelegate = self
        let url=URL(string: "https://www.snak4ev.com/terms.html");
        webView.load(URLRequest(url: url!));
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationBar.lblTitle.text = "Terms & Conditions"
        navigationBar.imgBack.image = UIImage.init(named: "back")
        navigationBar.btnBack.addTarget(self, action: #selector(btnMenu(_:)), for: .touchUpInside)
    }
    
    @IBAction override func btnMenu(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    func webView(_ webView: WKWebView,didFinish navigation: WKNavigation!) {
        print("loaded")
        self.didEndLoading()
    }
    
    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        guard let serverTrust = challenge.protectionSpace.serverTrust  else {
            completionHandler(.useCredential, nil)
            return
        }
        let credential = URLCredential(trust: serverTrust)
        completionHandler(.useCredential, credential)
        
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
