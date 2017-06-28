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
    var selectedArticle:Article?
    
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
        
        // If the article has an image, then try to download it
        if article.articleImageUrl != "" {
            
            // Get the image view
            let imageview = cell.viewWithTag(2) as? UIImageView
            
            if let actualImageView = imageview {
                
                // Found the image view, now download the image
                
                // Create the URL object
                let url = URL(string: article.articleImageUrl)
                
                if let actualUrl = url {
                    
                    // Create URLRequest object
                    let request = URLRequest(url: actualUrl)
                
                    // Grab the current URLSession
                    let session = URLSession.shared
                
                    // Create a URLSession Data Task
                    let dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) in
                        
                        // Fire off this work to update the UI to the main thread
                        DispatchQueue.main.async {
                            // The data has been downloaded. Create a UIImage object and assign it into the imageview
                            if let actualData = data {
                                actualImageView.image = UIImage(data: actualData)
                            }
                        }
                        
                       
                        
                    })
                
                    // Fire off the data task
                    dataTask.resume()
                }
            }
            
        }
        

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // User has tapped on a row
        
        // Keep track of hte article that was selected
        selectedArticle = articles[indexPath.row]
        
        // Trigger the segue to go to the article detail view
        performSegue(withIdentifier: "goToDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Triggers when a segue is about to happen
        
        let detailVC = segue.destination as! DetailViewController
        detailVC.articleToDisplay = selectedArticle
        
        // Gives you a chance to prepare the destination view controller
        
    }
    
    
    
    
    
}

