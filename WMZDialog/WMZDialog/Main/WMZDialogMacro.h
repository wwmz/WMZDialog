//
//  WMZDialogMacro.h
//  WMZDialog
//
//  Created by wmz on 2019/6/5.
//  Copyright © 2019年 wmz. All rights reserved.
//

#ifndef WMZDialogMacro_h
#define WMZDialogMacro_h

#import <UIKit/UIKit.h>
#import "WMZDialogManage.h"
@class WMZDialogButton;

#define WMZDialogStatementAndPropSetFuncStatement(propertyModifier,className, propertyPointerType, propertyName)           \
@property(nonatomic,propertyModifier)propertyPointerType  propertyName;                                                 \
- (className * (^) (propertyPointerType propertyName)) propertyName##Set;

#define WMZDialogSetFuncImplementation(className, propertyPointerType, propertyName)                                       \
- (className * (^) (propertyPointerType propertyName))propertyName##Set{                                                \
return ^(propertyPointerType propertyName) {                                                                            \
self->_##propertyName = propertyName;                                                                                    \
return self;                                                                                                            \
};                                                                                                                      \
}

/// window
#define  DialogWindow \
({\
UIWindow *window = nil; \
if (@available(iOS 13.0, *)) \
{ \
    for (UIWindowScene* windowScene in [UIApplication sharedApplication].connectedScenes) { \
        if (windowScene.activationState == UISceneActivationStateForegroundActive) \
        { \
            for (UIWindow *currentWindow in windowScene.windows)\
            { \
                if (currentWindow.isKeyWindow)\
                { \
                    window = currentWindow; \
                    break; \
                }\
            }\
        }\
    }\
    if(!window){  \
        window =  [UIApplication sharedApplication].keyWindow; \
    }\
}\
else \
{ \
    window =  [UIApplication sharedApplication].keyWindow; \
}\
(window); \
})\

/// 取消警告
#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)


/// 提供宏定义快捷调用
#define Alert(str) \
Dialog() \
.wMessageSet(str) \
.wStart();  \


/// 提供宏定义快捷调用 auto
#define AlertAuto(str) \
Dialog() \
.wMessageSet(str) \
.wTypeSet(DialogTypeAuto) \
.wStart();  \

/// iphoneX
#define DialogIsIphoneX ({\
BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
if ([[[UIApplication sharedApplication] delegate] window].safeAreaInsets.bottom > 0.0) {\
isPhoneX = YES;\
}\
}\
isPhoneX;\
})

///暗黑模式颜色
#define DialogDarkColor(light,dark) DialogDarkOpenColor(light,dark,YES)

///暗黑模式颜色
#define DialogDarkOpenColor(light,dark,open)    \
({\
    UIColor *wMenuIndicator = nil; \
    if (!open){  \
       wMenuIndicator = light;  \
    }else{  \
        if (@available(iOS 13.0, *)) {  \
            wMenuIndicator = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) { \
            if ([traitCollection userInterfaceStyle] == UIUserInterfaceStyleLight) {  \
                return light;  \
            }else {   \
                return dark;  \
            }}];  \
        }else{  \
            wMenuIndicator = light;  \
        }   \
    }\
    (wMenuIndicator); \
})\

#define DialogScreenH [UIScreen mainScreen].bounds.size.height
#define DialogScreenW  [UIScreen mainScreen].bounds.size.width
#define DialogNaviH (([[UIApplication sharedApplication] statusBarFrame].size.height) + 44)
#define DialogStatusH [[UIApplication sharedApplication] statusBarFrame].size.height
#define DialogTabBarHeight (DialogIsIphoneX ? (49.f+34.f) : 49.f)
#define DialogSafeBottomHeight (DialogIsIphoneX ? 20.0f : 0)
#define DialogRealW(A) (A)/2.0*((DialogScreenW)/ (([UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeLeft || [UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeRight)?667:375))
#define DialogColor(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define DialogK1px (1 / UIScreen.mainScreen.scale)
#define DialogIsArray(array)  (array != nil && [array isKindOfClass:[NSArray class]])
#define DialogArrayNotEmpty(array)  (array != nil && [array isKindOfClass:[NSArray class]] && [array count] > 0)
#define DialogStrIsEmpty(text) (text == nil || ([text isKindOfClass:NSString.class] && [text length] == 0))
#define DialogStrIsNotEmpty(text) (text != nil && [text isKindOfClass:NSString.class] && [text length] >0)
#ifndef DialogWeakify
    #if DEBUG
        #if __has_feature(objc_arc)
            #define DialogWeakify(obj) autoreleasepool{} __weak __typeof__(obj) obj##Weak = obj;
        #else
            #define DialogWeakify(obj) autoreleasepool{} __block __typeof__(obj) obj##Block = obj;
        #endif
    #else
        #if __has_feature(objc_arc)
            #define DialogWeakify(obj) try{} @finally{} {} __weak __typeof__(obj) obj##Weak = obj;
        #else
            #define DialogWeakify(obj) try{} @finally{} {} __block __typeof__(obj) obj##Block = obj;
        #endif
    #endif
#endif

#ifndef DialogStrongify
    #if DEBUG
        #if __has_feature(objc_arc)
            #define DialogStrongify(obj) autoreleasepool{} __typeof__(obj) obj = obj##Weak;
        #else
            #define DialogStrongify(obj) autoreleasepool{} __typeof__(obj) obj = obj##Block;
        #endif
    #else
        #if __has_feature(objc_arc)
            #define DialogStrongify(obj) try{} @finally{} __typeof__(obj) obj = obj##Weak;
        #else
            #define DialogStrongify(obj) try{} @finally{} __typeof__(obj) obj = obj##Block;
        #endif
    #endif
#endif

typedef enum : NSUInteger{
    DialogTypeNornal = 1,           /// 默认弹窗
    DialogTypeSheet,                /// 底部弹窗
    DialogTypeAuto,                 /// 默认弹窗自动消失
    DialogTypePay,                  /// 支付密码框
    DialogTypeShare,                /// 带分享的弹窗
    DialogTypeWrite,                /// 带编辑框的弹窗
    DialogTypeSelect,               /// 带选择的弹窗
    DialogTypePickSelect,           /// 拾取器弹窗无嵌套
    DialogTypePop,                  /// 下拉列表选择弹窗
    DialogTypeDown,                 /// 带下载的弹窗
    DialogTypeMenusSelect,          /// 下拉无限级菜单弹窗
    DialogTypeAdvertisement,        /// 广告弹窗
    DialogTypeLocation,             /// 地区选择
    DialogTypeDatePicker,           /// 日期选择
    DialogTypeTabbarMenu,           /// 闲鱼 微博+号底部弹窗
    DialogTypeNaviMenu,             /// QQ顶部弹窗
    DialogTypeLoading,              /// 加载框
    DialogTypeCardPresent ,         /// ios13 present效果
    DialogTypeCalander,             /// 日历弹窗
    DialogTypeToast,                /// 吐司
    DialogTypeMyView,               /// 自定义弹窗
}DialogType;
/// pop的视图
typedef enum : NSUInteger{
    DiaPopInViewNormal,              /// 普通视图 默认
    DiaPopInViewNavi,                /// 导航栏上
    DiaPopInViewTableView,           /// tableview上
    DiaPopInViewCollectionView,      /// collectionView上
    DiaPopInViewScrollView,          /// scrollview上
}DiaPopInView;
/// pop的视图 圆角 和UIRectCorner用法一致
typedef NS_OPTIONS(NSUInteger, DialogRectCorner) {
    DialogRectCornerNone        = 0,
    DialogRectCornerTopLeft     = 1 << 0,
    DialogRectCornerTopRight    = 1 << 1,
    DialogRectCornerBottomLeft  = 1 << 2,
    DialogRectCornerBottomRight = 1 << 3,
    DialogRectCornerAllCorners  = DialogRectCornerTopLeft | DialogRectCornerTopRight | DialogRectCornerBottomLeft | DialogRectCornerBottomRight
};
///  箭头位置
typedef NS_ENUM(NSInteger, DiaDirection) {
    directionUp = 0  ,      /// 上
    directionLeft  ,        /// 左
    directionDowm  ,        /// 下
    directionright  ,       /// 右
};
/// 树状数据联动的样式
typedef enum : NSUInteger{
    ChainPickView,          /// pickview
    ChainTableView,         /// tableview
}ChainType;
/// 显示动画
typedef enum : NSUInteger{
    AninatonShowNone = 0 ,         /// 无
    AninatonCurverOn,              /// 淡入
    AninatonZoomIn,                /// 由小变大
    AninatonZoomInCombin,          /// 由大变小-小到大
    AninatonCounterclockwise,      /// 逆时针旋转
    AninatonShowTop,               /// 由下往上
    AninatonShowBottom,            /// 由上往下
    AninatonShowLeft,              /// 由右往左
    AninatonShowRight,             /// 由左往右
    AninatonShowScaleFade,         /// 先放大后恢复+透明度变化
    AninationCombineOne,           /// 组合动画缩小变大
    AninationCombineTwo,           /// 组合动画旋转
    
}DialogShowAnination;
/// 消失动画
typedef enum : NSUInteger{
    AninatonHideNone = 0 ,         /// 无
    AninatonCurverOff,             /// 淡出
    AninatonZoomOut,               /// 由大变小
    AninatonClockwise,             /// 顺时针旋转
    AninatonHideTop,               /// 由往上
    AninatonHideBottom,            /// 由往下
    AninatonHideLeft,              /// 往左
    AninatonHideRight,             /// 往右
    AninatonHideScaleFade,         /// 先放大后消失+透明度变化
    AninationHideCombineOne        /// 组合动画旋转变小
}DialogHideAnination;
/// 加载框样式
typedef enum : NSUInteger{
    LoadingStyleWait = 0,      /// 等待
    LoadingStyleRight,         /// 正确
    LoadingStyleError,         /// 错误
    LoadingStyleInfo,          /// 信息
    LoadingStyleSystem,        /// 系统
}LoadingStyle;
/// 优先级
typedef enum : NSUInteger{
    DialogLevelHigh = 999,      /// 高级
    DialogLevelMiddle = 500,    /// 中级
    DialogLevelLow = 0,         /// 低级
}DialogLevel;
/// Toast弹出位置
typedef enum : NSUInteger{
    DialogToastTop = 0,        /// 顶部
    DialogToastBottom,         /// 底部
 }DialogToastPosition;
/// 点击
typedef void (^DialogClickBlock)(id anyID,id otherData);
/// 多列表点击
typedef void (^DialogMenuClickBlock)(id anyID,NSInteger section,NSInteger row);
/// 带tableview的点击
typedef void (^DialogTableClickBlock)(id anyID,NSIndexPath *path,DialogType type);
/// UITableViewCell点击的block
typedef void (^DiaLogCellSelectlock)(NSIndexPath *indexPath,UITableView* tableView,id model);
/// UITableViewCell的block
typedef UITableViewCell* (^DiaLogCustomCellBlock)(NSIndexPath *indexPath,UITableView* tableView,id model,BOOL isSelected);
/// collectionCell的block
typedef UICollectionViewCell* (^DiaLogCollectionCellBlock)(NSIndexPath *indexPath,UICollectionView* collection,id model);
/// collectionCell的点击方法
typedef void (^DiaLogCollectionClickBlock)(NSIndexPath *indexPath,UICollectionView* collection,id model);
/// 自定义弹窗
typedef UIView* (^DiaLogMyViewCallBlock)(UIView* mainView);
/// 自定义presrnt
typedef UIView* (^DiaLogPresentCallBlock)(UIView* mainView,UITableView *tableView);
/// 自定义View
typedef void (^DialogCustomMainViewBlock)(UIView * mainView);

typedef void (^DialogCustomTitle)(UILabel * titleLa);

typedef void (^DialogCustomMessage)(UILabel * messageLa);

typedef void (^DialogCustomOKBtn)(WMZDialogButton * okBtn);

typedef void (^DialogCustomCancelBtn)(WMZDialogButton * cancelBtn);

typedef void (^DialogCustomCloseBtn)(WMZDialogButton * closeBtn);

typedef void (^DialogCustomTextView)(UITextView * textView);

typedef void (^DialogCustomImageView)(UIImageView * imageView);

typedef void (^DialogCustomTableView)(UITableView * tableView);

typedef void (^DialogCustomMainShadomLayer)(CALayer *shadom);
#endif /* WMZDialogMacro_h */
