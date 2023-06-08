//
//  WMZDialog.h
//  WMZDialog
//
//  Created by wmz on 2019/6/5.
//  Copyright © 2019年 wmz. All rights reserved.
//

#import "WMZDialogBase.h"

NS_ASSUME_NONNULL_BEGIN

@interface WMZDialog : WMZDialogBase
/// 初始化
WMZDialog * Dialog(void);
/// 使用自定义弹窗 （实现WMZCustomPrototol协议的视图）
@property (nonatomic, copy, readonly) WMZDialog *(^wCustomView)(UIView <WMZCustomPrototol>*customView);
/// 开启暗黑模式 字典传nIl使用默认的暗黑颜色 传对应key则改变颜色 此处为全局配置 
@property (nonatomic, copy, readonly) WMZDialog *(^wDarkMode)(NSDictionary <DialogDarkColorKey, UIColor*>* _Nullable darkinfo);
/// 开始 必传
@property (nonatomic, copy, readonly) WMZDialog *(^wStart)(void);
/// 开始 带父视图 必传
@property (nonatomic, copy, readonly) WMZDialog *(^wStartView)(UIView *parentView);
/// 开始 带配置 必传
@property (nonatomic, copy, readonly) WMZDialog *(^wStartParam)(WMZDialogParam *param);
/// 开始 带配置和父视图 必传
@property (nonatomic, copy, readonly) WMZDialog *(^wStartParamView)(WMZDialogParam *param,UIView *parentView);
/// 开始 必传
@property (nonatomic, copy, readonly) WMZDialog *(^wStartConfig)(DialogCustomParam param);
/// 手动弹出视图
/// @param showView 父视图 nil 则为默认window
- (void)showView:(nullable UIView*)showView;

/// 手动关闭
- (void)closeView;

/// 手动关闭
/// @param block 动画结束回调
- (void)closeView:(nullable AnimalBlock)block;

/// 手动关闭 类方法
/// @param showView 父视图 nil 则为window
/// @param block 动画结束回调
+ (void)closeWithshowView:(nullable UIView*)showView block:(nullable AnimalBlock)block;

/// 手动关闭 类方法
/// @param tag tag
/// @param showView 父视图 nil 则为window
/// @param block 动画结束回调
+ (void)closeWithshowView:(nullable UIView*)showView tag:(NSInteger)tag block:(nullable AnimalBlock)block;

/// 重新设置frame
/// @param frame frame
- (void)reSetMainViewFrame:(CGRect)frame;

/// 数据源
WMZDialogStatementAndPropSetFuncStatement(strong, WMZDialog, id,                       wData)
/// 设置弹窗tag 防止快速点击重复弹出 (也可设置不同tag 依次弹出)
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, NSInteger,                wTag)
/// 设置弹窗的层级 层级高的在上层 可传入NSInteger 范围在0-999之间 必须同一父级才有效 default DialogLevelHigh
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, DialogLevel,              wLevel)
/// 弹窗type
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, DialogType,               wType)
/// 弹窗出现的动画 default AninatonShowNone
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, DialogShowAnination,      wShowAnimation)
/// 弹窗消失的动画 default AninatonHideNone
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, DialogHideAnination,      wHideAnimation)
/// 弹窗动画时间
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, NSTimeInterval,           wAnimationDurtion)
/// 默认选中 可传/model/@(index)/字符串/{@"id"}/ 的数组 单个表示单选 多个表示多选
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, NSArray*,                 wListDefaultValue)
/// 列表达到滚动的个数 default 8
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, NSInteger,                wListScrollCount)
/// 弹窗的宽度
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, CGFloat,                  wWidth)
/// 弹窗的高度
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, CGFloat,                  wHeight)
/// 竖直方向间距
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, CGFloat,                  wMainOffsetY)
/// 水平方向间距
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, CGFloat,                  wMainOffsetX)
/// 按钮高度  shareview高度
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, CGFloat,                  wMainBtnHeight)
/// cell高度
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, CGFloat,                  wCellHeight)
/// 线条颜色
WMZDialogStatementAndPropSetFuncStatement(strong, WMZDialog, UIColor*,                 wLineColor)
/// 线条透明度
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, CGFloat,                  wLineAlpha)
/// 标题颜色
WMZDialogStatementAndPropSetFuncStatement(strong, WMZDialog, UIColor*,                 wTitleColor)
/// 内容颜色
WMZDialogStatementAndPropSetFuncStatement(strong, WMZDialog, UIColor*,                 wMessageColor)
/// sheet底部颜色
WMZDialogStatementAndPropSetFuncStatement(strong, WMZDialog, UIColor*,                 wBottomLineColor)
/// 标题文本
WMZDialogStatementAndPropSetFuncStatement(strong, WMZDialog, id,                       wTitle)
/// 内容文本
WMZDialogStatementAndPropSetFuncStatement(strong, WMZDialog, id,                       wMessage)
/// 主题色 default =  OKColor
WMZDialogStatementAndPropSetFuncStatement(strong, WMZDialog, UIColor*,                 wThemeColor)
/// 确定按钮的文本
WMZDialogStatementAndPropSetFuncStatement(strong, WMZDialog, id,                       wOKTitle)
/// 取消按钮的文本
WMZDialogStatementAndPropSetFuncStatement(strong, WMZDialog, id,                       wCancelTitle)
/// 确定按钮的颜色
WMZDialogStatementAndPropSetFuncStatement(strong, WMZDialog, UIColor*,                 wOKColor)
/// 取消按钮的颜色
WMZDialogStatementAndPropSetFuncStatement(strong, WMZDialog, UIColor*,                 wCancelColor)
/// 弹窗背景颜色
WMZDialogStatementAndPropSetFuncStatement(strong, WMZDialog, UIColor*,                 wMainBackColor)
/// 确定按钮的font
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, CGFloat,                  wOKFont)
/// 取消按钮的font
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, CGFloat,                  wCancelFont)
/// 标题文本font
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, CGFloat,                  wTitleFont)
/// 内容文本font
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, CGFloat,                  wMessageFont)
/// 弹窗视图的圆角
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, CGFloat,                  wMainRadius)
/// 遮罩层颜色
WMZDialogStatementAndPropSetFuncStatement(strong, WMZDialog, UIColor*,                 wShadowColor)
/// 遮罩层透明度
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, CGFloat,                  wShadowAlpha)
/// 遮罩层能否点击
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, BOOL,                     wShadowCanTap)
/// 遮罩层是否显示
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, BOOL,                     wShadowShow)
/// v1.4.3显示主视图的阴影  default NO
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, BOOL,                     wMainShadowShow)
/// 毛玻璃是否显示 优先级大于遮罩层
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, BOOL,                     wEffectShow)
/// 多选
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, BOOL,                     wMultipleSelection)
/// 选中是否打钩
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, BOOL,                     wSelectShowChecked)
/// 是否将弹窗放置最底部
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, BOOL,                     wMainToBottom)
/// 是否监听横竖屏 default NO
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, BOOL,                     wDeviceDidChange)
/// 是否添加底部确定取消按钮
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, BOOL,                     wAddBottomView)
/// 隐藏已经存在的头部确定视图
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, BOOL,                     wHideExistTop)
/// 下划线样式 default none
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, UITableViewCellSeparatorStyle,wSeparatorStyle)
/// 选中打钩图片 default dialog_check
WMZDialogStatementAndPropSetFuncStatement(strong, WMZDialog, UIImage*,                 wCheckImage)
/// 开启键盘监听 自动偏移在键盘上部 default NO
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, BOOL,                     wOpenKeyBoard)
/// 底部确定取消按钮中间横线充满 default NO
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, BOOL,                     wFillBottomLine)
/// 响应库内的自动关闭 default YES 如果设为NO则需要自己调用手动关闭的类方法 closeWithshowView
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, BOOL,                     wAutoClose)
/// 自定义位置 default使用系统
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, CGPoint,                  wPoint)
/// 自动消失时间
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, CGFloat,                  wDisappelSecond)
/// 是否可交互 default YES
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, BOOL,                     wUserInteractionEnabled)
/// cell背景颜色 defalult white
WMZDialogStatementAndPropSetFuncStatement(strong, WMZDialog, UIColor*,                 wCellBackgroundColor)
/// cell所带图片的size default {30,30}
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, CGSize,                   wCellIconSize)
/// cell文本居中样式
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, NSTextAlignment,          wTextAlignment)

/*=========================================aoto=======================================================================*/
/// v1.4.3 最大宽度 默认等于wWidth
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, CGFloat,                  wAutoMaxWidth)
/// toastPosition
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, DialogToastPosition,      wToastPosition)

/*=========================================Pay=======================================================================*/
/// 距离弹窗键盘的距离
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, CGFloat,                  wKeyBoardMarginY)
/// 嵌套弹窗的数据源
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, NSArray*,                 wSonData)
/// 密码框数量
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, NSInteger,                wPayNum)
/// 支付方式默认文本
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, NSString*,                wDefaultSelectPayStr)
/// 关闭支付方式点击 default YES
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, BOOL,                     wCanSelectPay)

/*=========================================write=======================================================================*/
/// 提示文本
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, NSString*,                wPlaceholder)
/// 默认文本
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, NSString*,                wWriteDefaultText)
/// 编辑框最大行数 大于行数则滚动
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, NSInteger,                wWirteTextMaxLine)
/// 编辑框可输入的文本最大文本长度
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, NSInteger,                wWirteTextMaxNum)
/// 键盘类型
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, UIKeyboardType,           wWirteKeyBoardType)
/// 正则校验规则 default nil  例如 可传入 @{@"reguler":@"^1+[3578]+\\d{9}",@"reguletTip":@"请输入正确的手机号"}  key为DialogRegularKey
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, NSDictionary*,            wRegular)
///  多行文本默认高度 default lineHeight + 20
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, CGFloat,                  wInputAreaHeight)
/// 输入框背景颜色 default  .white
WMZDialogStatementAndPropSetFuncStatement(strong, WMZDialog, UIColor* ,                wInputBackGroundColor)
/// 编辑框颜色 default black
WMZDialogStatementAndPropSetFuncStatement(strong, WMZDialog, UIColor*,                 wInputTextColor)

/*=========================================Pop=======================================================================*/
/// 弹出的气泡位置
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, CGFloat,                  wPercentAngle)
/// 弹出视图的中心X轴偏移
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, CGFloat,                  wPercentOrginX)
/// 弹出视图的位置 上下左右
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, DiaDirection,             wDirection)
/// 弹出视图的位置对象 必传(如果传入wTapRect则可不传)
WMZDialogStatementAndPropSetFuncStatement(strong, WMZDialog, UIView* ,                 wTapView)
/// 如果弹出视图的frame不准确 可以自行调节
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, CGRect,                   wTapRect)
/// 是否是导航栏的按钮点击弹窗
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, BOOL,                     wNavigationItem)
/// 所在父视图的类型
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, DiaPopInView,             wTapViewType)
/// 父视图的tableviewHead还是tableviewFoot default Head
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, BOOL,                     wTapViewTableViewFoot)
/// 在tableViewHead上的按钮所在的headViewSection的index default 0
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, NSInteger,                wTableViewSectionHead)
/// 弹窗视图的borderWidth default 0
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, CGFloat,                  wPopViewBorderWidth)
/// 弹窗视图的borderColor default 主题颜色
WMZDialogStatementAndPropSetFuncStatement(strong, WMZDialog, UIColor*,                 wPopViewBorderColor)
/// 弹窗视图的圆角 可单独设置或者全部设置  默认无 和UIRectCorner用法相同 多了一个none
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, DialogRectCorner,         wPopViewRectCorner)
/// 三角形的size
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, CGSize,                   wAngleSize)
/// 三角形的顶部圆角 default 0
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, CGFloat,                  wAngleRadio)
/// v1.4.4 pop弹窗内容视图类型 default DialogPopTypeTable tableView列表样式
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, DialogPopType,            wPopStyleType)
/// 如果弹出视图的位置不对 设置此属性 例如继承了tableView则传入 继承的类名 default nil
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, NSString*,                wPopNestStopView)
/// cell内容对齐位置(图文有效) 传入字符串的时候使用wTextAlignment default 左对齐
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, DialogCellAlignType,       wCellAlignType)

/// 可设置wMainOffsetY 调整弹出视图的y default 0
/// wMainOffsetY

/*=========================================dowm=======================================================================*/
/// 图片的size
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, CGSize,                   wImageSize)
/// 图片的路径
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, NSString*,                wImageName)
/// 进度条颜色
WMZDialogStatementAndPropSetFuncStatement(strong, WMZDialog, UIColor*,                 wProgressTintColor)
/// 进度条运动的颜色
WMZDialogStatementAndPropSetFuncStatement(strong, WMZDialog, UIColor*,                 wTrackTintColor)


/*=========================================menu=======================================================================*/
/// tableview的颜色 有tableViewCell的时候取数组的第一个 可改变背景颜色
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, NSArray* ,                wTableViewColor)

/*=========================================location=======================================================================*/
/// 地区的类型 1省 2省市 3省市区
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, DialogLocationType,       wLocationType)
/// 弹出的地区选择类型 pickview/tableview
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, ChainType,                wChainType)
/// 选中数据的分割符 默认‘，’
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, NSString*,                wSeparator)
/// 默认地区的数据路径名称 default @"province_data"
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, NSString*,                wXMLPathName)

/*=========================================datePicker===================================================================*/
/// 时间弹窗的样式
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, NSString*,                wDateTimeType)
/// 循环滚动
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, BOOL,                     wPickRepeat)
/// 默认选中时间 默认此刻
WMZDialogStatementAndPropSetFuncStatement(strong, WMZDialog, NSDate*,                  wDefaultDate)
/// 最大时间 default nil
WMZDialogStatementAndPropSetFuncStatement(strong, WMZDialog, NSDate*,                  wMaxDate)
/// 最小时间 default nil
WMZDialogStatementAndPropSetFuncStatement(strong, WMZDialog, NSDate*,                  wMinDate)

/*=========================================Share/tabbarMenu/NaviMENU==================================================*/
/// WMZDialogShareView显示多少列 default 4
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, NSInteger,                wColumnCount)
/// WMZDialogShareView显示多少行 default 1
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, NSInteger,                wRowCount)

/*=========================================load=======================================================================*/
/// 加载框样式
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, LoadingStyle,             wLoadingType)
/// 加载框大小
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, CGSize,                   wLoadingSize)
/// 加载框线条颜色
WMZDialogStatementAndPropSetFuncStatement(strong, WMZDialog, UIColor*,                 wLoadingColor)
/// 显示右上角关闭按钮 default NO
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, BOOL,                     wShowClose)
/// 加载框线条宽度 default 2.5f
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, CGFloat,                  wLoadingWidth)

/*=========================================cardParent==============================================================*/
/// 滑动到顶部继续滑动可关闭 default YES
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, BOOL,                     wOpenScrollClose)
/// 开启侧滑滑动关闭 default YES
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, BOOL,                     wLeftScrollClose)
/// 开启拖动 default YES
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, BOOL,                     wOpenDragging)
/// 缩放底部控制器 default YES
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, BOOL,                     wScaleParentVC)
/// 自定义顶部视图
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, DiaLogPresentCallBlock,   wParentHeadView)
/// 自定义底部视图
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, DiaLogPresentCallBlock,   wParentBottomView)

/*=========================================Calander==============================================================*/
/// 开启纵向滑动 default NO(横向滑动)
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, BOOL,                     wDirectionVertical)
/// 开启滑动 default YES
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, BOOL,                     wCalanderCanScroll)
/// 开启农历节日显示 default YES
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, BOOL,                     wOpenChineseDate)
/// 隐藏日历上的按钮 default YES
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, BOOL,                     wHideCalanderBtn)
/// 展示圆点的日期 携带格式为yyyy-MM-dd的日期
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, NSArray*,                 wDateShowCircle)
/// 注册自定义的collectionViewCell
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, NSString*,                wReginerCollectionCell)
/// 开启选择多个选续区域 default YES
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, BOOL,                     wOpenMultiZone)
/// 多选中间部分透明度 default 1 不透明
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, CGFloat,                  wLimitAlpha)
/// cellSize default(屏幕宽度/7,屏幕宽度/7) 如果设置了那么 wWidth为 wCalanderCellSize.width * 7
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, CGSize,                   wCalanderCellSize)
/// 日历顶部标题数组 必须为数量 = 7 的数组
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, NSArray<NSString*>*,      wCalanderWeekTitleArr)
/// 设置日历设置最大最小值的效果 default @[DialogCalanderLimitCloseClick]
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, NSArray<DialogCalanderLimitTypeKey>*,wMinMaxResultArr)
/// 是否开启wBounces 默认NO
WMZDialogStatementAndPropSetFuncStatement(assign, WMZDialog, BOOL,                     wBounces)

/*=========================================Attributes==========================================*/


/*=========================================Event================================================*/
/// 自定义tableviewCell (带是否选中isSelected 参数)
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, DiaLogCustomCellBlock,    wCustomCell)
/// 自定义点击tableviewCell
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, DiaLogCellSelectlock,     wSelectCell)
/// 自定义弹窗视图内容
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, DiaLogMyViewCallBlock,    wMyDiaLogView)
/// 按钮确定点击事件
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, DialogClickBlock,         wEventOKFinish)
/// 按钮取消点击事件
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, DialogClickBlock,         wEventCancelFinish)
/// 阴影关闭事件
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, DialogClickBlock,         wEventShadomClose)
/// 操作完成事件
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, DialogTableClickBlock,    wEventFinish)
/// 弹窗关闭事件
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, DialogClickBlock,         wEventClose)
/// 菜单点击事件
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, DialogMenuClickBlock,     wEventMenuClick)
/// 自定义日历cell
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, DiaLogCollectionCellBlock,wCalanderCell)
/// 自定义日历点击事件
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, DiaLogCollectionClickBlock,wCalanderCellClick)
///v1.4.4 pop弹窗自定义内容视图
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, DialogPopCustomBlock,      wPopCustomView)
/// 自定义出现动画
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, DialogCustomAnimal,        wEventCustomShowAmimal)
/// 自定义消失动画
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, DialogCustomAnimal,        wEventCustomHideAmimal)

/*=========================================Event================================================*/

/*=========================================CustomView================================================*/
/// 自定义mainView 可改变frame
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, DialogCustomMainViewBlock,wCustomMainView)
/// 自定义TitleLa
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, DialogCustomTitle,wCustomTitleLa)
/// 自定义MessageLa
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, DialogCustomMessage,wCustomMessageLa)
/// 自定义OKBtn
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, DialogCustomOKBtn,wCustomOKBtn)
/// 自定义CancelBtn
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, DialogCustomCancelBtn,wCustomCancelBtn)
/// 自定义closeBtn
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, DialogCustomCloseBtn,wCustomCloseBtn)
/// 自定义TextView
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, DialogCustomTextView,wCustomTextView)
/// 自定义ImageView
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, DialogCustomImageView,wCustomImageView)
/// 自定义tableview
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, DialogCustomTableView,wCustomTableView)
/// v1.4.3 自定义修改主视图阴影 非底部阴影
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, DialogCustomMainShadomLayer,wCustomMainShadom)
/// 自定义shareView
WMZDialogStatementAndPropSetFuncStatement(copy,   WMZDialog, DialogCustomShareView,wCustomShareView)
/*=========================================CustomView================================================*/
@end

NS_ASSUME_NONNULL_END
