//
//  WMZDialogAnimation.h
//  WMZDialog
//
//  Created by wmz on 2019/9/11.
//  Copyright © 2019 wmz. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 * 动画完成
 */
typedef void (^animalBlock)(void);
NS_ASSUME_NONNULL_BEGIN

@interface WMZDialogAnimation : NSObject
//抖动
void shakerAnimation (UIView *view ,NSTimeInterval duration,float height);
//淡入
void curverOnAnimation (UIView *view ,NSTimeInterval duration);
//淡出
void curverOffAnimation (UIView *view ,NSTimeInterval duration);
//由小变大
void zoomInAnimation (UIView *view ,NSTimeInterval duration);
//由大变小
void zoomOutAnimation (UIView *view ,NSTimeInterval duration);
//逆时针
void rotationClockwiseAnimation(UIView* view,NSTimeInterval duration);
//顺时针
void rotationCounterclockwiseAnimation(UIView* view,NSTimeInterval duration);
//出现组合动画 样式1
void combineShowOneAnimation(UIView* view,NSTimeInterval duration);
//出现组合动画 样式2
void combineShowTwoAnimation(UIView* view,NSTimeInterval duration);
//消失组合动画 样式1
void combineHideOneAnimation(UIView* view,NSTimeInterval duration);
/*
 *阻尼动画 出现的弹簧运动
 @prarm subView 带有子视图的数组
 @prarm kColumnCount 列
 @prarm kSectionCount 行
 @prarm vMarginY 上下间距
 @prarm vSpacingY item之间的Y轴间距
 @prarm vMarginX 左右间距
 @prarm vSpacingX item之间的X轴间距
 @prarm hideFirstPageView 是否做弹簧动画
 @prarm block 动画完成回调
 */
void springShowAnimation(UIScrollView *scrollView,NSTimeInterval duration,NSArray *subView,NSInteger kColumnCount,NSInteger kSectionCount,CGFloat vMarginY,CGFloat vSpacingY,CGFloat vMarginX,CGFloat vSpacingX,bool hideFirstPageView,animalBlock block);
//阻尼动画 消失的弹簧运动
void springHideAnimation(UIScrollView *scrollView,NSTimeInterval duration,NSArray *subView,animalBlock block);
//等待动画
void waitAnimation(UIView* view,NSTimeInterval duration,UIColor *color,CGFloat width);
//正确动画
void rightAnimation(UIView* view,NSTimeInterval duration,UIColor *color,CGFloat width);
//错误动画
void errorAnimation(UIView* view,NSTimeInterval duration,UIColor *color,CGFloat width);
//加载
void loadingAnimation(UIView* view,NSTimeInterval duration,UIColor *color,CGFloat width);
@end

NS_ASSUME_NONNULL_END
