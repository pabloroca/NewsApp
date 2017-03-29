//
//  FeedCell.swift
//  NewsApp
//
//  Created by Pablo Roca Rozas on 29/03/2017.
//  Copyright © 2017 PR2Studio. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {

    //UI
    @IBOutlet weak var imgfeed: UIImageView!
    @IBOutlet weak var lbltitle: UILabel!
    @IBOutlet weak var btnShare: UIButton!
    //UI
    
    var feedlink: String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureCell(data: Feed) {
        lbltitle.text = data.title
        if !data.media.isEmpty {
            imgfeed.PR2ImageFromNetwork(data.media)
        } else {
            imgfeed.image = nil
        }
        feedlink = data.link
    }
    
}
