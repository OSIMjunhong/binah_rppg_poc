#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint binah_flutter_sdk.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
    s.name             = 'binah_flutter_sdk'
    s.version          = '5.4.1'
    s.summary          = 'A new flutter plugin project.'
    s.description      = <<-DESC
  A new flutter plugin project.
                         DESC
    s.homepage         = 'http://binah.ai'
    s.license          = { :file => '../LICENSE' }
    s.author           = { 'Binah.ai' => 'https://binah.zendesk.com/hc/en-us/requests/new' }
    s.source           = { :path => '.' }
    s.source_files = 'Classes/**/*'
    s.public_header_files = 'Classes/**/*.h'
    s.dependency 'Flutter'
    s.platform = :ios, '14.0'
    s.ios.deployment_target = '14.0'
    s.swift_versions = ['5.0']

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.preserve_paths = 'BinahAI.framework'
  s.xcconfig = { 'OTHER_LDFLAGS' => '-framework BinahAI' }
  s.vendored_frameworks = "BinahAI.framework"
end
