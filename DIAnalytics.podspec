#
# Be sure to run `pod lib lint Flurry-iOS-SDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DIAnalytics'
  s.version          = '1.0.0'
  s.summary          = 'DIAnalytics for iOS'
  s.license          = { :type => 'Commercial', :file => 'LICENSE.txt' }
  s.description      = 'Cool Description'
  s.homepage = 'https://nomadesolutions.com'
  s.author           = { 'Nomade' => 'inf@nomadesolutions.com' }
  s.source           = { :git => 'https://github.com/sacot41/DITest.git', :tag => s.version.to_s }
  s.requires_arc = false

  s.platform   = :ios, '8.0'
  s.ios.deployment_target = '8.0'
  s.frameworks = 'Foundation', 'SystemConfiguration', 'UIKit', 'Security', 'StoreKit','CoreTelephony', 'UserNotifications','MobileCoreServices'
  
  s.vendored_framework = "DIAnalytics.Framework"
  
  s.dependency 'AFNetworking', '~> 3.0'
  s.dependency 'Firebase/Core', '~> 3.10.0'
  s.dependency 'Firebase/Messaging', '~> 3.10.0'
  s.dependency 'Firebase/Analytics', '~> 3.10.0'
end

