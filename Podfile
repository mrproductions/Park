source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

target ‘Avionicus’ do
    pod "ObjectMapper+Realm"
    pod 'KeychainSwift', '~> 7.0'
    pod 'IDZSwiftCommonCrypto', '~> 0.9'
    pod 'SideMenu'
    pod 'ObjectMapper', '~> 2.2'
    pod 'GoogleMaps'
    pod 'SDWebImage', '~>3.8'
    pod 'Alamofire'
    pod 'SwiftyJSON'
    pod 'Charts'
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

target 'AvionicusWatch' do
    # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
    use_frameworks!
    
    
    # Pods for Park (WatchKit Alpha)
    
    target 'AvionicusWatchTests' do
        inherit! :search_paths
        # Pods for testing
    end
    
    target 'AvionicusWatchUITests' do
        inherit! :search_paths
        # Pods for testing
    end
    
end

target 'AvionicusWatch' do
    # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
    use_frameworks!
    
    
    # Pods for Park (WatchKit Alpha) WatchKit App
    
end

target 'AvionicusWatch Extension' do
    # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
    use_frameworks!
    
    
    # Pods for Park (WatchKit Alpha) WatchKit Extension
    
end
