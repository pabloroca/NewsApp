//
//  SettingsDataController.swift
//  NewsApp
//
//  Created by Pablo Roca Rozas on 29/03/2017.
//  Copyright © 2017 PR2Studio. All rights reserved.
//

import Foundation
import RealmSwift

open class SettingsDataController {
    
    var realm: Realm = try! Realm()

    /// initial setup
    public func setup() {
        let arrobjects = self.realm.objects(Settings.self)
        if arrobjects.isEmpty {
            do {
                try realm.safeWrite {
                    let feedlist = FeedList().setup()
                    for i in 0...feedlist.count-1 {
                        self.realm.add(Settings.init(feedid: i, tsFeedRead: 0)!)
                    }
                }
            } catch let error as NSError {
                print("setup - Something went wrong: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - Common funcs
    
    public func readFirst(feedid: Int) -> Settings? {
        let predicate = NSPredicate(format: "feedid = %d", feedid)
        if let result = realm.objects(Settings.self).filter(predicate).first {
            return result
        } else {
            return nil
        }
    }
    
    /// setTSFeedRead
    public func setTSFeedRead(feedid: Int, ts: TimeInterval) {
        if let result = self.readFirst(feedid: feedid) {
            do {
                try realm.safeWrite {
                    result.tsFeedRead = ts
                }
            } catch let error as NSError {
                print("setup - Something went wrong: \(error.localizedDescription)")
            }
        }
    }
    
    open func readAll() -> [Settings] {
        let results = self.realm.objects(Settings.self)
        return(Array(results))
    }
    
    open func deleteAll() {
        do {
            try realm.write {
                realm.delete(self.readAll())
            }
        } catch let error as NSError {
            print("deleteAll - Something went wrong: \(error.localizedDescription)")
        }
    }
}
