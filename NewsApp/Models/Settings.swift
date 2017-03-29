//
//  Settings.swift
//  NewsApp
//
//  Created by Pablo Roca Rozas on 29/03/2017.
//  Copyright © 2017 PR2Studio. All rights reserved.
//

import Foundation
import RealmSwift

public class Settings: Object {
    dynamic var feedid: Int = 0
    dynamic var tsFeedRead: Double = 0
}
