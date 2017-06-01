//
//  ViewController.swift
//  RSS
//
//  Created by Jacob Edmond on 5/29/17.
//  Copyright © 2017 Jacob Edmond. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var model = FeedModel()
    var articles = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        // Kick off the article download in the brackground
        model.getArticles()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Triggers when a segue is about to happen
        // Gives you a chance to prepare the destination view controller
        
    }
}

