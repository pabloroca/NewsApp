//
//  FeedNetworkController.swift
//  NewsApp
//
//  Created by Pablo Roca Rozas on 28/03/2017.
//  Copyright © 2017 PR2Studio. All rights reserved.
//

import Foundation
import Alamofire
import SWXMLHash

open class FeedNetworkController {
    
    open func readFeedFor(
        _ feednumber: Int, completionHandler: @escaping (_ success: Bool) -> Void
        ) {
        
        if let settings = SettingsDataController().readFirst(feedid: feednumber) {
            guard Date().timeIntervalSince1970 - settings.tsFeedRead > Constants.cacheTimeforFeed else {
                completionHandler(true)
                return
            }
            
            let feedlist = FeedList().setup()
            
            if let endpoint = feedlist[feednumber].url {
                Alamofire.request(endpoint, method: .get).response(completionHandler: { (response) in
                    let xml = SWXMLHash.parse(response.data!)
                    FeedDataController().processxml(feedid: feednumber, xml: xml)
                    completionHandler(true)
                })
            } else {
                completionHandler(false)
            }
        }
    }
    
}
