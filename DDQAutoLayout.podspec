Pod::Spec.new do |s|

  s.name         = "DDQAutoLayout"
  s.version      = "1.0.3"
  s.ios.deployment_target = '8.0'
  s.summary      = "frame布局时的自适应工具"
  s.homepage     = "https://github.com/MyNameDDQ/DDQAutoLayout"
  s.license      = "MIT"
  s.author       = { "MyNameDDQ" => "wjddq@qq.com" }
  s.source       = { :git => 'https://github.com/MyNameDDQ/DDQAutoLayout.git', :tag => s.version}
  s.requires_arc = true
  s.source_files = '*.{h,m}'
 
end
