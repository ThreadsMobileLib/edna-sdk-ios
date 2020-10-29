Pod::Spec.new do |s|

    s.name         = "Threads"
    s.version      = "3.6.1"
    s.summary      = "Threads iOS SDK"
    s.description  = "Threads Contant-center iOS SDK"
    s.homepage     = "https://threads.im/"
    s.license      = { :type => "MIT", :file => "LICENSE" }
    s.author       = { "maslennikov" => "maslennikov@brooma.ru" }
    
    s.platform     = :ios
    s.ios.deployment_target = "9.0"
    
    s.source = { :http => "https://github.com/ThreadsMobileLib/threads-sdk-ios-releases/releases/download/v#{s.version}/Threads.framework.zip" }
    s.source_files = '*.framework/**/*.h'
    s.public_header_files = '*.framework/**/*.h'
    s.vendored_frameworks = '*.framework'

    s.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
    s.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }

end
