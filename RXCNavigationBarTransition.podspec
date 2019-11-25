Pod::Spec.new do |spec|

  spec.name         = "RXCNavigationBarTransition"
  spec.version      = "1.0"
  spec.summary      = "UINavigationBar black magic to dance"
  spec.description  = "UINavigationBar black magic to dance."

  spec.homepage     = "https://github.com/ruixingchen/RXCNavigationBarTransition"
  spec.license      = "MIT"
  spec.author             = { "ruixingchen" => "dev@ruixingchen.com" }
  # spec.social_media_url   = "https://twitter.com/ruixingchen"

  spec.platform     = :ios, "11.0"
  spec.source       = { :git => "https://github.com/ruixingchen/RXCNavigationBarTransition.git", :tag => "#{spec.version}" }
  spec.source_files  = "Source", "Source/**/*.swift"
  spec.frameworks = "Foundation", "UIKit"
  spec.requires_arc = true
  spec.swift_version = "5.1"

end
