//
//  NewsListViewControllerData.swift
//  NewsApp
//
//  Created by Pablo Roca Rozas on 29/03/2017.
//  Copyright © 2017 PR2Studio. All rights reserved.
//

import UIKit

extension NewsListViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayFeeds.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as! FeedCell
        // Configure the cell...
        cell.tag = indexPath.row
        cell.configureCell(data: arrayFeeds[indexPath.row])
        return cell
    }
    
}
