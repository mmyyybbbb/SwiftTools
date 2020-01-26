Pod::Spec.new do |s|
  s.name             = 'BCSSwiftTools'
  s.version          = '2.0.2'
  s.summary          = 'SwiftTools - набор различных иструментов и часто используемых экстеншенов'
  s.homepage         = 'https://github.com/BCS-Broker/SwiftTools'
  s.author           = 'BCS-Broker'
  s.source           = { :git => 'https://github.com/BCS-Broker/SwiftTools.git', :tag => s.version.to_s }
  s.license      = { :type => 'MIT', :file => "LICENSE" }
  s.ios.deployment_target = '10.0'
  s.swift_version = '5.0'
  s.module_name  = 'BCSSwiftTools'  
  s.source_files  = 'SwiftTools/**/*.swift' 
end
