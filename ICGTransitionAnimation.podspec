Pod::Spec.new do |s|

  s.name         = "ICGTransitionAnimation"
  s.version      = "1.02"
  s.summary      = "Library to customize transition animation in iOS 7"

  s.description  = <<-DESC
                   ICGTransitionAnimation provides a convenient method to present view controllers with custom animation and interaction.
                   You can also easily create your own transition animations and apply them to your view controllers to make your app stand out.

                   DESC
  s.screenshots  = "https://raw.githubusercontent.com/itsmeichigo/ICGTransitionAnimation/master/Demo.gif"
  s.homepage     = "https://github.com/itsmeichigo/ICGTransitionAnimation"
  s.social_media_url = 'https://twitter.com/itsmeichigo'
  s.license      = 'MIT'

  s.author       = "Huong Do"

  s.platform     = :ios, "6.1"

  s.source       = { :git => "https://github.com/itsmeichigo/ICGTransitionAnimation.git", :tag => "1.02" }

  s.source_files  = "Source/**/*.{h,m}"

  s.framework  = "UIKit"

  s.requires_arc = true

end
