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

///弹窗类型
typedef enum : NSUInteger{
    /// 默认弹窗
    DialogTypeNornal = 1,
    ///底部弹窗
    DialogTypeSheet,
    /// 默认弹窗自动消失
    DialogTypeAuto,
    /// 支付密码框
    DialogTypePay,
    /// 带分享的弹窗
    DialogTypeShare,
    /// 带编辑框的弹窗
    DialogTypeWrite,
    /// 带选择的弹窗
    DialogTypeSelect,
    /// 拾取器弹窗无嵌套
    DialogTypePickSelect,
    /// 下拉列表选择弹窗
    DialogTypePop,
    /// 带下载的弹窗
    DialogTypeDown,
    /// 下拉无限级菜单弹窗
    DialogTypeMenusSelect,
    /// 广告弹窗
    DialogTypeAdvertisement,
    /// 地区选择
    DialogTypeLocation,
    /// 日期选择
    DialogTypeDatePicker,
    /// 底部弹窗
    DialogTypeTabbarMenu,
    /// 顶部弹窗
    DialogTypeNaviMenu,
    /// 加载框
    DialogTypeLoading,
    /// ios13 present效果
    DialogTypeCardPresent ,
    /// 日历弹窗
    DialogTypeCalander,
    /// 吐司
    DialogTypeToast,
    /// 自定义弹窗
    DialogTypeMyView,
}DialogType;

/// pop的视图
typedef enum : NSUInteger{
    /// 普通视图 默认
    DiaPopInViewNormal,
    /// 导航栏上
    DiaPopInViewNavi,
    /// tableview上
    DiaPopInViewTableView,
    /// collectionView上
    DiaPopInViewCollectionView,
    /// scrollview上
    DiaPopInViewScrollView,
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
    /// 上
    directionUp = 0  ,
    /// 左
    directionLeft  ,
    /// 下
    directionDowm  ,
    /// 右
    directionright  ,
};

/// 树状数据联动的样式
typedef enum : NSUInteger{
    /// pickview
    ChainPickView,
    /// tableview
    ChainTableView,
}ChainType;

/// 显示动画
typedef enum : NSUInteger{
    /// 无
    AninatonShowNone = 0 ,
    /// 淡入
    AninatonCurverOn,
    /// 由大变小-小到大
    AninatonZoomIn,
    /// 由大变小-小到大
    AninatonZoomInCombin,
    /// 逆时针旋转
    AninatonCounterclockwise,
    /// 由下往上
    AninatonShowTop,
    /// 由上往下
    AninatonShowBottom,
    /// 由右往左
    AninatonShowLeft,
    /// 由左往右
    AninatonShowRight,
    /// 先放大后恢复+透明度变化
    AninatonShowScaleFade,
    /// 组合动画缩小变大
    AninationCombineOne,
    /// 组合动画旋转
    AninationCombineTwo,
    
}DialogShowAnination;

/// 消失动画
typedef enum : NSUInteger{
    /// 无
    AninatonHideNone = 0 ,
    /// 淡出
    AninatonCurverOff,
    /// 由大变小
    AninatonZoomOut,
    /// 顺时针旋转
    AninatonClockwise,
    /// 由往上
    AninatonHideTop,
    /// 由往下
    AninatonHideBottom,
    /// 往左
    AninatonHideLeft,
    /// 往右
    AninatonHideRight,
    /// 先放大后消失+透明度变化
    AninatonHideScaleFade,
    /// 组合动画旋转变小
    AninationHideCombineOne
}DialogHideAnination;

/// 加载框样式
typedef enum : NSUInteger{
    /// 错误
    LoadingStyleWait = 0,
    /// 正确
    LoadingStyleRight,
    /// 错误
    LoadingStyleError,
    /// 信息
    LoadingStyleInfo,
    /// 系统
    LoadingStyleSystem,
}LoadingStyle;

/// 优先级
typedef enum : NSUInteger{
    /// 高级
    DialogLevelHigh = 999,
    /// 中级
    DialogLevelMiddle = 500,
    /// 低级
    DialogLevelLow = 0,
}DialogLevel;

/// Toast弹出位置
typedef enum : NSUInteger{
    /// 顶部
    DialogToastTop = 0,
    /// 底部
    DialogToastBottom,
 }DialogToastPosition;

/// Pop弹出视图样式
typedef enum : NSUInteger{
    /// 默认tableView列表样式
    DialogPopTypeTable = 0,
    /// 行列样式
    DialogPopTypeShare,
    /// 自定义样式
    DialogPopTypeCustom,
 }DialogPopType;

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
/// 自定义pop内容
typedef UIView* (^DialogPopCustomBlock)(void);
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
