//
//  PR2Extensions.swift
//  WeatherSwift
//
//  Created by Pablo Roca Rozas on 12/3/17.
//  Copyright © 2017 PR2Studio. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import AlamofireImage
import RealmSwift

// requires Alamofire / AlamofireImage / PR2Common
extension UIImageView {
    func PR2ImageFromNetwork(_ imageURL: String, indicatorStyle: UIActivityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: indicatorStyle)
        indicator.center = self.center;// it will display in center of image view
        self.addSubview(indicator)
        indicator.startAnimating()

        Alamofire.request(imageURL, method: .get)
            .responseImage { response in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                indicator.stopAnimating()
                indicator.isHidden = true
                indicator.removeFromSuperview()
                if let image = response.result.value {
                    //                    let image = UIImage(data: response.data!, scale: UIScreen.mainScreen().scale)!
                    self.image = image
                }
        }
    }
}

extension Realm {
    public func safeWrite(_ block: (() throws -> Void)) throws {
        if isInWriteTransaction {
            try block()
        } else {
            try write(block)
        }
    }
}

extension String {
    
    public func PR2DateFormatterFromWeb() -> Date {
        return DateFormatter.PR2DateFormatterFromWeb.date(from: self)!
    }
    
    public func PR2DateFormatterFromAPI() -> Date {
        return DateFormatter.PR2DateFormatterFromAPI.date(from: self)!
    }
    
    public func PR2DateFormatterUTCiso8601() -> Date {
        return DateFormatter.PR2DateFormatterUTCiso8601.date(from: self)!
    }
    
}

extension NSDate {
    
    // Date format for API
    public func PR2DateFormatterFromAPI() -> String {
        return DateFormatter.PR2DateFormatterFromAPI.string(from: self as Date)
    }
    
    // Date format for Logs
    public func PR2DateFormatterForLog() -> String {
        return DateFormatter.PR2DateFormatterForLog.string(from: self as Date)
    }
    
    // Date in UTC
    public func PR2DateFormatterUTC() -> String {
        return DateFormatter.PR2DateFormatterUTC.string(from: self as Date)
    }
    
    // Date in UTCiso8601
    public func PR2DateFormatterUTCiso8601() -> String {
        return DateFormatter.PR2DateFormatterUTCiso8601.string(from: self as Date)
    }
    
    // Date in HHMMh
    public func PR2DateFormatterHHMM() -> String {
        return DateFormatter.PR2DateFormatterHHMM.string(from: self as Date)
    }
    
}

extension DateFormatter {
    
    public static let PR2DateFormatterFromWeb: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss zzz"
        return formatter
    }()
    
    public static let PR2DateFormatterFromAPI: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }()
    
    public static let PR2DateFormatterForLog: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        return formatter
    }()
    
    public static let PR2DateFormatterUTC: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }()
    
    // from http://stackoverflow.com/questions/28016578/swift-how-to-create-a-date-time-stamp-and-format-as-iso-8601-rfc-3339-utc-tim
    public static let PR2DateFormatterUTCiso8601: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXX"
        return formatter
    }()
    
    public static let PR2DateFormatterHHMM: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
}
