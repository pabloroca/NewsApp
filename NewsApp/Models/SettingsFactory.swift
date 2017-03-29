//
//  SettingsFactory.swift
//  NewsApp
//
//  Created by Pablo Roca Rozas on 29/03/2017.
//  Copyright © 2017 PR2Studio. All rights reserved.
//

import Foundation

extension Settings {
    convenience init?(feedid: Int, tsFeedRead: Double) {
        self.init()

        self.feedid = feedid
        self.tsFeedRead = tsFeedRead
    }
}
