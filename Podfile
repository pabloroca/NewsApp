source 'https://github.com/CocoaPods/Specs.git'
use_frameworks!
platform :ios, '9.0'

def shared_pods
  pod 'Alamofire', '~> 4.4'
  pod 'AlamofireImage', '~> 3.2'
  pod 'RealmSwift', '~> 2.4.4'
  pod 'SwiftLint'
  pod 'SWXMLHash', '~> 3.0.0'
  pod 'BTNavigationDropdownMenu', :git => 'https://github.com/PhamBaTho/BTNavigationDropdownMenu.git', :branch => 'swift-3.0'
end

target 'NewsApp' do
    shared_pods
end

target 'NewsAppTests' do
    shared_pods
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end

