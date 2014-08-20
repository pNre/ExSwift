Pod::Spec.new do |s|
  s.name         = "ExSwift"
  s.version      = "0.1.9"
  s.summary      = "Set of Swift extensions for standard types and classes."
  s.homepage     = "https://github.com/pNre/ExSwift"
  s.license      = { :type => 'BSD', :file => 'LICENSE' }
  s.author       = { "pNre" => "mail@pnre.co" }
  s.source       = { :git => "https://github.com/pNre/ExSwift.git", :tag => "0.1.9" }
  s.source_files = 'ExSwift/*.{h,swift}'
  s.frameworks   = 'Foundation'
  s.requires_arc = true
end
