Pod::Spec.new do |s|

s.name             = "ZMWIOSUtils"

s.version          = "1.0.0"

s.summary          = "iOS项目中常用的通用的类目、封装的方法等 ---- 不断更新中..."

s.description      = <<-DESC
 "iOS项目中常用的通用的类目、封装的方法等 ---- 不断更新中..."
DESC

s.homepage         = "https://github.com/zjjzmw1/ZMWIOSUtils"
s.license          = "MIT"
s.author           = { "张明炜" => "zjjzmw1@163.com" }

s.source           = { :git => "https://github.com/zjjzmw1/ZMWIOSUtils.git", :tag => s.version.to_s }
s.platform     = :ios, "7.0"

#s.requires_arc = true
s.requires_arc = false

s.source_files = "Classes/*"

s.frameworks = "Foundation", "CoreGraphics", "UIKit"

end