#
# Be sure to run `pod lib lint ABUtils.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ABUtils'
  s.version          = '0.1.4'
  s.summary          = 'Utils that can be used in any project, to reduce the amount of repetitive code by providing users with useful pre-written functions.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
ABUtils is a library which provides pre-written functionality. This makes it easier to develop cleaner code by removing the need for repetitive code, as well as easier to get started without having to re-write code between projects. As demand increases for a function, it will be added.
                       DESC

  s.homepage         = 'https://github.com/andrewboryk/ABUtils'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Andrew Boryk' => 'aboryk@mercymavericks.edu' }
  s.source           = { :git => 'https://github.com/andrewboryk/ABUtils.git', :tag => s.version.to_s }

  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'ABUtils/Classes/**/*'
  
  # s.resource_bundles = {
  #   'ABUtils' => ['ABUtils/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
