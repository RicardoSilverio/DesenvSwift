//
//  ViewController.swift
//  WebView
//
//  Created by Usuário Convidado on 07/11/15.
//  Copyright © 2015 7MOB. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate, UIWebViewDelegate {
    
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var search: UISearchBar!
    @IBOutlet weak var progress: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let url = NSURL(string: "http://www.cefsa.org.br")!
        search.text = url.absoluteString
        let request = NSURLRequest(URL: url)
        webView.loadRequest(request)
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        progress.startAnimating()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        progress.stopAnimating()
        search.resignFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        var text = search.text
        let url = NSURL(string: text!)
        let request = NSURLRequest(URL: url!)
        webView.loadRequest(request)
    }


}

