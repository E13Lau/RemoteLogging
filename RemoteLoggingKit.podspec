Pod::Spec.new do |spec|
  spec.name           = 'RemoteLoggingKit'
  spec.version        = '0.0.8'
  spec.summary        = 'RemoteLoggingKit is a print log in the web page framework for iOS,macOS and tvOS.'
  spec.homepage       = 'https://github.com/E13Lau/RemoteLogging'
  spec.license        = 'MIT'
  spec.author         = 'e13lau'
  spec.module_name    = 'RemoteLogging'
  spec.source         = { :git => 'https://github.com/E13Lau/RemoteLogging.git', :tag => '0.0.8' }
  spec.source_files   = 'Sources/RemoteLogging/**/*.swift'
  spec.swift_version  = '5.0'
  spec.resource_bundles = { 'RemoteLogging_RemoteLogging' => ['Sources/RemoteLogging/Resources/**/*'] }

  spec.ios.deployment_target = '9.0'
  spec.osx.deployment_target = '10.10'
  spec.tvos.deployment_target = '9.0'

  spec.dependency 'Telegraph', '~> 0.28'
  spec.dependency 'Logging', '~> 1.4.0'
end
