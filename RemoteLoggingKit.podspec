Pod::Spec.new do |spec|
  spec.name         = "RemoteLoggingKit"
  spec.version      = "0.0.2"
  spec.summary      = "RemoteLoggingKit is a print log in the web page framework for iOS,macOS and tvOS."
  spec.homepage     = "https://github.com/E13Lau/RemoteLogging"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author             = "e13lau"
  s.ios.deployment_target = '9.0'
  s.osx.deployment_target = '10.10'
  s.tvos.deployment_target = '9.0'
  s.module_name = 'Logging'
  spec.source       = { :git => "https://github.com/E13Lau/RemoteLogging.git", :tag => "#{spec.version}" }
  spec.source_files  = 'Sources/RemoteLogging/**/*.swift'

  spec.resource_bundles = {
    "RemoteLoggingKit" => ["Sources/RemoteLogging/Resources/*.*"]
  }
  
  spec.dependency "Telegraph', '~> 0.28"
  spec.dependency "Logging', '~> 1.4.0"
end
