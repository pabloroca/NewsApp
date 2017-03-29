//
//  DetailViewController.swift
//  NewsApp
//
//  Created by Pablo Roca Rozas on 28/03/2017.
//  Copyright © 2017 PR2Studio. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    
    //UI
    @IBOutlet weak var viewWeb: UIWebView!
    @IBOutlet weak var viewActivity: UIActivityIndicatorView!
    //UI
    
    var link: String = ""
    
    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            if let label = self.detailDescriptionLabel {
                label.text = detail.description
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
        
        if link.characters.count > 0 {
            viewWeb.delegate = self;
            viewWeb.loadRequest(NSURLRequest(url: NSURL(string: link)! as URL) as URLRequest)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var detailItem: NSDate? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        self.viewActivity.isHidden = false
        self.viewActivity.startAnimating()

        return true
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        self.viewActivity.stopAnimating()
        self.viewActivity.isHidden = true
    }
    
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        self.viewActivity.stopAnimating()
        self.viewActivity.isHidden = true
    }
    

}

