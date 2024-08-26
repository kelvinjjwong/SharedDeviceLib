Pod::Spec.new do |s|
  s.name        = "SharedDeviceLib"
  s.version     = "1.0.1"
  s.summary     = "A shared library for device info."
  s.homepage    = "https://github.com/kelvinjjwong/SharedDeviceLib"
  s.license     = { :type => "MIT" }
  s.authors     = { "kelvinjjwong" => "kelvinjjwong@outlook.com" }

  s.requires_arc = true
  s.swift_version = "5.0"
  s.osx.deployment_target = "14.0"
  s.source   = { :git => "https://github.com/kelvinjjwong/SharedDeviceLib.git", :tag => s.version }
  s.source_files = "Sources/SharedDeviceLib/**/*.swift"
end
