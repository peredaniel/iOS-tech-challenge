# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

# Comment the next line if you're not using Swift and don't want to use dynamic frameworks
use_frameworks!

# Comment the next line if you want the compiler to throw warnings regarding the Pods implementation
inhibit_all_warnings!

def app_pods
  pod 'AlamofireImage',       '~>3.5.0'
  pod 'DataSourceController', '~>1.0.0'
end

  # Pods for ABA Music
target 'ABA Music' do
  app_pods
end

target 'ABA MusicTests' do
  inherit! :search_paths
  pod 'SnapshotTesting', '~> 1.6.0'
end

target 'ABA MusicUITests' do
  inherit! :search_paths
  app_pods
  pod 'Swifter', '~>1.4.7'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '5.0'
    end
  end
end
