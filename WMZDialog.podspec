Pod::Spec.new do |s|

  s.name         = "WMZDialog"
  s.version      = "1.4.13"
  s.platform     = :ios, "9.0"
  s.requires_arc = true
  s.frameworks   = 'UIKit'
  s.license      = { :type => 'MIT' }
  s.summary      = "功能最多样式最多的弹窗，支持自定义视图,链式编程调用"
  s.description  = <<-DESC 
                   普通弹窗 选择弹窗 时间选择弹窗 地区选择弹窗等
                   DESC
  s.homepage     = "https://github.com/wwmz/WMZDialog"
  s.author       = { "wmz" => "925457662@qq.com" }
  s.source       = { :git => "https://github.com/wwmz/WMZDialog.git", :tag => s.version.to_s }
  s.source_files = "WMZDialog/WMZDialog/**/*.{h,m}"
  s.resources     = "WMZDialog/WMZDialog/WMZDialog.bundle"
end

