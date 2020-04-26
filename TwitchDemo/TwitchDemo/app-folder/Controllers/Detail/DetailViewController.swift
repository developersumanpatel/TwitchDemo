//
//  DetailViewController.swift
//  TwitchDemo
//
//  Created by Suman on 26/04/20.
//  Copyright © 2020 Suman. All rights reserved.
//

import UIKit
import WebKit
import SwiftTwitch

class DetailViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    var videos: [VideoData] = []
    var currentIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        webView.navigationDelegate = self
        loadVideo()
    }
    
    private func showLoader() {
        activityView.startAnimating()
        activityView.isHidden = false
    }
    
    private func hideLoader() {
        activityView.isHidden = true
        activityView.stopAnimating()
    }
    
    func loadVideo() {
        guard videos.count > currentIndex else {
            return
        }
        
        let urlData = videos[currentIndex].url
        let myRequest = URLRequest(url: urlData)
        webView.load(myRequest)
    }
    
    @IBAction func nextClicked(_ sender: UIButton) {
        currentIndex += 1
        if currentIndex > videos.count {
            currentIndex = videos.count
            return
        }
        loadVideo()
    }
    
    @IBAction func prevClicked(_ sender: UIButton) {
        currentIndex -= 1
        if currentIndex < 0 {
            currentIndex = 0
            return
        }
        loadVideo()
    }
}

extension DetailViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        showLoader()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        hideLoader()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        hideLoader()
    }
}
