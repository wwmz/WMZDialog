//
//  WMZDialogTool.h
//  WMZDialog
//
//  Created by wmz on 2019/6/5.
//  Copyright © 2019年 wmz. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WMZDialogTool : NSObject

//获取当前VC
+ (UIViewController *)getCurrentVC;
//16进制颜色
+ (UIColor *)stringTOColor:(NSString *)str;
//获取文本高度
+ (float)heightForTextView:(CGSize)constraint WithText:(NSString *)strText WithFont:(CGFloat)font;
//设置圆角 单边
+(void)setView:(UIView*)view Radii:(CGSize)size RoundingCorners:(UIRectCorner)rectCorner;
//传入 秒  得到 xx:xx:xx
+ (NSString *)getMMSSFromSS:(NSString *)totalTime;
@end

NS_ASSUME_NONNULL_END
