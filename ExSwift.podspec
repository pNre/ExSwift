Pod::Spec.new do |s|
  s.name         = "ExSwift"
  s.version      = "0.1.0"
  s.summary      = "JavaScript (Lo-Dash, Underscore) & Ruby inspired set of Swift extensions for standard types and classes."

  s.description  = <<-DESC
                   JavaScript (Lo-Dash, Underscore) & Ruby inspired set of Swift extensions for standard types and classes.
                   DESC

  s.homepage     = "https://github.com/pNre/ExSwift"
  s.license      = { :type => 'BSD', :file => 'LICENSE' }

  s.author       = { "pNre" => "mail@pnre.co" }
  s.source       = { :git => "https://github.com/pNre/ExSwift.git", :tag => "0.1.0" }

  s.source_files = 'ExSwift/*.{h,swift}'
  s.frameworks   = 'Foundation'
  s.requires_arc = true
end
