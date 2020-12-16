# Uncomment the next line to define a global platform for your project
 platform :ios, '10.0'

target 'TFAtWar' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks! :linkage => :static
  
  # We ignore 3rd party warnings 
  pod 'PromiseKit', :inhibit_warnings => true
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'Kingfisher'
  pod 'PATools'

  # Pods for TFAtWar

  target 'TFAtWarTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'TFAtWarUITests' do
    # Pods for testing
  end

end

post_install do |installer_representation|
    installer_representation.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '10.0'
        end
    end
end
