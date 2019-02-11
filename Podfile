inhibit_all_warnings!
use_frameworks!

def import_test_pods

    pod 'Quick', :git => 'https://github.com/Quick/Quick', :branch => 'swift-2.0'
    pod 'Nimble', :git => 'https://github.com/Quick/Nimble', :branch => 'swift-2.0'

end

target "ExSwiftTests-iOS" do

    platform :ios, '8.0'

    import_test_pods

end

target "ExSwiftTests-Mac" do

    platform :osx, '10.10'

    import_test_pods

end
