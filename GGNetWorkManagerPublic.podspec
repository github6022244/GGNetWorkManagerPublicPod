#
# Be sure to run `pod lib lint GGNetWorkManagerPublic.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'GGNetWorkManagerPublic'
  s.version          = '0.1.4'
  s.summary          = 'iOS 网络管理器 GGNetWorkManager公有库'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/github6022244/GGNetWorkManagerPublicPod'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '1563084860@qq.com' => '1563084860@qq.com' }
  s.source           = { :git => 'https://github.com/github6022244/GGNetWorkManagerPublicPod.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'GGNetWorkManagerPublic/Classes/**/*'
  
  # s.resource_bundles = {
  #   'GGNetWorkManagerPublic' => ['GGNetWorkManagerPublic/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
    s.dependency 'AFNetworking', '~> 4.0.1'
    s.dependency 'YTKNetwork', '~> 3.0.6'
end
