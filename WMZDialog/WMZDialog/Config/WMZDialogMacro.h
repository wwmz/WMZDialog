//
//  WMZDialogMacro.h
//  WMZDialog
//
//  Created by wmz on 2019/6/5.
//  Copyright © 2019年 wmz. All rights reserved.
//

#ifndef WMZDialogMacro_h
#define WMZDialogMacro_h
//implicit retain of 'self'改为NO
#define WMZDialogStatementAndPropSetFuncStatement(propertyModifier,className, propertyPointerType, propertyName)           \
@property(nonatomic,propertyModifier)propertyPointerType  propertyName;                                                 \
- (className * (^) (propertyPointerType propertyName)) propertyName##Set;

#define WMZDialogSetFuncImplementation(className, propertyPointerType, propertyName)                                       \
- (className * (^) (propertyPointerType propertyName))propertyName##Set{                                                \
return ^(propertyPointerType propertyName) {                                                                            \
_##propertyName = propertyName;                                                                                         \
return self;                                                                                                            \
};                                                                                                                      \
}

#define isIphoneX ({\
BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
if ([[[UIApplication sharedApplication] delegate] window].safeAreaInsets.bottom > 0.0) {\
isPhoneX = YES;\
}\
}\
isPhoneX;\
})

#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)


//提供宏定义快捷调用
#define Alert(str) \
Dialog() \
.wMessageSet(str) \
.wStart();  \



#define Device_Dialog_Height [UIScreen mainScreen].bounds.size.height
#define Device_Dialog_Width  [UIScreen mainScreen].bounds.size.width
#define NavigationBar_Dialog_Height (([[UIApplication sharedApplication] statusBarFrame].size.height) + 44)
#define Dialog_GetWNum(A)   (A)/2.0*(Device_Dialog_Width/375)
#define Dialog_GetHNum(B)   (B)/2.0*(Device_Dialog_Height/667)
#define DialogColor(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define DialogK1px (1 / UIScreen.mainScreen.scale)

#define DialogWeakSelf(obj) __weak typeof(obj) weakObject = obj;
#define DialogStrongSelf(obj) __strong typeof(obj) strongObject = weakObject;


typedef enum : NSUInteger{
    DialogTypeNornal = 1,           //默认弹窗
    DialogTypeSheet,                //底部弹窗
    DialogTypeAuto,                 //默认弹窗自动消失
    DialogTypePay,                  //支付密码框
    DialogTypeShare,                //带分享的弹窗
    DialogTypeWrite,                //带编辑框的弹窗
    DialogTypeSelect,               //带选择的弹窗
    DialogTypePickSelect,           //拾取器弹窗无嵌套
    DialogTypeTime,                 //带倒计时的弹窗
    DialogTypePop,                  //下拉列表选择弹窗
    DialogTypeDown,                 //带下载的弹窗
    DialogTypeMenusSelect,          //下拉无限级菜单弹窗
    DialogTypeAdvertisement,        //广告弹窗
    DialogTypeLocation,             //地区选择
    DialogTypeDatePicker,           //日期选择
    DialogTypeTabbarMenu,           //闲鱼 微博+号底部弹窗
    DialogTypeNaviMenu,             //QQ顶部弹窗
    DialogTypeLoading,              //加载框
    DialogTypeBuyCar ,              //购物车弹窗  可自行导入WMZTags
    DialogTypeMyView,               //自定义弹窗

}DialogType;

/*
 * type为pop的方向
 */
typedef enum : NSUInteger{
    directionUp,
    directionLeft,
    directionDowm,
    directionright,
    
}DiaDirection;

/*
 * 树状数据联动的样式 tableview/pickview显示
 */
typedef enum : NSUInteger{
    ChainPickView,
    ChainTableView,
}ChainType;


/*
 * 显示动画
 */
typedef enum : NSUInteger{
    AninatonShowNone = 0 ,         //无
//    AninatonShaker ,               //抖动
    AninatonCurverOn,              //淡入
    AninatonZoomIn,                //由小变大
    AninatonCounterclockwise,      //逆时针旋转
    AninationCombineOne,           //组合动画缩小变大
    AninationCombineTwo,           //组合动画旋转
    
}DialogShowAnination;

/*
 * 消失动画
 */
typedef enum : NSUInteger{
    AninatonHideNone = 0 ,          //无
    AninatonCurverOff,             //淡出
    AninatonZoomOut,               //由大变小
    AninatonClockwise,             //顺时针旋转
    AninationHideCombineOne        //组合动画旋转变小
}DialogHideAnination;

/*
 * 加载框样式
 */
typedef enum : NSUInteger{
    LoadingStyleWait = 0,      //等待
    LoadingStyleRight,         //正确
    LoadingStyleError,         //错误
}LoadingStyle;

/*
 * 点击
 */
typedef void (^DialogClickBlock)(id anyID,id otherData);

/*
 * 多列表点击
 */
typedef void (^DialogMenuClickBlock)(id anyID,NSInteger section,NSInteger row);

/*
 * 带tableview的点击
 */
typedef void (^DialogTableClickBlock)(id anyID,NSIndexPath *path,DialogType type);

/*
 * cell的block
 */
typedef UITableViewCell* (^diaLogCellCallBlock)(NSIndexPath *indexPath,UITableView* tableView,id model);

/*
 * 自定义弹窗
 */
typedef UIView* (^diaLogMyViewCallBlock)(UIView* mainView);

#endif /* WMZDialogMacro_h */
