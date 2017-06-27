//
//  DetailViewController.swift
//  RSS
//
//  Created by Jacob Edmond on 5/29/17.
//  Copyright © 2017 Jacob Edmond. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var webView: UIWebView!
    var articleToDisplay:Article?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let article = articleToDisplay {
            
            // Article exists, load it in the webview
            
            // Create URK object
            let u = URL(string: article.articleLink)
            
            if let url = u {
                
                // URL object exists, create URLRequest
                let request = URLRequest(url: url)
                
                // Load the request in the webview
                webView.loadRequest(request)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
