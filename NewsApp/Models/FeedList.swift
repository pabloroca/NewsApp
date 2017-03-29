//
//  FeedList.swift
//  NewsApp
//
//  Created by Pablo Roca Rozas on 28/03/2017.
//  Copyright © 2017 PR2Studio. All rights reserved.
//

import Foundation

public class FeedList {
    var title: String?
    var url: String?
    
    func setup() -> [FeedList] {
        var array: [FeedList] = []

        array.append(FeedList.init(title: "BBC News UK", url: "http://feeds.bbci.co.uk/news/uk/rss.xml")!)
        array.append(FeedList.init(title: "BBC News Technology", url: "http://feeds.bbci.co.uk/news/technology/rss.xml")!)
        array.append(FeedList.init(title: "Reuters UK", url: "http://feeds.reuters.com/reuters/UKdomesticNews?format=xml")!)
        array.append(FeedList.init(title: "Reuters Technology", url: "http://feeds.reuters.com/reuters/technologyNews?format=xml,")!)
        
        return array
    }
}
