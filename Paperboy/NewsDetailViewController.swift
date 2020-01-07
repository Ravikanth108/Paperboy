//
//  NewsDetailViewController.swift
//  Paperboy
//
//  Created by Shyam on 03/12/19.
//  Copyright © 2019 Assignment. All rights reserved.
//

import UIKit
import WebKit

class NewsDetailViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var webView: WKWebView!
    
    var url: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: self.url)!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    
}
