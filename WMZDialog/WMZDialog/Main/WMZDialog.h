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
//开始 带父视图
@property(nonatomic,copy,readonly) WMZDialog *(^wStartView)(UIView *parentView);
/*=========================================Attributes==========================================*/

/*=========================================通用=================================================*/
//数据源 
WMZDialogStatementAndPropSetFuncStatement(strong, WMZDialog, id,                       wData)
//设置弹窗tag 防止快速点击重复弹出 (也可同个设置不同tag 依次弹出)
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, NSInteger,                wTag)
//弹窗type
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, DialogType,               wType)
//弹窗出现的动画
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, DialogShowAnination,      wShowAnimation)
//弹窗消失的动画
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, DialogHideAnination,      wHideAnimation)
//弹窗动画时间 
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, NSTimeInterval,           wAnimationDurtion)
//默认选中 可传/model/@(index)/字符串/{@"id"}/ 的数组 单个表示单选 多个表示多选
WMZDialogStatementAndPropSetFuncStatement(strong, WMZDialog, NSArray*,                 wListDefaultValue)
//列表达到滚动的个数 default 8
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, NSInteger,                wListScrollCount)
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
//下划线样式 default line
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, UITableViewCellSeparatorStyle,wSeparatorStyle)

/*=========================================disappear=======================================================================*/
//自动消失时间
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, CGFloat,                  wDisappelSecond)

/*=========================================Pay=======================================================================*/
//距离弹窗键盘的距离
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, CGFloat,                  wKeyBoardMarginY)
//密码框数量
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, NSInteger,                wPayNum)
//支付方式默认文本
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, NSString*,                wDefaultSelectPayStr)
//关闭支付方式点击 default YES
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, BOOL,                     wCanSelectPay)

/*=========================================write=======================================================================*/
//提示文本
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, NSString*,                wPlaceholder)
//默认文本 
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, NSString*,                wWriteDefaultText)
//编辑框最大行数 大于行数则滚动
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, NSInteger,                wWirteTextMaxLine)
//编辑框可输入的文本最大文本长度
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, NSInteger,                wWirteTextMaxNum)
//键盘类型
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, UIKeyboardType,           wWirteKeyBoardType)

/*=========================================Pop=======================================================================*/
//弹出的气泡位置
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, CGFloat,                  wPercentAngle)
//弹出视图的中心X轴偏移
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, CGFloat,                  wPercentOrginX)
//弹出视图的位置 上下左右
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, DiaDirection,             wDirection)
//弹出视图的位置 必传
WMZDialogStatementAndPropSetFuncStatement(strong, WMZDialog, UIView* ,                 wTapView)
//如果弹出视图的frame不准确 可以自行调节
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, CGRect,                   wTapRect)
//是否是导航栏的按钮点击弹窗
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, BOOL,                     wNavigationItem)
//所在父视图的类型
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, DiaPopInView,             wTapViewType)
//父视图的tableviewHead还是tableviewFoot default Head
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, BOOL,                     wTapViewTableViewFoot)
//在tableViewHead上的按钮所在的headViewSection的index default 0
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, NSInteger,                wTableViewSectionHead)
//弹窗视图的borderWidth default 0
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, CGFloat,                  wPopViewBorderWidth)
//弹窗视图的borderColor default 主题颜色
WMZDialogStatementAndPropSetFuncStatement(strong, WMZDialog, UIColor*,                 wPopViewBorderColor)
//弹窗视图的圆角 可单独设置或者全部设置  默认无 和UIRectCorner用法相同 多了一个none
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, DialogRectCorner,         wPopViewRectCorner)
/*=========================================dowm=======================================================================*/
//图片的size
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, CGSize,                   wImageSize)
//图片的路径
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, NSString*,                wImageName)
//进度条颜色
WMZDialogStatementAndPropSetFuncStatement(strong, WMZDialog, UIColor*,                 wProgressTintColor)
//进度条运动的颜色
WMZDialogStatementAndPropSetFuncStatement(strong, WMZDialog, UIColor*,                 wTrackTintColor)

/*=========================================custom=======================================================================*/
//是否添加底部确定取消按钮
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, BOOL,                     wAddBottomView)

/*=========================================menu=======================================================================*/
//tableview的颜色
WMZDialogStatementAndPropSetFuncStatement(strong, WMZDialog, NSArray* ,                wTableViewColor)
//cell文本居中样式
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, NSTextAlignment,          wTextAlignment)


/*=========================================location=======================================================================*/
//地区的类型 1省 2省市 3省市区
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, NSInteger,                wLocationType)
//弹出的地区选择类型 pickview/tableview
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, ChainType,                wChainType)
//选中数据的分割符 默认‘，’
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, NSString*,                wSeparator)

/*=========================================datePicker===================================================================*/
//时间弹窗的样式
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, NSString*,                wDateTimeType)
//循环滚动
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, BOOL,                     wPickRepeat)
//默认选中时间 默认此刻
WMZDialogStatementAndPropSetFuncStatement(strong, WMZDialog, NSDate*,                  wDefaultDate)
//最大时间 default nil
WMZDialogStatementAndPropSetFuncStatement(strong, WMZDialog, NSDate*,                  wMaxDate)
//最小时间 default nil
WMZDialogStatementAndPropSetFuncStatement(strong, WMZDialog, NSDate*,                  wMinDate)

/*=========================================Share/tabbarMenu/NaviMENU==================================================*/
//WMZDialogShareView显示多少列
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, NSInteger,                wColumnCount)
//WMZDialogShareView显示多少行
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, NSInteger,                wRowCount)

/*=========================================load=======================================================================*/
//加载框样式
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, LoadingStyle,             wLoadingType)
//加载框大小
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, CGSize,                   wLoadingSize)
//加载框线条颜色
WMZDialogStatementAndPropSetFuncStatement(strong, WMZDialog, UIColor*,                 wLoadingColor)

/*=========================================cardParent==============================================================*/
//滑动到顶部继续滑动可关闭 default YES
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, BOOL,                     wOpenScrollClose)
//开启侧滑滑动关闭 default YES
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, BOOL,                     wLeftScrollClose)
//开启拖动 default YES
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, BOOL,                     wOpenDragging)
//缩放底部控制器 default YES
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, BOOL,                     wScaleParentVC)
//自定义顶部视图
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, diaLogPresentCallBlock,   wParentHeadView)
//自定义底部视图
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, diaLogPresentCallBlock,   wParentBottomView)

/*=========================================Calander==============================================================*/
//开启纵向滑动 default NO(横向滑动)
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, BOOL,                     wDirectionVertical)
//开启滑动 default YES
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, BOOL,                     wCalanderCanScroll)
//开启农历节日显示 default YES
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, BOOL,                     wOpenChineseDate)
//隐藏日历上的按钮 default YES
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, BOOL,                     wHideCalanderBtn)
//开启日历上连续日期检测 default YES
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, BOOL,                     wOpenCalanderRule)
//展示圆点的日期 携带格式为yyyy-MM-dd的日期
WMZDialogStatementAndPropSetFuncStatement(strong, WMZDialog, NSArray*,                 wDateShowCircle)
//注册自定义的collectionViewCell
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, NSString*,                wReginerCollectionCell)
/*=========================================Attributes==========================================*/

/*=========================================Event================================================*/
//自定义tableviewCell
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, diaLogCellCallBlock,      wMyCell)
//自定义tableviewCell (带是否选中isSelected 参数)
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, diaLogCustomCellBlock,    wCustomCell)
//自定义点击tableviewCell
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, diaLogCellSelectlock,     wSelectCell)
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
//自定义日历cell
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, DiaLogCollectionCellBlock,wCalanderCell)
//自定义日历点击事件
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, DiaLogCollectionClickBlock,wCalanderCellClick)

/*=========================================Event================================================*/

/*=========================================CustomView================================================*/
//自定义mainView 可改变frame
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, DialogCustomMainViewBlock,wCustomMainView)
//自定义TitleLa
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, DialogCustomTitle,wCustomTitleLa)
//自定义MessageLa
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, DialogCustomMessage,wCustomMessageLa)
//自定义OKBtn
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, DialogCustomOKBtn,wCustomOKBtn)
//自定义CancelBtn
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, DialogCustomCancelBtn,wCustomCancelBtn)
//自定义closeBtn
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, DialogCustomCloseBtn,wCustomCloseBtn)
//自定义TextView
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, DialogCustomTextView,wCustomTextView)
//自定义ImageView
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, DialogCustomImageView,wCustomImageView)
//自定义tableview
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, DialogCustomTableView,wCustomTableView)
/*=========================================CustomView================================================*/

/*=========================================参数说明=====================================================================

 =========================================通用=========================================================================
参数                    说明                         类型                   可选值               默认值                    是否必传
wStart                 开始                           -                      -                   -                      是
wData                 数据源                          id                     -                   -                       -
wShowAnimation       出现的动画                 DialogShowAnination         参考枚举           AninatonZoomIn              -
wHideAnimation       消失的动画                 DialogHideAnination         参考枚举              none                     -
wAnimationDurtion     动画时间                    NSTimeInterval             -                  0.8                      -
wType                弹窗是类型                    DialogType              参考枚举          DialogTypeNornal              -
wWidth              弹窗视图的宽度                   CGFloat                  -            Dialog_GetWNum(500)            -
wHeight             弹窗视图的宽度                   CGFloat                  -     默认自适应高度(Dialog_GetWNum(300))      -
wMainOffsetY           Y间距                       CGFloat                  -             Dialog_GetWNum(20)            -
wMainOffsetX           X间距                       CGFloat                  -             Dialog_GetWNum(15)            -
wMainBtnHeight        按钮高度                      CGFloat                  -             Dialog_GetWNum(60)            -
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
wShadowAlpha       遮罩层的透明度                     CGFLoat                 -                  0.4f                    -
wShadowCanTap     遮罩层能否点击关闭                    BOOL                   -                   YES                     -
wShadowShow         遮罩层是否显示                     BOOL                   -                   YES                     -
wEffectShow         毛玻璃是否显示                     BOOL                   -                    NO                     -
wMultipleSelection      多选                         BOOL                   -                    NO                     -
wSelectShowChecked    选中是否打钩                     BOOL                   -                    NO                     -
wTextAlignment        文本对齐方式                NSTextAlignment             _                   center                  _

 
=========================================DialogTypeAuto=======================================================================
 
wDisappelSecond     自动消失的时间                    CGFLoat                  -                   1.5f                     -
 
=========================================DialogTypePay=============================================================================
 
wSonData            支付方式选择数据源                 id                     -                    -                        -
wKeyBoardMarginY    弹窗与键盘的距离                 CGFLoat                   -                Dialog_GetWNum(70)          -
wPayNum               支付密码位数                  NSInteger                 -            6(若要设置位数比6大的则要保证宽度足够) -
wDefaultSelectPayStr 支付方式默认文本                NSString                  -                   农业银行                   -
 
=========================================DialogTypeWrite=============================================================================
 
wPlaceholder             提示语                     NSString                 -                    请输入                    -
wWirteTextMaxLine   编辑框可换行的最大行数            NSInteger                 -                     7                      -
wWirteTextMaxNum    编辑框可输入的最大数字            NSInteger                 -                  -1(-1为不限制)              -
wWirteKeyBoardType   编辑框的键盘type              UIKeyBoardType             -               UIKeyboardTypeDefault        -
 
=========================================DialogTypePop=============================================================================
 
wPercentAngle       弹出的气泡位置                 CGFLoat                (0-1)不包含0和1          0.5f                      -
wPercentOrginX      弹出视图的中心X轴偏移           CGFLoat                  -                    1.0f(默认中间)              -
wDirection          弹出式图的方向                DiaDirection          left/right/top/bottom   directionDowm               -
wNavigationItem     导航栏位置                       BOOL                   NO                      _                      _
wTapView            触发点的视图                   UIView                   -                        -                    -（pop的时候必传）
 
=========================================DialogTypeDown=============================================================================
wImageSize            图片的大小                     CGSize                   -     Dialog_GetWNum(110),Dialog_GetWNum(110) -
wImageName            图片路径名字                   NSString                 -                      -                      -
wProgressTintColor   进度条闲置时候的颜色              UIColor                  -                DialogColor(0xFF9900)        -
wTrackTintColor      进度条动作时候的颜色              UIColor                  -                DialogColor(0xF3F4F6)        -

=========================================DialogTypeMenusSelect=============================================================================
 
wTableViewColor      tableview的背景颜色              NSArray                  -             FFFFFF/F6F7FA/EBECF0/666666     -
 
=========================================DialogTypeLocation============================================================================
 
wLocationType        地区关联层级                     NSInteger              1/2/3                   3                      -
wChainType           关联层级的样式                   ChainType        tableview/pickView      ChainPickView                 -
wSeparator           选中数据的分隔符                  NSString                -                      ，                     -
 
=========================================DialogTypeDatePicker==========================================================================
 
wDateTimeType        时间选择器样式                   NSString  yyyy年MM月dd日HH时mm分ss秒(自由组合) yyyy:MM:dd HH:mm:ss       -
wPickRepeat         pickView无限循环                  BOOL                   -                     no                    -
 
=============================Share/tabbarMenu/NaviMENU========================================================================
 
注意如果设置了行和列 要如期显示 要设置好wHeight
wColumnCount           列                            NSInteger              -                     -                       -
wRowCount              行                            NSInteger              -                     -                       -

=========================================DialogTypeLoading===============================================================================
wLoadingType          加载框样式                     LoadingStyle             -                LoadingStyleWait            -
wLoadingSize          加载框size                     CGSize                  -              Dialog_GetWNum(90,90)         -
wLoadingColor         加载框线条颜色                  UIColor                  -                  确定按钮的文本颜色           -
 
=========================================DialogTypeCardPresent==========================================================================
wOpenScrollClose      滑动到顶部继续滑动可关闭           BOOL                    -                       YES                  -
wLeftScrollClose      测滑可关闭                       BOOL                    -                      YES                  -
wOpenDragging         开启拖动                         BOOL                    -                      YES                  -
wScaleParentVC        缩放底部控制器                    BOOL                    -                      YES                  -
wParentHeadView       自定义顶部视图                    -                      -                        -                  -
wParentBottomView     自定义底部视图                    -                      -                        -                  -

=========================================DialogTypeCalander==========================================================================
wDirectionVertical     开启纵向滑动                  BOOL                    -                       NO(横向滑动)            -
wCalanderCanScroll     开启滑动                     BOOL                    -                       YES                    -
wOpenChineseDate       开启农历节日显示               BOOL                    -                       YES                    -
wHideCalanderBtn       隐藏日历上的操作按钮            BOOL                    -                       YES                    -
wDateShowCircle        展示圆点的日期@[[NSDate date]] NSArray                 -                        -                     -
wReginerCollectionCell 注册自定义的collectionViewCell NSString               -                         -                    -
 
=========================================DialogTypeMyView===============================================================================
 
wAddBottomView       是否添加底部按钮                   BOOL                   -                     NO                     -
 
=========================================Events===============================================================================
 
wEventOKFinish        确定点击事件                DialogClickBlock            -                    -                      -
wEventCancelFinish 取消点击事件(不传默认没有取消按钮) DialogClickBlock            -                    -                      -
wEventFinish         所有的操作事件                DialogClickBlock            -                    -                       -
wEventClose          弹窗关闭事件                        -                     -                    -                       -
wEventMenuClick      菜单点击事件                        -                     -                    -                       -
wSelectCell          自定义cell点击                      -                     -                    -                       -
wMyCell              自定义cell                  UITableViewCell             -                    -                       -
wMyDiaLogView        自定义弹窗View(返回最底部的view)     -                     -                     -                      -
wCalanderCell        自定义日历cell                     -                     -                     -                      -
wCalanderCellClick   自定义日历点击                      -                     -                     -                      -

=========================================参数说明==========================================================================*/

- (void)showView:(nullable UIView*)showView;

@end

NS_ASSUME_NONNULL_END
