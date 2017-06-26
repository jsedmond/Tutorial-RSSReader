//
//  ViewController.swift
//  RSS
//
//  Created by Jacob Edmond on 5/29/17.
//  Copyright © 2017 Jacob Edmond. All rights reserved.
//

import UIKit

class ViewController: UIViewController, FeedModelDelegate, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var tableView: UITableView!
    
    var model = FeedModel()
    var articles = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        // Set the view controller as the datasource and delegate
        tableView.delegate = self
        tableView.dataSource = self
        
        // Kick off the article download in the brackground
        model.delegate = self
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
    
    // Implement FeedModelDelegate protocol functions
    func articlesReady() {
        // Get the articles from the model
        articles = model.articles
    }
    
    // Implement the tableView delegate functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Get a cell to reuse
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasicCell")!
        
        // Get article for this row
        let article = articles[indexPath.row]
        
        // Get the text label
        let label = cell.viewWithTag(1) as? UILabel
        
        if let actualLabel = label {
            
            // Set the label
            actualLabel.text = article.articleTitle
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // User has tapped on a row
        
        // Trigger the segue to go to the article detail view
    }
    
}

