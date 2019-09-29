//
//  HeroViewController.swift
//  MarvelHeroes
//
//  Created by Cesar Paiva.
//  Copyright © Cesar Paiva. All rights reserved.
//

import UIKit
import WebKit

class HeroViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    var hero: Hero?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let hero = hero {
            if let firstUrl = hero.urls.first {
                if let url = URL(string: firstUrl.url) {
                    let request = URLRequest(url: url)
                    webView.allowsBackForwardNavigationGestures = true
                    webView.navigationDelegate = self
                    webView.load(request)
                }
                title = hero.name
            }
        }
    }
}

extension HeroViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loading.stopAnimating()
    }
}
