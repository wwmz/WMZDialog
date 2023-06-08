//
//  WMZDialogParam.h
//  WMZDialog
//
//  Created by wmz on 2021/7/17.
//  Copyright © 2021 wmz. All rights reserved.
//
#import "WMZDialogMacro.h"
NS_ASSUME_NONNULL_BEGIN

/// 编辑type
typedef NSString *DialogRegularKey NS_STRING_ENUM;
/// 达到最大长度后提示语
FOUNDATION_EXPORT DialogRegularKey const DialogRegularMaxTip;
/// 校验规则
FOUNDATION_EXPORT DialogRegularKey const DialogRegulars;
/// 校验提示
FOUNDATION_EXPORT DialogRegularKey const DialogRegularTip;

/// 暗黑模式颜色type
typedef NSString *DialogDarkColorKey NS_STRING_ENUM;
/// 跟随系统 默认YES
FOUNDATION_EXPORT DialogDarkColorKey const DialogDarkFollowSystem;
/// 主要颜色
FOUNDATION_EXPORT DialogDarkColorKey const DialogDarkMainColor;
/// 二级颜色
FOUNDATION_EXPORT DialogDarkColorKey const DialogDarkC2;
/// 三级颜色
FOUNDATION_EXPORT DialogDarkColorKey const DialogDarkC3;

///日历设置最大最小值的效果Key
typedef NSString * DialogCalanderLimitTypeKey NS_STRING_ENUM;
/// 不可点击
FOUNDATION_EXPORT DialogCalanderLimitTypeKey const DialogCalanderLimitCloseClick;
/// 隐藏视图
FOUNDATION_EXPORT DialogCalanderLimitTypeKey const DialogCalanderLimitHide;
/// 置灰
FOUNDATION_EXPORT DialogCalanderLimitTypeKey const DialogCalanderLimitGray;
/// 关闭滑动
FOUNDATION_EXPORT DialogCalanderLimitTypeKey const DialogCalanderLimitCloseScroll;

@interface WMZDialogParentParam : NSObject

#pragma -mark 通用
/// 数据源
@property (nonatomic, strong) id wData;
/// 设置弹窗tag 防止快速点击重复弹出 (也可设置不同tag 依次弹出) defaut 12345;
@property (nonatomic, assign) NSInteger wTag;
/// 设置弹窗的层级 层级高的在上层 可传入NSInteger 范围在0-999之间 必须同一父级才有效 default DialogLevelHigh
@property (nonatomic, assign) DialogLevel wLevel;
/// 弹窗type default DialogTypeNornal;
@property (nonatomic, assign) DialogType wType;
/// 弹窗出现的动画 default AninatonShowNone
@property (nonatomic, assign) DialogShowAnination wShowAnimation;
/// 弹窗消失的动画 default AninatonHideNone
@property (nonatomic, assign) DialogHideAnination wHideAnimation;
/// 弹窗动画时间 default  0.3f
@property (nonatomic, assign) NSTimeInterval wAnimationDurtion;
/// 默认选中 可传/model/@(index)/字符串/{@"id"}/ 的数组 单个表示单选 多个表示多选 default nil
@property (nonatomic,   copy) NSArray *wListDefaultValue;
/// 列表达到滚动的个数 default 8
@property (nonatomic, assign) NSInteger wListScrollCount;
/// 弹窗的宽度 default  DialogRealW(500);
@property (nonatomic, assign) CGFloat wWidth;
/// 弹窗的高度 default DialogRealW(400);
@property (nonatomic, assign) CGFloat wHeight;
/// 竖直方向间距 default DialogRealW(20);
@property (nonatomic, assign) CGFloat wMainOffsetY;
/// 水平方向间距 default DialogRealW(15);
@property (nonatomic, assign) CGFloat wMainOffsetX;
/// 按钮高度  shareview高度
@property (nonatomic, assign) CGFloat wMainBtnHeight;
/// cell高度
@property (nonatomic, assign) CGFloat wCellHeight;
/// 线条颜色
@property (nonatomic, strong) UIColor *wLineColor;
/// 线条透明度
@property (nonatomic, assign) CGFloat wLineAlpha;
/// 标题颜色
@property (nonatomic, strong) UIColor *wTitleColor;
/// 内容颜色
@property (nonatomic, strong) UIColor *wMessageColor;
/// sheet底部颜色
@property (nonatomic, strong) UIColor *wBottomLineColor;
/// 标题文本
@property (nonatomic, strong) id wTitle;
/// 内容文本
@property (nonatomic, strong) id wMessage;
/// 确定按钮的文本
@property (nonatomic, strong) id wOKTitle;
/// 取消按钮的文本
@property (nonatomic, strong) id wCancelTitle;
/// 确定按钮的颜色
@property (nonatomic, strong) UIColor *wOKColor;
/// 主题颜色
@property (nonatomic, strong) UIColor *wThemeColor;
/// 取消按钮的颜色
@property (nonatomic, strong) UIColor *wCancelColor;
/// 弹窗背景颜色
@property (nonatomic, strong) UIColor *wMainBackColor;
/// 确定按钮的font
@property (nonatomic, assign) CGFloat wOKFont;
/// 取消按钮的font
@property (nonatomic, assign) CGFloat wCancelFont;
/// 标题文本font
@property (nonatomic, assign) CGFloat wTitleFont;
/// 内容文本font
@property (nonatomic, assign) CGFloat wMessageFont;
/// 弹窗视图的圆角
@property (nonatomic, assign) CGFloat wMainRadius;
/// 遮罩层颜色
@property (nonatomic, strong) UIColor *wShadowColor;
/// 遮罩层透明度
@property (nonatomic, assign) CGFloat wShadowAlpha;
/// 遮罩层能否点击
@property (nonatomic, assign) BOOL wShadowCanTap;
/// 遮罩层是否显示
@property (nonatomic, assign) BOOL wShadowShow;
/// 毛玻璃是否显示 优先级大于遮罩层
@property (nonatomic, assign) BOOL wEffectShow;
/// 多选
@property (nonatomic, assign) BOOL wMultipleSelection;
/// 选中是否打钩
@property (nonatomic, assign) BOOL wSelectShowChecked;
/// 是否将弹窗放置最底部
@property (nonatomic, assign) BOOL wMainToBottom;
/// 是否监听横竖屏 default NO
@property (nonatomic, assign) BOOL wDeviceDidChange;
/// 是否添加底部确定取消按钮
@property (nonatomic, assign) BOOL wAddBottomView;
/// 隐藏已经存在的头部确定视图
@property (nonatomic, assign) BOOL wHideExistTop;
///v1.4.3显示主视图的阴影  default NO
@property (nonatomic, assign) BOOL wMainShadowShow;
/// 下划线样式 default UITableViewCellSeparatorStyleNone
@property (nonatomic, assign) UITableViewCellSeparatorStyle wSeparatorStyle;
/// 选中打钩图片 default dialog_check
@property (nonatomic, strong) UIImage *wCheckImage;
/// 开启键盘监听 自动偏移在键盘上部 default NO
@property (nonatomic, assign) BOOL wOpenKeyBoard;
/// 底部确定取消按钮中间横线充满 default NO
@property (nonatomic, assign) BOOL wFillBottomLine;
/// 响应库内的自动关闭 default YES 如果设为NO则需要自己调用手动关闭的类方法 closeWithshowView
@property (nonatomic, assign) BOOL wAutoClose;
/// 自定义位置 default使用系统
@property (nonatomic, assign) CGPoint wPoint;
/// 自动消失时间
@property (nonatomic, assign) CGFloat wDisappelSecond;
/// 是否可交互 default YES
@property (nonatomic, assign) BOOL wUserInteractionEnabled;
/// cell背景颜色 default white
@property (nonatomic, strong) UIColor *wCellBackgroundColor;
/// cell所带图片的size default {30,30}
@property (nonatomic, assign) CGSize wCellIconSize;
/// cell内容对齐位置(图文有效) 传入字符串的时候使用wTextAlignment default 左对齐
@property (nonatomic, assign) DialogCellAlignType wCellAlignType;

#pragma -mark Toast/Auto
/// toastPosition
@property (nonatomic, assign) DialogToastPosition wToastPosition;
/// v1.4.3 最大宽度 默认等于wWidth
@property (nonatomic, assign) CGFloat wAutoMaxWidth;

#pragma -mark PayType
/// 距离弹窗键盘的距离
@property (nonatomic, assign) CGFloat wKeyBoardMarginY;
/// 嵌套弹窗的数据源
@property (nonatomic,   copy) NSArray *wSonData;
/// 密码框数量
@property (nonatomic, assign) NSInteger wPayNum;
/// 支付方式默认文本
@property (nonatomic,   copy) NSString *wDefaultSelectPayStr;
/// 关闭支付方式点击 default YES
@property (nonatomic, assign) BOOL wCanSelectPay;

#pragma -mark writeType
/// 多行文本默认高度 default lineHeight + 20
@property (nonatomic, assign) CGFloat wInputAreaHeight;
/// 提示文本
@property (nonatomic,   copy) NSString *wPlaceholder;
/// 默认文本
@property (nonatomic,   copy) NSString *wWriteDefaultText;
/// 编辑框最大行数 大于行数则滚动
@property (nonatomic, assign) NSInteger wWirteTextMaxLine;
/// 编辑框可输入的文本最大文本长度
@property (nonatomic, assign) NSInteger wWirteTextMaxNum;
/// 键盘类型
@property (nonatomic, assign) UIKeyboardType wWirteKeyBoardType;
/// 正则校验规则 default nil  例如 可传入 @{@"reguler":@"^1+[3578]+\\d{9}",@"reguletTip":@"请输入正确的手机号"}
@property (nonatomic,   copy) NSDictionary *wRegular;
/// 输入框背景颜色 default  .white
@property (nonatomic, strong) UIColor *wInputBackGroundColor;
/// 输入框文字颜色 default black
@property (nonatomic, strong) UIColor *wInputTextColor;

#pragma -mark popType
/// 弹出的气泡位置
@property (nonatomic, assign) CGFloat wPercentAngle;
/// 弹出视图的中心X轴偏移
@property (nonatomic, assign) CGFloat wPercentOrginX;
/// 弹出视图的位置 上下左右
@property (nonatomic, assign) DiaDirection wDirection;
/// 弹出视图的位置对象 必传(如果传入wTapRect则可不传)
@property (nonatomic, strong) UIView *wTapView;
/// 如果弹出视图的frame不准确 可以自行调节
@property (nonatomic, assign) CGRect wTapRect;
/// 是否是导航栏的按钮点击弹窗
@property (nonatomic, assign) BOOL wNavigationItem;
/// 所在父视图的类型
@property (nonatomic, assign) DiaPopInView wTapViewType;
/// 父视图的tableviewHead还是tableviewFoot default Head
@property (nonatomic, assign) BOOL wTapViewTableViewFoot;
/// 在tableViewHead上的按钮所在的headViewSection的index default 0
@property (nonatomic, assign) NSInteger wTableViewSectionHead;
/// 弹窗视图的borderWidth default 0
@property (nonatomic, assign) CGFloat wPopViewBorderWidth;
/// 弹窗视图的borderColor default 主题颜色
@property (nonatomic, strong) UIColor *wPopViewBorderColor;
/// 弹窗视图的圆角 可单独设置或者全部设置  默认无 和UIRectCorner用法相同 多了一个none
@property (nonatomic, assign) DialogRectCorner wPopViewRectCorner;
/// 三角形的size
@property (nonatomic, assign) CGSize wAngleSize;
/// 三角形的顶部圆角 default 0
@property (nonatomic, assign) CGFloat wAngleRadio;
/// v1.4.4 pop弹窗内容视图类型 default DialogPopTypeTable tableView列表样式
@property (nonatomic, assign) DialogPopType wPopStyleType;
/// v1.4.4 pop弹窗自定义内容视图
@property (nonatomic,   copy) DialogPopCustomBlock wPopCustomView;
/// 如果弹出视图的位置不对 设置此属性 例如继承了tableView则传入 继承的类名 default nil
@property (nonatomic,   copy) NSString* wPopNestStopView;

/// 可设置wMainOffsetY 调整弹出视图的y default 0

#pragma -mark downType
/// 图片的size
@property (nonatomic, assign) CGSize wImageSize;
/// 图片的路径
@property (nonatomic,   copy) NSString* wImageName;
/// 进度条颜色
@property (nonatomic, strong) UIColor* wProgressTintColor;
/// 进度条运动的颜色
@property (nonatomic, strong) UIColor* wTrackTintColor;


#pragma -mark muchMenuType
/// tableview的颜色
@property (nonatomic,   copy) NSArray* wTableViewColor;
/// cell文本居中样式
@property (nonatomic, assign) NSTextAlignment wTextAlignment;

#pragma -mark locationType
/// 地区的类型
@property (nonatomic, assign) DialogLocationType wLocationType;
/// 弹出的地区选择类型 pickview/tableview
@property (nonatomic, assign) ChainType wChainType;
/// 选中数据的分割符 默认‘，’
@property (nonatomic,   copy) NSString *wSeparator;
/// 默认地区的数据路径名称 default @"province_data"
@property (nonatomic,   copy) NSString *wXMLPathName;

#pragma -mark DatePickType
/// 时间弹窗的样式
@property (nonatomic,   copy) NSString *wDateTimeType;
/// 循环滚动
@property (nonatomic, assign) BOOL wPickRepeat;
/// 默认选中时间 默认此刻
@property (nonatomic, strong) NSDate *wDefaultDate;
/// 最大时间 default nil
@property (nonatomic, strong) NSDate *wMaxDate;
/// 最小时间 default nil
@property (nonatomic, strong) NSDate *wMinDate;

#pragma -mark Share/tabbarMenu/NaviMENU
/// WMZDialogShareView显示多少列 default 4
@property (nonatomic, assign) NSInteger wColumnCount;
/// WMZDialogShareView显示多少行 default 1
@property (nonatomic, assign) NSInteger wRowCount;

#pragma -mark LoadingType
/// 加载框样式
@property (nonatomic, assign) LoadingStyle wLoadingType;
/// 加载框大小 default CGSizeMake(DialogRealW(90),  DialogRealW(90));
@property (nonatomic, assign) CGSize wLoadingSize;
/// 加载框线条颜色 default DialogColor(0x108ee9);
@property (nonatomic, strong) UIColor *wLoadingColor;
/// 显示右上角关闭按钮 default NO
@property (nonatomic, assign) BOOL wShowClose;
/// 加载框线条宽度 default 2.5f
@property (nonatomic, assign) CGFloat wLoadingWidth;

#pragma -mark CardParentType
/// 滑动到顶部继续滑动可关闭 default YES
@property (nonatomic, assign) BOOL wOpenScrollClose;
/// 开启侧滑滑动关闭 default YES
@property (nonatomic, assign) BOOL wLeftScrollClose;
/// 开启拖动 default YES
@property (nonatomic, assign) BOOL wOpenDragging;
/// 缩放底部控制器 default YES
@property (nonatomic, assign) BOOL wScaleParentVC;
/// 自定义顶部视图 default nil
@property (nonatomic, assign) DiaLogPresentCallBlock wParentHeadView;
/// 自定义底部视图 default nil
@property (nonatomic,   copy) DiaLogPresentCallBlock wParentBottomView;

#pragma -mark CalanderType
/// 开启纵向滑动 default NO(横向滑动)
@property (nonatomic, assign) BOOL wDirectionVertical;
/// 开启滑动 default YES
@property (nonatomic, assign) BOOL wCalanderCanScroll;
/// 开启农历节日显示 default YES
@property (nonatomic, assign) BOOL wOpenChineseDate;
/// 隐藏日历上的按钮 default YES
@property (nonatomic, assign) BOOL wHideCalanderBtn;
/// 展示圆点的日期 携带格式为yyyy-MM-dd的日期
@property (nonatomic,   copy) NSArray *wDateShowCircle;
/// 注册自定义的collectionViewCell
@property (nonatomic,   copy) NSString *wReginerCollectionCell;
/// 开启选择多个选续区域 default YES
@property (nonatomic, assign) BOOL wOpenMultiZone;
/// cellSize default(屏幕宽度/7,屏幕宽度/7)
@property (nonatomic, assign) CGSize wCalanderCellSize;
/// 多选中间部分透明度 default 1 不透明
@property (nonatomic, assign) CGFloat wLimitAlpha;
/// 日历顶部标题数组 必须为数量 = 7 的数组
@property (nonatomic,   copy) NSArray<NSString*>* wCalanderWeekTitleArr;
/// 设置日历设置最大最小值的效果 default @[DialogCalanderLimitCloseClick]
@property (nonatomic,   copy) NSArray<DialogCalanderLimitTypeKey>* wMinMaxResultArr;
/// 是否开启wBounces 默认NO
@property (nonatomic, assign) BOOL wBounces;


#pragma -mark Event
/// 自定义tableviewCell 
@property (nonatomic,   copy) DiaLogCustomCellBlock wCustomCell;
/// 自定义点击tableviewCell
@property (nonatomic,   copy) DiaLogCellSelectlock wSelectCell;
/// 自定义弹窗视图内容
@property (nonatomic,   copy) DiaLogMyViewCallBlock wMyDiaLogView;
/// 按钮确定点击事件
@property (nonatomic,   copy) DialogClickBlock wEventOKFinish;
/// 按钮取消点击事件
@property (nonatomic,   copy) DialogClickBlock wEventCancelFinish;
/// 阴影关闭事件
@property (nonatomic,   copy) DialogClickBlock wEventShadomClose;
/// 操作完成事件
@property (nonatomic,   copy) DialogTableClickBlock wEventFinish;
/// 弹窗关闭事件
@property (nonatomic,   copy) DialogClickBlock wEventClose;
/// 菜单点击事件
@property (nonatomic,   copy) DialogMenuClickBlock wEventMenuClick;
/// 自定义日历cell
@property (nonatomic,   copy) DiaLogCollectionCellBlock wCalanderCell;
/// 自定义日历点击事件
@property (nonatomic,   copy) DiaLogCollectionClickBlock wCalanderCellClick;
/// 自定义出现动画
@property (nonatomic,   copy) DialogCustomAnimal wEventCustomShowAmimal;
/// 自定义消失动画
@property (nonatomic,   copy) DialogCustomAnimal wEventCustomHideAmimal;

#pragma -mark CustomView
/// 自定义mainView 可改变frame
@property (nonatomic,   copy) DialogCustomMainViewBlock wCustomMainView;
/// 自定义TitleLa
@property (nonatomic,   copy) DialogCustomTitle wCustomTitleLa;
/// 自定义MessageLa
@property (nonatomic,   copy) DialogCustomMessage wCustomMessageLa;
/// 自定义OKBtn
@property (nonatomic,   copy) DialogCustomOKBtn wCustomOKBtn;
/// 自定义CancelBtn
@property (nonatomic,   copy) DialogCustomCancelBtn wCustomCancelBtn;
/// 自定义closeBtn
@property (nonatomic,   copy) DialogCustomCloseBtn wCustomCloseBtn;
/// 自定义TextView
@property (nonatomic,   copy) DialogCustomTextView wCustomTextView;
/// 自定义ImageView
@property (nonatomic,   copy) DialogCustomImageView wCustomImageView;
/// 自定义tableview
@property (nonatomic,   copy) DialogCustomTableView wCustomTableView;
/// v1.4.3 自定义修改主视图阴影 非底部阴影
@property (nonatomic,   copy) DialogCustomMainShadomLayer wCustomMainShadom;
/// 自定义shareView
@property (nonatomic,   copy) DialogCustomShareView wCustomShareView;
/// 是否开启暗黑模式  外部不可调用
@property (nonatomic, assign) BOOL wOpenDark;
- (void)setUpDefaultParam;

@end

@interface WMZDialogParam : WMZDialogParentParam

@end

NS_ASSUME_NONNULL_END
