# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Onban' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  post_install do |installer|
        installer.pods_project.targets.each do |target|
              target.build_configurations.each do |config|
                    config.build_settings['EXCLUDED_ARCHS[sdk=iphonesimulator*]'] = 'arm64'
              end
  end
  end

  pod 'RxSwift', '6.5.0'
  pod 'RxCocoa', '6.5.0'
  pod 'SnapKit', '~> 5.6.0'
  pod 'SwiftLint'
  pod 'Toaster'

  # Pods for Onban

  target 'OnbanTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'OnbanUITests' do
    # Pods for testing
  end

end
