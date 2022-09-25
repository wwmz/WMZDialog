//
//  WMZDialogUntils.h
//  WMZDialog
//
//  Created by wmz on 2019/6/5.
//  Copyright © 2019年 wmz. All rights reserved.
//
#import <objc/runtime.h>
#import "WMZDialogMacro.h"

NS_ASSUME_NONNULL_BEGIN

@interface WMZDialogUntils : NSObject
/// 获取当前VC
+ (UIViewController *)getCurrentVC;
/// 获取文本size
/// @param constraint size
/// @param text 内容
/// @param font font
+ (CGSize)sizeForTextView:(CGSize)constraint
                     text:(NSString *)text
                     font:(UIFont*)font;
/// 设置UIView圆角
/// @param view view
/// @param radio 圆角值
/// @param rectCorner UIRectCorner
+ (void)setCornerView:(UIView*)view
                radio:(CGSize)radio
           rectCorner:(UIRectCorner)rectCorner;


/// 获取bundle
+ (NSBundle*)getMainBundle;

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
 @param angleRadio 三角形区域圆角弧度
 */
- (void)addArrowBorderAt:(DiaDirection)direction
        offset:(CGFloat)offset
        rectCorner:(DialogRectCorner)corner
        width:(CGFloat)width
        height:(CGFloat)height
        cornerRadius:(CGFloat)cornerRadius
        borderWidth:(CGFloat)borderWidth
        borderColor:(UIColor *)borderColor
        angleRadio:(CGFloat)angleRadio;
@end

@interface WMZDialogTableView : UITableView
///wOpenScrollClose
@property (nonatomic, assign) BOOL wOpenScrollClose;
///wCardPresent
@property (nonatomic, assign) BOOL wCardPresent;
@end

@interface WMZDialogButton : UIButton
@end

typedef void (^ShareViewSelect)(NSInteger index,id anyId);

@interface WMZDialogShareView : UIView
///block
@property (nonatomic,   copy) ShareViewSelect block;
///imageIV
@property (nonatomic, strong) UIImageView *imageIV;
///titleLB
@property (nonatomic, strong) UILabel *titleLB;
///model
@property (nonatomic, strong) id model;
///changeFrame
@property (nonatomic, assign) BOOL changeFrame;
///初始化方法
- (instancetype)initWithText:(NSString*)text
                       image:(NSString*)image
                       block:(ShareViewSelect)block
                         tag:(NSInteger)tag;

@end

@interface NSDate (WMZCalendarDate)
///  获取日
+ (NSInteger)day:(NSDate *)date;
/// 获取月
+ (NSInteger)month:(NSDate *)date;
/// 获取年
+ (NSInteger)year:(NSDate *)date;
/// 获取当月第一天周几
+ (NSInteger)firstWeekdayInThisMonth:(NSDate *)date;
///获取当前月有多少天
+ (NSInteger)totaldaysInMonth:(NSDate *)date;
/// 获取date农历信息
+ (NSDictionary*)getChineseCalendarWithDate:(NSDate*)dateTemp Year:(NSInteger)myYear Month:(NSInteger)myMonth Day:(NSInteger)myDay;
/// 是否属于同一天判断
+ (BOOL)isInSameDay:(NSDate*)date1 time2:(NSDate*)date2;
/// 比较两个时间的大小
+ (int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay;

@end

NS_ASSUME_NONNULL_END
