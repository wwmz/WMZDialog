Pod::Spec.new do |s|

  s.name         = "WMZDialog"
  s.version      = "1.0.0"
  s.license      = "Copyright (c) 2019年 WMZ. All rights reserved."
  s.summary      = "功能最多样式最多的弹窗，支持自定义视图,链式编程调用"
  s.description  = <<-DESC 
                   普通弹窗 选择弹窗 时间选择弹窗 地区选择弹窗等
                   注：Building Settings设置CLANG_WARN_OBJC_IMPLICIT_RETAIN_SELF为NO可以消除链  式编程的警告
                   DESC
  s.homepage     = "https://github.com/wwmz/WMZDialog"
  s.license      = "MIT"
  s.author       = { "wmz" => "925457662@qq.com" }
  s.platform     = :ios
  s.source       = { :git => "https://github.com/wwmz/WMZDialog.git", :tag => "1.0.0" }
  s.source_files = "WMZDialog/WMZDialog/**/*"
  s.framework = 'UIKit'
  s.user_target_xcconfig = { 'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES' }
  s.dependency 'Masonry'
  s.dependency 'WMZTags'
end

