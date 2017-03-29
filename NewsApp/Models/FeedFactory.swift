//
//  FeedFactory.swift
//  NewsApp
//
//  Created by Pablo Roca Rozas on 28/03/2017.
//  Copyright © 2017 PR2Studio. All rights reserved.
//

import Foundation

extension Feed {
    convenience init?(feedid: Int, title: String?, fdescription: String?, link: String?, pubDate: Date?, media: String?) {
        self.init()
        
        self.feedid = feedid
        self.title = title != nil ? title! : ""
        self.fdescription = fdescription != nil ? fdescription! : ""
        self.link = link != nil ? link! : ""
        self.pubDate = pubDate != nil ? pubDate! : nil
        self.media = media != nil ? media! : ""
    }
}
