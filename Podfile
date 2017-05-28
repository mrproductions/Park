source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

target ‘Avionicus’ do
    pod "ObjectMapper+Realm"
    pod 'KeychainSwift', '~> 7.0'
    pod 'Charts'
    pod 'IDZSwiftCommonCrypto', '~> 0.9'
    pod 'Alamofire'
    pod 'SwiftyJSON'
    pod 'SideMenu'
    pod 'ObjectMapper', '~> 2.2'
    pod 'GoogleMaps'
    pod 'SDWebImage', '~>3.8'
    pod 'BTNavigationDropdownMenu', :git => 'https://github.com/PhamBaTho/BTNavigationDropdownMenu.git', :branch => 'swift-3.0'
    pod 'RealmSwift'
    post_install do |installer|
        installer.pods_project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['SWIFT_VERSION'] = '3.0'
            end
        end
    end
end
