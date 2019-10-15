Pod::Spec.new do |s|

  s.name         = "Threads"
  s.version      = "2.49.0"
  s.summary      = "Threads iOS SDK"
  
  s.description  = "Threads Contant-center iOS SDK"

  s.homepage     = "https://threads.im/"
  
  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author             = { "maslennikov" => "maslennikov@brooma.ru" }

  s.platform     = :ios
  s.ios.deployment_target = "8.0"

  s.source            = { :http => "https://github.com/ThreadsMobileLib/threads-sdk-ios-releases/releases/download/v#{s.version}/Threads.framework.zip" }

  s.source_files = '*.framework/**/*.h'
  s.public_header_files = '*.framework/**/*.h'

  s.vendored_frameworks = '*.framework'

end
