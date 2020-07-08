# WARNING!
# This podspec for local development only!
# For release library use https://github.com/ThreadsMobileLib/threads-sdk-ios-releases.git Threads.podspec

Pod::Spec.new do |s|

    s.name         = "Threads"
    s.version      = "3.5.0"
    s.summary      = "Threads iOS SDK"
    s.description  = "Threads Contant-center iOS SDK"
    s.homepage     = "https://threads.im/"
    
    s.author             = { "maslennikov" => "maslennikov@brooma.ru" }
    
    s.platform     = :ios
    s.ios.deployment_target = "9.0"
    
    s.module_map = 'Threads/Supporting Files/Threads.modulemap'
    
    s.source            = { :http => "https://github.com/ThreadsMobileLib/threads-sdk-ios-releases.git" }
    
    s.source_files = 'Threads/**/*.{h,m,c,swift}'
    
    s.resources = 'Threads/Sources/**/*.{xib,png,storyboard,strings,xcdatamodeld,bundle,xcassets}'
    
    s.vendored_frameworks = 'Frameworks/MFMSPushLite.framework'
    
    s.prefix_header_file = 'Threads/Supporting files/PrefixHeader.pch'
    
end
