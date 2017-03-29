//
//  Feed.swift
//  NewsApp
//
//  Created by Pablo Roca Rozas on 28/03/2017.
//  Copyright © 2017 PR2Studio. All rights reserved.
//

import Foundation
import RealmSwift

public class Feed: Object {
    dynamic var feedid: Int = 0
    dynamic var title: String = ""
    dynamic var fdescription: String = ""
    dynamic var link: String = ""
    dynamic var pubDate: Date?
    dynamic var media: String = ""
}
