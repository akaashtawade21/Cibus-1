//
//  RecipeWebViewController.swift
//  Cibus
//
//  Created by Louie McConnell on 10/7/17.
//  Copyright © 2017 Louie McConnell. All rights reserved.
//

import UIKit

class RecipeWebViewController: UIViewController {
    var urlString: String!
    var recipeTitle: String!
    var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = recipeTitle
        webView = UIWebView(frame: self.view.frame)
        let url = URL(string: urlString)
        
        webView.loadRequest(URLRequest(url: url!))
        view.addSubview(webView)

        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
