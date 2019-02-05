#
#  Be sure to run `pod spec lint CrytpoTicker.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|


  s.name         = "CrytpoTicker"
  s.version      = "0.1.4"
  s.summary      = "Gets cryptocurrency price data from coinmarketcap.com."

  s.description  = <<-DESC
  Gets cryptocurrency price data from coinmarketcap.com. Please see coinmarketcap.com api.  
                   DESC

  s.homepage     = "https://github.com/starsfaraway/CrytpoTicker"



  s.license      = "MIT"
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }

  s.author             = { "Matthew" => "xmatthewx@pme.me" }

  s.platform     = :ios, "12.0"

  s.ios.deployment_target = "12.0"
  s.source       = { :git => "https://github.com/starsfaraway/CrytpoTicker.git", :tag => "0.1.4" }

  s.source_files  = "CrytpoTicker/*.{h,m,swift}"

 #s.public_header_files = "CrytpoTicker/CryptoTicker.swift"




end
