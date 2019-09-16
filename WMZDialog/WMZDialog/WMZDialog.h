//
//  WMZDialog.h
//  WMZDialog
//
//  Created by wmz on 2019/6/5.
//  Copyright © 2019年 wmz. All rights reserved.
//

#import "WMZDiaLogBase.h"
#define pickViewCount 200
NS_ASSUME_NONNULL_BEGIN

@interface WMZDialog : WMZDiaLogBase<UITableViewDataSource,UITableViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource>

//初始化
WMZDialog * Dialog(void);
//开始 必传
@property(nonatomic,copy,readonly) WMZDialog *(^wStart)(void);

/*=========================================Attributes==========================================*/
//数据源 
WMZDialogStatementAndPropSetFuncStatement(strong, WMZDialog, id,                       wData)
//弹出的vc
WMZDialogStatementAndPropSetFuncStatement(strong, WMZDialog, UIViewController*,        wParentVC)
//弹窗type
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, DialogType,               wType)
//弹窗出现的动画
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, DialogShowAnination,      wShowAnimation)
//弹窗消失的动画
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, DialogHideAnination,      wHideAnimation)
//弹窗动画时间
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, NSTimeInterval,           wAnimationDurtion)
//弹窗的宽度
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, CGFloat,                  wWidth)
//弹窗的高度
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, CGFloat,                  wHeight)
//竖直方向间距
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, CGFloat,                  wMainOffsetY)
//水平方向间距
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, CGFloat,                  wMainOffsetX)
//按钮高度  shareview高度
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, CGFloat,                  wMainBtnHeight)
//cell高度
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, CGFloat,                  wCellHeight)
//是否将弹窗放置最底部
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, BOOL,                     wMainToBottom)
//线条颜色
WMZDialogStatementAndPropSetFuncStatement(strong, WMZDialog, UIColor*,                 wLineColor)
//线条透明度
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, CGFloat,                  wLineAlpha)
//标题颜色
WMZDialogStatementAndPropSetFuncStatement(strong, WMZDialog, UIColor*,                 wTitleColor)
//内容颜色
WMZDialogStatementAndPropSetFuncStatement(strong, WMZDialog, UIColor*,                 wMessageColor)
//嵌套弹窗的数据源
WMZDialogStatementAndPropSetFuncStatement(strong, WMZDialog, id,                       wSonData)
//标题文本
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, NSString*,                wTitle)
//内容文本
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, NSString*,                wMessage)
//确定按钮的文本
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, NSString*,                wOKTitle)
//取消按钮的文本
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, NSString*,                wCancelTitle)
//确定按钮的颜色
WMZDialogStatementAndPropSetFuncStatement(strong, WMZDialog, UIColor*,                 wOKColor)
//取消按钮的颜色
WMZDialogStatementAndPropSetFuncStatement(strong, WMZDialog, UIColor*,                 wCancelColor)
//弹窗背景颜色
WMZDialogStatementAndPropSetFuncStatement(strong, WMZDialog, UIColor*,                 wMainBackColor)
//确定按钮的font
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, CGFloat,                  wOKFont)
//取消按钮的font
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, CGFloat,                  wCancelFont)
//标题文本font
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, CGFloat,                  wTitleFont)
//内容文本font
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, CGFloat,                  wMessageFont)
//弹窗视图的圆角
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, CGFloat,                  wMainRadius)
//遮罩层颜色
WMZDialogStatementAndPropSetFuncStatement(strong, WMZDialog, UIColor*,                 wShadowColor)
//遮罩层透明度
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, CGFloat,                  wShadowAlpha)
//遮罩层能否点击
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, BOOL,                     wShadowCanTap)
//遮罩层是否显示
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, BOOL,                     wShadowShow)
//毛玻璃是否显示 优先级大于遮罩层
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, BOOL,                     wEffectShow)
//多选
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, BOOL,                     wMultipleSelection)
//选中是否打钩
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, BOOL,                     wSelectShowChecked)

//自动消失时间
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, CGFloat,                  wDisappelSecond)


//距离弹窗键盘的距离
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, CGFloat,                  wKeyBoardMarginY)
//密码框数量
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, NSInteger,                wPayNum)
//支付方式默认文本
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, NSString*,                wDefaultSelectPayStr)


//提示文本
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, NSString*,                wPlaceholder)
//编辑框最大行数 大于行数则滚动
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, NSInteger,                wWirteTextMaxLine)
//编辑框可输入的文本最大文本长度
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, NSInteger,                wWirteTextMaxNum)
//键盘类型
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, UIKeyboardType,           wWirteKeyBoardType)


//弹出的气泡位置
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, CGFloat,                  wPercentAngle)
//弹出视图的中心X轴偏移
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, CGFloat,                  wPercentOrginX)
//弹出视图的位置 上下左右
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, DiaDirection,             wDirection)
//弹出视图的位置 必传
WMZDialogStatementAndPropSetFuncStatement(strong, WMZDialog, UIView* ,                 wTapView)
//是否是导航栏的按钮点击弹窗
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, BOOL,                     wNavigationItem)


//图片的size
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, CGSize,                   wImageSize)
//图片的路径
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, NSString*,                wImageName)

//进度条颜色
WMZDialogStatementAndPropSetFuncStatement(strong, WMZDialog, UIColor*,                 wProgressTintColor)
//进度条运动的颜色
WMZDialogStatementAndPropSetFuncStatement(strong, WMZDialog, UIColor*,                 wTrackTintColor)

//是否添加底部确定取消按钮
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, BOOL,                     wAddBottomView)


//tableview的颜色
WMZDialogStatementAndPropSetFuncStatement(strong, WMZDialog, NSArray* ,                wTableViewColor)
//cell文本居中样式
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, NSTextAlignment,          wTextAlignment)


//地区的类型 1省 2省市 3省市区
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, NSInteger,                wLocationType)
//弹出的地区选择类型 pickview/tableview
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, ChainType,                wChainType)
//选中数据的分割符 默认‘，’
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, NSString*,                wSeparator)

//时间弹窗的样式
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, NSString*,                wDateTimeType)
//循环滚动
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, BOOL,                     wPickRepeat)

//自定义tableviewCell
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, diaLogCellCallBlock,      wMyCell)
//自定义弹窗视图内容
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, diaLogMyViewCallBlock,    wMyDiaLogView)
//按钮确定点击事件
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, DialogClickBlock,         wEventOKFinish)
//按钮取消点击事件
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, DialogClickBlock,         wEventCancelFinish)
//操作完成事件
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, DialogTableClickBlock,    wEventFinish)
//弹窗关闭事件
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, DialogClickBlock,         wEventClose)
//菜单点击事件
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, DialogMenuClickBlock,     wEventMenuClick)

//WMZDialogShareView显示多少列
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, NSInteger,                wColumnCount)
//WMZDialogShareView显示多少行
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, NSInteger,                wRowCount)

//加载框样式
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, LoadingStyle,             wLoadingType)
//加载框大小
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, CGSize,                   wLoadingSize)
//加载框线条颜色
WMZDialogStatementAndPropSetFuncStatement(strong, WMZDialog, UIColor*,                 wLoadingColor)

/*=========================================Attributes==========================================*/

/*=========================================参数说明=====================================================================

 =========================================通用=========================================================================
参数                    说明                         类型                   可选值               默认值                    是否必传
wStart                 开始                           -                      -                   -                      是
wData                 数据源                          id                     -                   -                       -
wShowAnimation       出现的动画                 DialogShowAnination         参考枚举           AninatonZoomIn              -
wHideAnimation       消失的动画                 DialogHideAnination         参考枚举              none                     -
wAnimationDurtion     动画时间                    NSTimeInterval             -                  0.8                      -
wParentVC             父控制器                  UIViewController             -                当前VC                      -
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
wEffectShow         毛玻璃是否显示                     BOOL                   -                    NO                     -
wMultipleSelection      多选                         BOOL                   -                    NO                     -
wSelectShowChecked    选中是否打钩                     BOOL                   -                    NO                     -
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
 
wPlaceholder             提示语                     NSString                 -                    请输入                    -
wWirteTextMaxLine   编辑框可换行的最大行数            NSInteger                 -                     7                      -
wWirteTextMaxNum    编辑框可输入的最大数字            NSInteger                 -                  -1(-1为不限制)              -
wWirteKeyBoardType   编辑框的键盘type              UIKeyBoardType             -               UIKeyboardTypeDefault        -
 
=========================================pop=============================================================================
 
wPercentAngle       弹出的气泡位置                 CGFLoat                (0-1)不包含0和1          0.5f                      -
wPercentOrginX      弹出视图的中心X轴偏移           CGFLoat                  -                    1.0f(默认中间)              -
wDirection          弹出式图的方向                DiaDirection          left/right/top/bottom   directionDowm               -
wNavigationItem     导航栏位置                       BOOL                   NO                      _                      _
wTapView            触发点的视图                   UIView                   -                        -                      -（pop的时候必传）
 
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
wSeparator           选中数据的分隔符                  NSString                -                      ，                     -
 
=========================================datePicker==========================================================================
 
wDateTimeType        时间选择器样式                   NSString  yyyy年MM月dd日HH时mm分ss秒(自由组合) yyyy:MM:dd HH:mm:ss       -
wPickRepeat         pickView无限循环                  BOOL                   -                     yes                    -
 
=============================Share/tabbarMenu/NaviMENU========================================================================
 
注意如果设置了行和列 要如期显示 要设置好wHeight
wColumnCount           列                            NSInteger              -                     -                       -
wRowCount              行                            NSInteger              -                     -                       -

=========================================loading===============================================================================
wLoadingType          加载框样式                     LoadingStyle             -                LoadingStyleWait            -
wLoadingSize          加载框size                     CGSize                  -              Dialog_GetHNum(90,90)         -
wLoadingColor         加载框线条颜色                  UIColor                  -                  确定按钮的文本颜色           -
 
=========================================custom===============================================================================
 
wAddBottomView       是否添加底部按钮                   BOOL                   -                     NO                     -
wMyDiaLogView        自定义弹窗View(返回最底部的view)     -                     -                     -                      -
 
=========================================参数说明==========================================================================*/



@end

NS_ASSUME_NONNULL_END
