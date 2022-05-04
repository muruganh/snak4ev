# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'SNAK4EV' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for SNAK4EV
    pod 'IQKeyboardManagerSwift'
  pod 'JTMaterialSpinner', '~> 3.0'
  pod 'GoogleMaps'
  pod 'GooglePlaces'
  pod 'Firebase/Core’
  pod 'Firebase/Messaging'
  pod 'SwiftMessages'
  pod 'Alamofire', '~> 4.4'
  pod 'SideMenu'
  pod 'GoogleMaps', '~>5.2.0'
  pod 'razorpay-pod', '~>1.1.1'
  pod 'DropDown'
  pod 'MercariQRScanner'
  
  target 'SNAK4EVTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'SNAK4EVUITests' do
    # Pods for testing
  end

end

post_install do |installer_representation|
    installer_representation.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['ONLY_ACTIVE_ARCH'] = 'NO'
            config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
        end
    end
end
