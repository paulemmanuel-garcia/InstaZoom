
#
# Be sure to run `pod lib lint InstaZoom.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "InstaZoom"
  s.version          = "0.0.2"
  s.summary          = "Replicate Instagram zooming feature."
  s.description      = <<-DESC
                            InstaZoom lets you replicate easily the Instagram zooming feature
                            on UIImageView.
                       DESC

  s.homepage         = "https://github.com/paulemmanuel-garcia/InstaZoom"
  s.license          = 'MIT'
  s.author           = { "Paul-Emmanuel Garcia" => "garcia.paulemmanuel@gmail.com" }
  s.source           = { :git => "https://github.com/paulemmanuel-garcia/InstaZoom.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/pemgarcia'

  s.platform     = :ios, '9.0'
  s.requires_arc = true

  s.source_files = 'Sources/'

end
