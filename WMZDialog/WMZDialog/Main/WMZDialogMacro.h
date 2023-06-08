//
//  WMZDialogMacro.h
//  WMZDialog
//
//  Created by wmz on 2019/6/5.
//  Copyright © 2019年 wmz. All rights reserved.
//

#ifndef WMZDialogMacro_h
#define WMZDialogMacro_h

#import "WMZDialogManage.h"
@class WMZDialogButton,WMZDialogParam;

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
#define DialogSafeBottomHeight (DialogIsIphoneX ? 34.0f : 0)
#define DialogRealW(A) (A/2.0)
#define DialogColor(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define DialogK1px (1 / UIScreen.mainScreen.scale)
#define DialogDisappealTime 1.4444444f

#define DialogSize CGSizeMake(DialogRealW(500),DialogRealW(400))

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

///cell视图内容对齐方向
typedef enum : NSUInteger{
    /// 左对其
    DialogCellAlignLeft = 0,
    /// 居中对齐
    DialogCellAlignCenter,
    /// 右对齐
    DialogCellAlignRight,
 }DialogCellAlignType;

/// 地区选择格式
typedef enum : NSUInteger{
    /// 省
    DialogLocationPro = 1,
    /// 省市
    DialogLocationProAndCity = 2,
    /// 省市区
    DialogLocationProAndCityAndDis = 3,
 }DialogLocationType;

/// 点击
typedef void (^DialogClickBlock)(id _Nullable anyID,id _Nullable otherData);
/// 多列表点击
typedef void (^DialogMenuClickBlock)(id _Nullable anyID,NSInteger section,NSInteger row);
/// 带tableview的点击
typedef void (^DialogTableClickBlock)(id _Nullable anyID,NSIndexPath* _Nullable path,DialogType type);
/// UITableViewCell点击的block
typedef void (^DiaLogCellSelectlock)(NSIndexPath* _Nullable indexPath,UITableView* _Nullable tableView,id _Nullable model);
/// UITableViewCell的block
typedef UITableViewCell* _Nullable(^DiaLogCustomCellBlock)(NSIndexPath* _Nullable indexPath,UITableView* _Nullable tableView,id _Nullable model,BOOL isSelected);
/// collectionCell的block
typedef UICollectionViewCell* _Nullable (^DiaLogCollectionCellBlock)(NSIndexPath* _Nullable indexPath,UICollectionView* _Nullable collection,id _Nullable model);
/// collectionCell的点击方法
typedef void (^DiaLogCollectionClickBlock)(NSIndexPath* _Nullable indexPath,UICollectionView* _Nullable collection,id _Nullable model);
/// 自定义弹窗
typedef UIView* _Nullable (^DiaLogMyViewCallBlock)(UIView* _Nullable mainView);
/// 自定义pop内容
typedef UIView* _Nullable (^DialogPopCustomBlock)(void);
/// 自定义presrnt
typedef UIView* _Nullable (^DiaLogPresentCallBlock)(UIView* _Nullable mainView,UITableView* _Nullable tableView);
/// 自定义View
typedef void (^DialogCustomMainViewBlock)(UIView* _Nullable mainView);

typedef void (^DialogCustomTitle)(UILabel* _Nullable titleLa);

typedef void (^DialogCustomMessage)(UILabel* _Nullable messageLa);

typedef void (^DialogCustomOKBtn)(WMZDialogButton* _Nullable okBtn);

typedef void (^DialogCustomCancelBtn)(WMZDialogButton* _Nullable cancelBtn);

typedef void (^DialogCustomCloseBtn)(WMZDialogButton* _Nullable closeBtn);

typedef void (^DialogCustomTextView)(UITextView* _Nullable textView);

typedef void (^DialogCustomImageView)(UIImageView* _Nullable imageView);

typedef void (^DialogCustomTableView)(UITableView* _Nullable tableView);

typedef void (^DialogCustomMainShadomLayer)(CALayer* _Nullable shadom);

typedef void (^AnimalBlock)(void);

typedef void (^DialogCustomAnimal)(UIView* _Nullable mainView,AnimalBlock _Nullable showBlock);

typedef void (^DialogCustomShareView)(UIScrollView* _Nullable shareView);
#endif /* WMZDialogMacro_h */
