//
//  FeedListFactory.swift
//  NewsApp
//
//  Created by Pablo Roca Rozas on 28/03/2017.
//  Copyright © 2017 PR2Studio. All rights reserved.
//

import Foundation

extension FeedList {
    convenience init?(title: String?, url: String?) {
        self.init()
        guard let title = title else {
            return nil
        }
        self.title = title

        guard let url = url else {
            return nil
        }
        self.url = url
    }
}
