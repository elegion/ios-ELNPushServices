Pod::Spec.new do |s|

  s.name         = "ELNPushServices"
  s.version      = "0.0.1"
  s.summary      = "Apple Push Services manager."
  s.homepage     = "https://github.com/elegion/ios-ELNPushServices"
  s.license      = "MIT"
  s.author       = { "chebur" => "chebur.mail@gmail.com" }
  s.platform     = :ios
  s.source       = { :git => "https://github.com/elegion/ios-ELNValidatorELNPushServices.git", :tag => s.version }

  s.source_files  = "Source", "Source/**/*.{h,m}"

end
