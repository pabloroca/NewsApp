//
//  FeedDataController.swift
//  NewsApp
//
//  Created by Pablo Roca Rozas on 28/03/2017.
//  Copyright © 2017 PR2Studio. All rights reserved.
//

import Foundation
import SWXMLHash
import RealmSwift

open class FeedDataController {
    
    var realm: Realm = try! Realm()

    public func processxml(feedid: Int, xml: XMLIndexer) {
        self.deleteForFeed(feedid: feedid)
        do {
            try realm.safeWrite {
                for elem in xml["rss"]["channel"]["item"].all {
                    if let channeltitle = xml["rss"]["channel"]["title"].element?.text {
                        if channeltitle.range(of:"BBC") != nil {
                            self.realm.add(Feed.init(feedid: feedid, title: elem["title"].element?.text, fdescription: elem["description"].element?.text, link: elem["link"].element?.text, pubDate: elem["pubDate"].element?.text?.PR2DateFormatterFromWeb(), media: elem["media:thumbnail"].element?.attribute(by: "url")?.text)!)
                        } else {
                            self.realm.add(Feed.init(feedid: feedid, title: elem["title"].element?.text, fdescription: elem["description"].element?.text, link: elem["link"].element?.text, pubDate: elem["pubDate"].element?.text?.PR2DateFormatterFromWeb(), media: "")!)
                        }
                    }
                }
            }
            SettingsDataController().setTSFeedRead(feedid: feedid, ts: Date().timeIntervalSince1970)
        } catch let error as NSError {
            print("setup - Something went wrong: \(error.localizedDescription)")
        }
    }
    
    public func readAll() -> [Feed] {
        let results = self.realm.objects(Feed.self)
        return(Array(results))
    }

    public func readForFeed(feedid: Int) -> [Feed] {
        let predicate = NSPredicate(format: "feedid = %d", feedid)
        let results = realm.objects(Feed.self).filter(predicate)
        
        let arrResults = Array(results)
        
        // newwest on top
        let myArraySorted = arrResults.sorted { (one, two) -> Bool in
            return one.pubDate! > two.pubDate!
        }

        return(myArraySorted)
    }

    public func deleteForFeed(feedid: Int) {
        do {
            try realm.write {
                realm.delete(self.readForFeed(feedid: feedid))
            }
        } catch let error as NSError {
            print("deleteAll - Something went wrong: \(error.localizedDescription)")
        }
    }

    public func deleteAll() {
        do {
            try realm.write {
                realm.delete(self.readAll())
            }
        } catch let error as NSError {
            print("deleteAll - Something went wrong: \(error.localizedDescription)")
        }
    }
    
}
