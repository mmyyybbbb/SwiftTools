Pod::Spec.new do |s|
  s.name             = 'SwiftTools'
  s.version          = '1.0.2'
  s.summary          = 'Модуль SwiftTools'
  s.homepage         = 'https://gitlab.com/BCSBroker/iOS/SwiftTools'
  s.author           = 'BCS'
  s.source           = { :git => 'https://gitlab.com/BCSBroker/iOS/swifttools.git', :tag => s.version.to_s }
  s.license      = { :type => 'MIT', :file => "LICENSE" }
  s.ios.deployment_target = '10.0'
  s.swift_version = '5.0'
  s.module_name  = 'SwiftTools'  
  s.source_files  = 'SwiftTools/**/*.swift' 
end
