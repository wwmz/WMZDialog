Pod::Spec.new do |s|

  s.name         = "WMZDialog"
  s.version      = "1.1.2"
  s.platform     = :ios, "8.0"
  s.requires_arc = true
  s.frameworks   = 'UIKit'
  s.license      = { :type => 'MIT' }
  s.summary      = "功能最多样式最多的弹窗，支持自定义视图,链式编程调用"
  s.description  = <<-DESC 
                   普通弹窗 选择弹窗 时间选择弹窗 地区选择弹窗等
                   注：Building Settings设置CLANG_WARN_OBJC_IMPLICIT_RETAIN_SELF为NO可以消除链  式编程的警告
                   DESC
  s.homepage     = "https://github.com/wwmz/WMZDialog"
  s.author       = { "wmz" => "925457662@qq.com" }
  s.source       = { :git => "https://github.com/wwmz/WMZDialog.git", :tag => s.version.to_s }
  s.source_files = "WMZDialog/WMZDialog/**/*.{h,m}"
  s.resources     = "WMZDialog/WMZDialog/WMZDialog.bundle"
end

