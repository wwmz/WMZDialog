//
//  WMZDialogTool.h
//  WMZDialog
//
//  Created by wmz on 2019/6/5.
//  Copyright © 2019年 wmz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
/*
* pop的视图 圆角 和UIRectCorner用法一致
*/
typedef NS_OPTIONS(NSUInteger, DialogRectCorner) {
    DialogRectCornerNone        = 0,
    DialogRectCornerTopLeft     = 1 << 0,
    DialogRectCornerTopRight    = 1 << 1,
    DialogRectCornerBottomLeft  = 1 << 2,
    DialogRectCornerBottomRight = 1 << 3,
    DialogRectCornerAllCorners  = DialogRectCornerTopLeft | DialogRectCornerTopRight | DialogRectCornerBottomLeft | DialogRectCornerBottomRight
};


/** 箭头位置 */
typedef NS_ENUM(NSInteger, DiaDirection) {
    directionUp     ,
    directionLeft  ,
    directionDowm  ,
    directionright  ,
};

NS_ASSUME_NONNULL_BEGIN

@interface WMZDialogTool : NSObject

//获取当前VC
+ (UIViewController *)getCurrentVC;
//16进制颜色
+ (UIColor *)stringTOColor:(NSString *)str;
//获取文本size
+ (CGSize)sizeForTextView:(CGSize)constraint text: (NSString *)text font:(CGFloat)font;
//设置圆角 单边
+(void)setView:(UIView*)view radio:(CGSize)size roundingCorners:(UIRectCorner)rectCorner;
//传入 秒  得到 xx:xx:xx
+ (NSString *)getMMSSFromSS:(NSString *)totalTime;
//判断颜色是否相等
+ (BOOL)isEqualToColor:(UIColor*)colorA anotherColor:(UIColor*)colorB;
@end

@interface UIView (DialogPop)
/**
 给view添加一个带箭头的边框
 
 @param direction 箭头朝向
 @param offset 箭头的坐标
 @param corner 圆角的位置
 @param width 箭头的宽度
 @param height 箭头的高度
 @param cornerRadius 圆角半径，<=0不设圆角
 @param borderWidth 边框宽度
 @param borderColor 边框颜色
 */
- (void)addArrowBorderAt:(DiaDirection)direction
        offset:(CGFloat)offset
        rectCorner:(DialogRectCorner)corner
        width:(CGFloat)width
        height:(CGFloat)height
        cornerRadius:(CGFloat)cornerRadius
        borderWidth:(CGFloat)borderWidth
        borderColor:(UIColor *)borderColor;
@end

NS_ASSUME_NONNULL_END
