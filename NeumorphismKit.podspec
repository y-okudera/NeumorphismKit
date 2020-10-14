Pod::Spec.new do |s|
  s.name = 'NeumorphismKit'
  s.version = '1.0.0'
  s.license = { :type => 'MIT', :file => 'LICENSE' }
  s.summary = 'Neumorphism framework for UIKit.'
  s.homepage = 'https://github.com/y-okudera/NeumorphismKit'
  s.author = { 'YukiOkudera' => 'appledev.yuoku@gmail.com' }
  s.source = { :git => 'https://github.com/y-okudera/NeumorphismKit.git', :tag => s.version.to_s }
  s.ios.deployment_target = '12.0'
  s.swift_versions = ['5.1', '5.2']
  s.source_files = 'Sources/**/*.{h,m,swift}'
end