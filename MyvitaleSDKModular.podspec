#
# Be sure to run `pod lib lint VitaleSDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MyvitaleSDKModular'
  s.version          = '1.0.2'
  s.summary          = 'Intelligent, automatic, comprehensive, adaptive Training System'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.homepage         = 'https://www.myvitale.com/'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'MyVitale' => 'miguel.munoz@myvitale.com' }
  s.source           = { :git => 'https://github.com/MyVitale/ios_sdk_myvitale_modular.git', :branch => "main" }
  s.ios.deployment_target = '13.0'
  s.vendored_frameworks = ['TrainingSDK.xcframework', 'VitaleHealthSDK.xcframework', 'NutritionIASDK.xcframework']
  s.swift_version = "5.0"
  s.swift_versions = ['4.0', '4.2', '5.0']
  s.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  s.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  s.xcconfig = { 'BUILD_LIBRARY_FOR_DISTRIBUTION' => 'YES' }

end
