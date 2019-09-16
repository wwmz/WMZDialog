//
//  WMZTagsTool.h
//  WMZTags
//
//  Created by wmz on 2019/9/3.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "WMZTagConfig.h"
NS_ASSUME_NONNULL_BEGIN

@interface WMZTagsTool : NSObject
//文字转图片
+ (UIImage *)imageWithString:(NSString *)string
                        font:(UIFont *)font
                       width:(CGFloat)width
               textAlignment:(NSTextAlignment)textAlignment
                   backColor:(UIColor*)backGroundcolor
                       color:(UIColor*)color;

//获取当前VC
+ (UIViewController *)getCurrentVC;

//16进制颜色
+ (UIColor *)stringTOColor:(NSString *)str;
@end

NS_ASSUME_NONNULL_END
