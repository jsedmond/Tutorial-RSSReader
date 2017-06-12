//
//  FeedModel.swift
//  RSS
//
//  Created by Jacob Edmond on 5/31/17.
//  Copyright © 2017 Jacob Edmond. All rights reserved.
//

import UIKit

class FeedModel: NSObject, XMLParserDelegate {
    
    var url = "https://www.theverge.com/rss/index.xml"
    var articles = [Article]()
    
    // Parsing variables
    var constructingArticle:Article?
    var constructingString = ""
    var linkAttributes = [String:String]()
    
    func getArticles() {
        
        // Download the RSS Feed
        let feedURL = URL(string: url)
        
        if let actualFeedURL = feedURL {
            let parser = XMLParser(contentsOf: actualFeedURL)
            
            if let actualParser = parser {
                
                // We have an actual parser object
                actualParser.delegate = self
                actualParser.parse()
            }
        }
    }
    
    // This function called when the parser finds a new starting tag
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        // We only care about the Entry, Title, Content and Link
        if elementName == "entry" {
            constructingArticle = Article()
        }
        else if elementName == "link" {
            linkAttributes = attributeDict
        }
    }
    
    // This function called when the parser finds characters between two tags
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        // We only want to save the characters, if the current tag is Title and Content
        if constructingArticle != nil {
            constructingString += string
        }
    }
    
    // This function called when the parser finds an ending tag
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        // We only want to do someothing when the ending tag is Entry, Title, Content and Link
        
        if elementName == "title" {
            // Save the constructingString as the Title for our constructingArticle
            let title = constructingString.trimmingCharacters(in: .whitespacesAndNewlines)
            
            constructingArticle?.articleTitle = title
        }
        else if elementName == "content" {
            // Save the constructingSring as the Content for our constructingArticle
            constructingArticle?.articleBody = constructingString
        }
        else if elementName == "link" {
            // Save the href attribute as the article url for our constructingArticle
            if let href = linkAttributes["href"] {
                constructingArticle?.articleLink = href
            }
        }
        else if elementName == "entry" {
            // Save the constucting article into the array
            if let a = constructingArticle {
                articles.append(a)
            }
            
            // Reset the constructingArticle var
            constructingArticle = nil
        }
        
        // Reset the constructingString
        constructingString = ""
    }

    // This function called when the parser finshes parsing the feed
    func parserDidEndDocument(_ parser: XMLParser) {
        // When the feed is parsed, we want to notify the delegate
    }
    
    
    
    
    
    
    
    
}
