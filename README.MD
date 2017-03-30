
## Main specs:

* Developed in SWIFT 3.0
* iOS 9.0 compatible
* CocoaPods
* using ligth MVC architecture
* Network requests in the background
* Image downloading in the background
* Unit tests
* plist with NSAppTransportSecurity
* plist with UIRequiresPersistentWiFi (like Apple's mail app)
* AutoLayout
* waiting indicators in status bar
* cache by 5 mins internally, cause OpenWeatherMap has no cache system. (not finished)
* using SwiftLint to enforce Swift style and conventions
* Pull to refresh feeds
* No data available if first time launch has no connectivity
* Using as few external libraries as possible:

* Alamofire
* AlamofireImage
* RealmSwift
* SwiftLint
* SWXMLHash
* BTNavigationDropdownMenu

## Running Unit tests

* From Menu select View -> Navigators -> Show Test Navigator or Apple key + 5
* From Menu select Product -> Test or Apple Key + U

## SOLID principles

Trying to apply SOLID principles and Clean Code, specially the Single Responsability. Classes must be lightewigth and perform only one task inside his abstraction layer. So it's better to have more classes that one big bloated class. Used Factory methods and other techniques for class separation.

## SwiftLint
https://github.com/realm/SwiftLint

A tool for enforcing good code style.

The run script if deactivated, just in case you don't have it installed. To reenable, uncomment lines in Run Script Phase we have in the NewsApp target

## Database

Using RealmSwift, I have created this tables:

* Feed
* Settings

## TODO (out of time), What I would add

* VIPER architecture (it's too much for a simple exercise)
* OHHTTPStubs tests

## To enhance

* more use of protocols
