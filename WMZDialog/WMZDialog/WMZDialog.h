//
//  WMZDialog.h
//  WMZDialog
//
//  Created by wmz on 2019/6/5.
//  Copyright © 2019年 wmz. All rights reserved.
//

#import "WMZDiaLogBase.h"
#define pickViewCount 100
NS_ASSUME_NONNULL_BEGIN

@interface WMZDialog : WMZDiaLogBase<UITableViewDataSource,UITableViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource>


WMZDialog * Dialog(void);
@property(nonatomic,copy,readonly) WMZDialog *(^wStart)(void);

/*=========================================Attributes==========================================*/
WMZDialogStatementAndPropSetFuncStatement(strong, WMZDialog, UIViewController*,        wParentVC)
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, UIModalTransitionStyle,   wStyle)
WMZDialogStatementAndPropSetFuncStatement(strong, WMZDialog, UIView* ,                 wTapView)
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, DialogType,               wType)
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, CGFloat,                  wWidth)
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, CGFloat,                  wHeight)
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, CGFloat,                  wMainOffsetY)
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, CGFloat,                  wMainOffsetX)
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, CGFloat,                  wMainBtnHeight)
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, BOOL,                     wMainToBottom)
WMZDialogStatementAndPropSetFuncStatement(strong, WMZDialog, UIColor*,                 wLineColor)
WMZDialogStatementAndPropSetFuncStatement(strong, WMZDialog, UIColor*,                 wTitleColor)
WMZDialogStatementAndPropSetFuncStatement(strong, WMZDialog, UIColor*,                 wMessageColor)
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, CGFloat,                  wLineAlpha)
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, CGFloat,                  wDisappelSecond)
WMZDialogStatementAndPropSetFuncStatement(strong, WMZDialog, id,                       wData)
WMZDialogStatementAndPropSetFuncStatement(strong, WMZDialog, id,                       wSonData)
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, NSString*,                wTitle)
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, NSString*,                wMessage)
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, NSString*,                wOKTitle)
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, NSString*,                wCancelTitle)
WMZDialogStatementAndPropSetFuncStatement(strong, WMZDialog, UIColor*,                 wOKColor)
WMZDialogStatementAndPropSetFuncStatement(strong, WMZDialog, UIColor*,                 wCancelColor)
WMZDialogStatementAndPropSetFuncStatement(strong, WMZDialog, UIColor*,                 wMainBackColor)
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, CGFloat,                  wOKFont)
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, CGFloat,                  wCancelFont)
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, CGFloat,                  wTitleFont)
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, CGFloat,                  wMessageFont)
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, CGFloat,                  wMainRadius)
WMZDialogStatementAndPropSetFuncStatement(strong, WMZDialog, UIColor*,                 wShadowColor)
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, CGFloat,                  wShadowAlpha)
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, BOOL,                     wShadowCanTap)
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, BOOL,                     wShadowShow)
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, CGFloat,                  wKeyBoardMarginY)
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, NSInteger,                wPayNum)
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, NSString*,                wDefaultSelectPayStr)
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, NSInteger,                wWirteTextMaxLine)
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, NSInteger,                wWirteTextMaxNum)
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, UIKeyboardType,           wWirteKeyBoardType)
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, CGFloat,                  wPercentAngle)
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, CGFloat,                  wPercentOrginX)
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, DiaDirection,             wDirection)
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, CGSize,                   wImageSize)
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, NSString*,                wImageName)
WMZDialogStatementAndPropSetFuncStatement(strong, WMZDialog, UIColor*,                 wProgressTintColor)
WMZDialogStatementAndPropSetFuncStatement(strong, WMZDialog, UIColor*,                 wTrackTintColor)
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, BOOL,                     wAddBottomView)
WMZDialogStatementAndPropSetFuncStatement(strong, WMZDialog, NSArray* ,                wTableViewColor)
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, BOOL,                     wNavigationItem)
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, NSTextAlignment,          wTextAlignment)
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, NSInteger,                wLocationType)
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, ChainType,                wChainType)
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, NSString*,                wDateTimeType)
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, BOOL,                     wPickRepeat)
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, diaLogCellCallBlock,      wMyCell)
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, diaLogMyViewCallBlock,    wMyDiaLogView)
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, DialogClickBlock,         wEventOKFinish)
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, DialogClickBlock,         wEventCancelFinish)
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, DialogTableClickBlock,    wEventFinish)
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, DialogClickBlock,         wEventClose)
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, DialogMenuClickBlock,     wEventMenuClick)

/*=========================================Attributes==========================================*/

/*=========================================参数说明=====================================================================

 =========================================通用=========================================================================
参数                    说明                         类型                   可选值               默认值                    是否必传
wData                 数据源                          id                     -                   -                      是
wStart                 开始                           -                      -                   -                      是
wParentVC             父控制器                  UIViewController             -                当前VC                      -
wStyle              出现的动画样式             UIModalTransitionStyle      参考枚举   UIModalTransitionStyleCrossDissolve   -
wType                弹窗是类型                    DialogType              参考枚举          DialogTypeNornal              -
wWidth              弹窗视图的宽度                   CGFloat                  -            Dialog_GetWNum(500)            -
wHeight             弹窗视图的宽度                   CGFloat                  -     默认自适应高度(Dialog_GetHNum(300))      -
wMainOffsetY           Y间距                       CGFloat                  -             Dialog_GetHNum(20)            -
wMainOffsetX           X间距                       CGFloat                  -             Dialog_GetHNum(15)            -
wMainBtnHeight        按钮高度                      CGFloat                  -             Dialog_GetHNum(60)            -
wMyCell              自定义cell                 UITableViewCell              -                   -                       -
wMainToBottom       视图在最底部                       BOOL                   -                  NO                       -
wLineColor           线条的颜色                     UIColor                   -            DialogColor(0x333333)          -
wLineAlpha          线条的透明度                     CGFLoat                  -                 0.5f                      -
wTitle                标题文本                      NSString                 -                  提示                      -
wMessage              内容文本                      NSString                 -                  内容                      -
wOKTitle            确定按钮的文本                   NSString                 -                  确定                      -
wCancelTitle        取消按钮的文本                   NSString                 -                  取消                      -
wOKColor            确定按钮的颜色                    UIColor                 -            DialogColor(0xFF9900)          -
wCancelColor        取消按钮的颜色                    UIColor                 -            DialogColor(0x666666)          -
wMainBackColor     弹出视图的背景颜色                  UIColor                 -            DialogColor(0xffffff)          -
wTitleColor         标题文本的颜色                    UIColor                 -            DialogColor(0x333333)          -
wMessageColor       内容文本的颜色                    UIColor                 -            DialogColor(0x333333)          -
wOKFont            确定按钮的字体大小                  CGFLoat                 -                  16.0f                    -
wCancelFont        取消按钮的字体大小                  CGFLoat                 -                  16.0f                    -
wTitleFont         标题文本的字体大小                  CGFLoat                 -                  14.0f                    -
wMessageFont       内容文本的字体大小                  CGFLoat                 -                  16.0f                    -
wMainRadius         弹出视图的圆角                    CGFLoat                 -                  15.0f                    -
wShadowColor        遮罩层的颜色                      UIColor                 -            DialogColor(0x333333)          -
wShadowAlpha       遮罩层的透明度                     CGFLoat                 -                  16.0f                    -
wShadowCanTap     遮罩层能否点击关闭                    BOOL                   -                   YES                     -
wShadowShow         遮罩层是否显示                     BOOL                   -                   YES                     -
wTextAlignment        文本对齐方式                NSTextAlignment             _                   center                  _
wEventOKFinish        确定点击事件                DialogClickBlock            -                    -                      -
wEventCancelFinish 取消点击事件(不传默认没有取消按钮) DialogClickBlock            -                    -                      -
wEventFinish         所有的操作事件                DialogClickBlock            -                   -                       -
 
 
=========================================disappear=======================================================================
wDisappelSecond     自动消失的时间                    CGFLoat                  -                   1.5f                     -
 
=========================================pay=============================================================================
wSonData            支付方式选择数据源                 id                     -                    -                        -
wKeyBoardMarginY    弹窗与键盘的距离                 CGFLoat                   -                Dialog_GetHNum(70)          -
wPayNum               支付密码位数                  NSInteger                 -            6(若要设置位数比6大的则要保证宽度足够) -
wDefaultSelectPayStr 支付方式默认文本                NSString                  -                   农业银行                   -
 
=========================================write=============================================================================
wWirteTextMaxLine   编辑框可换行的最大行数            NSInteger                 -                     7                      -
wWirteTextMaxNum    编辑框可输入的最大数字            NSInteger                 -                  -1(-1为不限制)              -
wWirteKeyBoardType   编辑框的键盘type              UIKeyBoardType             -               UIKeyboardTypeDefault        -
 
=========================================pop=============================================================================
wPercentAngle       弹出的气泡位置                 CGFLoat                (0-1)不包含0和1          0.5f                      -
wPercentOrginX      弹出视图的中心X轴偏移           CGFLoat                  -                    1.0f(默认中间)              -
wDirection          弹出式图的方向                DiaDirection          left/right/top/bottom   directionDowm               -
wNavigationItem     导航栏位置                       BOOL                   NO                      _                      _
wTapView            触发点的视图                   UIView                   -                       -                      -（pop的时候必传）
 
=========================================down=============================================================================
wImageSize            图片的大小                     CGSize                   -     Dialog_GetWNum(110),Dialog_GetWNum(110) -
wImageName            图片路径名字                   NSString                 -                  down_tyx                    -
wProgressTintColor   进度条闲置时候的颜色              UIColor                  -                DialogColor(0xFF9900)        -
wTrackTintColor      进度条动作时候的颜色              UIColor                  -                DialogColor(0xF3F4F6)        -

=========================================menu=============================================================================
wTableViewColor      tableview的背景颜色              NSArray                  -             FFFFFF/F6F7FA/EBECF0/666666     -
 
=========================================location============================================================================
wLocationType        地区关联层级                     NSInteger              1/2/3                   3                      -
wChainType           关联层级的样式                   ChainType        tableview/pickView      ChainPickView                 -
=========================================datePicker==========================================================================
wDateTimeType        时间选择器样式                   NSString  yyyy年MM月dd日HH时mm分ss秒(自由组合) yyyy:MM:dd HH:mm:ss       -
wPickRepeat         pickView无限循环                  BOOL                   -                     yes                    -
=========================================my===============================================================================
wAddBottomView       是否添加底部按钮                   BOOL                   -                     NO                     -
wMyDiaLogView        自定义弹窗View(返回最底部的view)     -                     -                     -                      -
 
=========================================参数说明==========================================================================*/
@end

NS_ASSUME_NONNULL_END
