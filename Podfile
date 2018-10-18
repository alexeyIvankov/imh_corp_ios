project 'imh_corp_ios.xcodeproj'
workspace 'imh_corp_ios.xcworkspace'
source 'https://github.com/CocoaPods/Specs.git'
inhibit_all_warnings!

platform :ios, "10.0"

def default_pods

    pod 'Cocaine', :git => 'git@github.com:alexeyIvankov/Cocaine.git', :branch => 'release_1_3'
    pod 'KeyboardHandler', :git => 'https://github.com/alexeyIvankov/KeyboardHandler.git', :branch => 'swift_4.2'
    pod 'EventSender', :git => 'https://github.com/alexeyIvankov/EventSender.git', :branch => 'master'

    pod 'Fabric'
    pod 'Crashlytics'
    pod 'RealmSwift'
    pod 'BiometricAuthentication'
    pod 'KeychainSwift', '~> 11.0'
end

target :imh_corp_ios do
    default_pods
    use_frameworks!
end

target :imh_corp_iosTests do
    default_pods
    use_frameworks!
end
