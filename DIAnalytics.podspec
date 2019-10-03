#
# Be sure to run `pod lib lint Flurry-iOS-SDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DIAnalytics'
  s.version          = '0.1.4'
  s.summary          = 'DIAnalytics for iOS'
  s.license          = { :type => 'Commercial', :file => 'LICENSE.txt' }
  s.description      = 'DIAnalytics makes it easy to integrate Dialog Insight push system in your application.'
  s.homepage         = 'http://www.dialoginsight.com'
  s.author           = { 'Dialog Insight' => 'info@dialoginsight.com' }
  s.source           = { :git => 'https://github.com/DialogInsight/DIAnalytics_iOS.git', :tag => s.version.to_s }
  s.requires_arc     = true

  s.platform   = :ios, '9.0'
  s.ios.deployment_target = '9.0'
  s.frameworks = 'Foundation','CoreTelephony', 'SystemConfiguration', 'UIKit', 'Security', 'StoreKit'
  s.vendored_framework = "DIAnalytics.Framework"
  
  s.dependency 'AFNetworking', '~> 3.0'
  s.dependency 'Firebase/Core', '~> 6.0'
  s.dependency 'Firebase/Messaging', '~> 6.0'
  s.dependency 'Firebase/Analytics', '~> 6.0'
  


  
end

