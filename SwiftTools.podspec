Pod::Spec.new do |s|
  s.name             = 'SwiftTools'
  s.version          = '2.0.1'
  s.summary          = 'SwiftTools - набор различных иструментов и часто используемых экстеншенов'
  s.homepage         = 'https://gitlab.com/BCS-Broker/iOS/SwiftTools'
  s.author           = 'BCS-Broker'
  s.source           = { :git => 'https://gitlab.com/BCS-Broker/iOS/swifttools.git', :tag => s.version.to_s }
  s.license      = { :type => 'MIT', :file => "LICENSE" }
  s.ios.deployment_target = '10.0'
  s.swift_version = '5.0'
  s.module_name  = 'SwiftTools'  
  s.source_files  = 'SwiftTools/**/*.swift' 
end
