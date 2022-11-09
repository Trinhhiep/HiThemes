#
# Be sure to run `pod lib lint HiThemes.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |spec|

  spec.name         = "HiThemes"
  spec.version      = "0.0.1"
  spec.summary      = "A short description of HiThemes."
  spec.description  = <<-DESC
  TODO: Add long description of the pod here.
                         DESC

  spec.homepage     = "https://github.com/HiepTQ5/HiThemes"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author             = { "HiepTQ5" => "Hieptq5@fpt.com.vn" }
  spec.source       = { :git => "https://github.com/HiepTQ5/HiThemes/HiThemes.xcframework.zip", :tag => "#{spec.version}" }
  spec.vendored_frameworks = "HiThemes.xcframework"
  spec.ios.deployment_target = '11.0'
  spec.swift_version = '5.0'
end
