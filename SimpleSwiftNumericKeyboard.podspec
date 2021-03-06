#
# Be sure to run `pod lib lint SimpleSwiftNumericKeyboard.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SimpleSwiftNumericKeyboard'
  s.version          = '0.1.4'
  s.summary          = 'SimpleSwiftNumericKeyboard is a numeric keyboard for ipad.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
    It is a numerical keyboard for ipad that you can use from a storyboard.
                       DESC

  s.homepage         = 'https://github.com/mmachado53/SimpleSwiftNumericKeyboard'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'mmachado53' => 'mmachado53@gmail.com' }
  s.source           = { :git => 'https://github.com/mmachado53/SimpleSwiftNumericKeyboard.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'
  s.swift_versions = '4.0'

  s.source_files = 'SimpleSwiftNumericKeyboard/Classes/**/*'
  
  #s.resource_bundles = {
  #  'SimpleSwiftNumericKeyboard' => ['SimpleSwiftNumericKeyboard/Classes/*.xib','SimpleSwiftNumericKeyboard/Assets/*.png']
  #}
  
  s.resources = ['SimpleSwiftNumericKeyboard/Assets/Images.xcassets']

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
