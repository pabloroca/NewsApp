//
//  NewsListViewController.swift
//  NewsApp
//
//  Created by Pablo Roca Rozas on 28/03/2017.
//  Copyright © 2017 PR2Studio. All rights reserved.
//

import UIKit
import BTNavigationDropdownMenu

class NewsListViewController: UITableViewController {

    //UI
    @IBOutlet var viewTable: UITableView!
    //UI
    
    var detailViewController: DetailViewController?
    var objects = [Any]()

    var arrayFeeds: [Feed] = []
    var feedlistTitles: [String] = []
    var selectedFeed: Int = 0
    
    internal let myrefreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()

        viewTable.refreshControl = myrefreshControl
        refreshControl?.addTarget(self, action: #selector(NewsListViewController.refreshData(sender:)), for: .valueChanged)
        
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        FeedNetworkController().readFeedFor(selectedFeed) { [weak self] (success) in
            self?.arrayFeeds =  FeedDataController().readForFeed(feedid: (self?.selectedFeed)!)
            self?.viewTable.reloadData()
        }

    }

    override func viewWillAppear(_ animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
        super.viewWillAppear(animated)
        
        let feedlist = FeedList().setup()
        
        feedlistTitles = feedlist.flatMap { (elem) -> String in
            return elem.title!
        }
        
        navigationController?.navigationBar.barTintColor = UIColor.gray
        
        let menuView = BTNavigationDropdownMenu(navigationController: self.navigationController, containerView: self.navigationController!.view, title: feedlist[0].title!, items: feedlistTitles as [AnyObject])
        
        self.navigationItem.titleView = menuView
        
        menuView.didSelectItemAtIndexHandler = {[weak self] (index: Int) -> Void in
            print("Did select item at index: \(index)")
            if index != self?.selectedFeed {
                SettingsDataController().setTSFeedRead(feedid: index, ts: 0)
                self?.selectedFeed = index
            }
            FeedNetworkController().readFeedFor(index) { [weak self] (success) in
                self?.arrayFeeds =  FeedDataController().readForFeed(feedid: index)
                self?.viewTable.reloadData()
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = objects[indexPath.row] as! NSDate
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let viewcontroller = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        viewcontroller.link = arrayFeeds[indexPath.row].link
        self.navigationController?.pushViewController(viewcontroller, animated: true)
    }
    
    // MARK: - UI Actions

    @IBAction func btnShareTouched(_ sender: UIButton) {
        let textToShare = NSLocalizedString("texttoshare", comment: "")
        let feedlink = arrayFeeds[sender.tag].link
        if let myWebsite = NSURL(string: feedlink) {
            let objectsToShare = [textToShare, myWebsite] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            activityVC.popoverPresentationController?.sourceView = sender
            self.present(activityVC, animated: true, completion: nil)
        }
    }

    func refreshData(sender: UIRefreshControl) {
        myrefreshControl.endRefreshing()
        SettingsDataController().setTSFeedRead(feedid: selectedFeed, ts: 0)
        FeedNetworkController().readFeedFor(selectedFeed) { [weak self] (success) in
            self?.arrayFeeds =  FeedDataController().readForFeed(feedid: (self?.selectedFeed)!)
            self?.viewTable.reloadData()
        }
    }
}
