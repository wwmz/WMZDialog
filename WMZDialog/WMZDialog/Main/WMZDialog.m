//
//  WMZDialog.m
//  WMZDialog
//
//  Created by wmz on 2019/6/5.
//  Copyright © 2019年 wmz. All rights reserved.
//
#import "WMZDialog.h"
@interface WMZDialog ()
/*
 *配置
 */
@property(nonatomic,strong)NSMutableDictionary *configDic;
@end
@implementation WMZDialog
WMZDialog * Dialog(void){
    return  [WMZDialog  new];
}
- (WMZDialog * _Nonnull (^)(void))wStart{
     return ^WMZDialog*(){
         [self setUpUI:nil];
         return self;
     };
}
- (WMZDialog * _Nonnull (^)(UIView * _Nonnull))wStartView{
    return ^WMZDialog*(UIView *startView){
        [self setUpUI:startView];
        return self;
    };
}
- (void)setUpUI:(nullable UIView*)startView{
    [self setUpDefaultParam];
    [self setUpUI];
    [self setUIdelagate:startView];
    [self addNotification];
}
WMZDialogSetFuncImplementation(WMZDialog, BOOL,                    wMultipleSelection)
WMZDialogSetFuncImplementation(WMZDialog, BOOL,                    wSelectShowChecked)
WMZDialogSetFuncImplementation(WMZDialog, BOOL,                      wOpenScrollClose)
WMZDialogSetFuncImplementation(WMZDialog, BOOL,                      wLeftScrollClose)
WMZDialogSetFuncImplementation(WMZDialog, BOOL,                         wOpenDragging)
WMZDialogSetFuncImplementation(WMZDialog, BOOL,                        wScaleParentVC)
WMZDialogSetFuncImplementation(WMZDialog, BOOL,                    wDirectionVertical)
WMZDialogSetFuncImplementation(WMZDialog, BOOL,                    wCalanderCanScroll)
WMZDialogSetFuncImplementation(WMZDialog, BOOL,                      wHideCalanderBtn)
WMZDialogSetFuncImplementation(WMZDialog, BOOL,                      wOpenChineseDate)
WMZDialogSetFuncImplementation(WMZDialog, BOOL,                       wNavigationItem)
WMZDialogSetFuncImplementation(WMZDialog, BOOL,                         wShadowCanTap)
WMZDialogSetFuncImplementation(WMZDialog, BOOL,                           wShadowShow)
WMZDialogSetFuncImplementation(WMZDialog, BOOL,                           wEffectShow)
WMZDialogSetFuncImplementation(WMZDialog, BOOL,                        wAddBottomView)
WMZDialogSetFuncImplementation(WMZDialog, BOOL,                           wPickRepeat)
WMZDialogSetFuncImplementation(WMZDialog, BOOL,                         wMainToBottom)
WMZDialogSetFuncImplementation(WMZDialog, BOOL,                         wCanSelectPay)
WMZDialogSetFuncImplementation(WMZDialog, BOOL,                 wTapViewTableViewFoot)
WMZDialogSetFuncImplementation(WMZDialog, BOOL,                     wOpenCalanderRule)
WMZDialogSetFuncImplementation(WMZDialog, DiaPopInView,                  wTapViewType)
WMZDialogSetFuncImplementation(WMZDialog, NSInteger,                 wListScrollCount)
WMZDialogSetFuncImplementation(WMZDialog, NSInteger,            wTableViewSectionHead)
WMZDialogSetFuncImplementation(WMZDialog, NSArray*,                   wDateShowCircle)
WMZDialogSetFuncImplementation(WMZDialog, UIView* ,                          wTapView)
WMZDialogSetFuncImplementation(WMZDialog, NSTimeInterval,           wAnimationDurtion)
WMZDialogSetFuncImplementation(WMZDialog, UIColor*,                       wTitleColor)
WMZDialogSetFuncImplementation(WMZDialog, UIColor*,                     wMessageColor)
WMZDialogSetFuncImplementation(WMZDialog, CGFloat,                             wWidth)
WMZDialogSetFuncImplementation(WMZDialog, CGFloat,                            wHeight)
WMZDialogSetFuncImplementation(WMZDialog, CGFloat,                       wMainOffsetY)
WMZDialogSetFuncImplementation(WMZDialog, CGRect,                            wTapRect)
WMZDialogSetFuncImplementation(WMZDialog, CGFloat,                     wMainBtnHeight)
WMZDialogSetFuncImplementation(WMZDialog, CGFloat,                       wMainOffsetX)
WMZDialogSetFuncImplementation(WMZDialog, CGFloat,                    wDisappelSecond)
WMZDialogSetFuncImplementation(WMZDialog, UIColor*,                        wLineColor)
WMZDialogSetFuncImplementation(WMZDialog, NSString*,                         wOKTitle)
WMZDialogSetFuncImplementation(WMZDialog, NSString*,                     wCancelTitle)
WMZDialogSetFuncImplementation(WMZDialog, UIColor*,                          wOKColor)
WMZDialogSetFuncImplementation(WMZDialog, UIColor*,                      wCancelColor)
WMZDialogSetFuncImplementation(WMZDialog, NSString*,                           wTitle)
WMZDialogSetFuncImplementation(WMZDialog, NSString*,                         wMessage)
WMZDialogSetFuncImplementation(WMZDialog, CGFloat,                   wKeyBoardMarginY)
WMZDialogSetFuncImplementation(WMZDialog, UIColor*,                      wShadowColor)
WMZDialogSetFuncImplementation(WMZDialog, CGFloat,                            wOKFont)
WMZDialogSetFuncImplementation(WMZDialog, CGFloat,                        wCancelFont)
WMZDialogSetFuncImplementation(WMZDialog, CGFloat,                         wLineAlpha)
WMZDialogSetFuncImplementation(WMZDialog, id,                                   wData)
WMZDialogSetFuncImplementation(WMZDialog, id,                                wSonData)
WMZDialogSetFuncImplementation(WMZDialog, NSArray*,                 wListDefaultValue)
WMZDialogSetFuncImplementation(WMZDialog, CGFloat,                         wTitleFont)
WMZDialogSetFuncImplementation(WMZDialog, CGFloat,                       wMessageFont)
WMZDialogSetFuncImplementation(WMZDialog, CGFloat,                       wShadowAlpha)
WMZDialogSetFuncImplementation(WMZDialog, NSInteger,                             wTag)
WMZDialogSetFuncImplementation(WMZDialog, NSInteger,                          wPayNum)
WMZDialogSetFuncImplementation(WMZDialog, NSString*,             wDefaultSelectPayStr)
WMZDialogSetFuncImplementation(WMZDialog, UIColor*,                    wMainBackColor)
WMZDialogSetFuncImplementation(WMZDialog, CGFloat,                        wMainRadius)
WMZDialogSetFuncImplementation(WMZDialog, NSInteger,                 wWirteTextMaxNum)
WMZDialogSetFuncImplementation(WMZDialog, NSString*,                     wPlaceholder)
WMZDialogSetFuncImplementation(WMZDialog, NSInteger,                wWirteTextMaxLine)
WMZDialogSetFuncImplementation(WMZDialog, UIKeyboardType,          wWirteKeyBoardType)
WMZDialogSetFuncImplementation(WMZDialog, CGFloat,                      wPercentAngle)
WMZDialogSetFuncImplementation(WMZDialog, CGFloat,                     wPercentOrginX)
WMZDialogSetFuncImplementation(WMZDialog, CGSize,                          wImageSize)
WMZDialogSetFuncImplementation(WMZDialog, NSInteger,                     wColumnCount)
WMZDialogSetFuncImplementation(WMZDialog, NSString*,                wWriteDefaultText)
WMZDialogSetFuncImplementation(WMZDialog, NSInteger,                        wRowCount)
WMZDialogSetFuncImplementation(WMZDialog, NSString*,                       wImageName)
WMZDialogSetFuncImplementation(WMZDialog, NSString*,           wReginerCollectionCell)
WMZDialogSetFuncImplementation(WMZDialog, NSInteger,                    wLocationType)
WMZDialogSetFuncImplementation(WMZDialog, UIColor*,                wProgressTintColor)
WMZDialogSetFuncImplementation(WMZDialog, UIColor*,                   wTrackTintColor)
WMZDialogSetFuncImplementation(WMZDialog, NSArray* ,                  wTableViewColor)
WMZDialogSetFuncImplementation(WMZDialog, NSString*,                    wDateTimeType)
WMZDialogSetFuncImplementation(WMZDialog, NSTextAlignment,             wTextAlignment)
WMZDialogSetFuncImplementation(WMZDialog, CGSize,                        wLoadingSize)
WMZDialogSetFuncImplementation(WMZDialog, UIColor*,                     wLoadingColor)
WMZDialogSetFuncImplementation(WMZDialog, CGFloat,                        wCellHeight)
WMZDialogSetFuncImplementation(WMZDialog, NSString*,                       wSeparator)
WMZDialogSetFuncImplementation(WMZDialog, NSDate*,                       wDefaultDate)
WMZDialogSetFuncImplementation(WMZDialog, NSDate*,                           wMaxDate)
WMZDialogSetFuncImplementation(WMZDialog, NSDate*,                           wMinDate)
WMZDialogSetFuncImplementation(WMZDialog, CGFloat,                wPopViewBorderWidth)
WMZDialogSetFuncImplementation(WMZDialog, UIColor*,               wPopViewBorderColor)
WMZDialogSetFuncImplementation(WMZDialog, UITableViewCellSeparatorStyle,wSeparatorStyle)
WMZDialogSetFuncImplementation(WMZDialog, DialogRectCorner,        wPopViewRectCorner)
WMZDialogSetFuncImplementation(WMZDialog, DialogType,                           wType)
WMZDialogSetFuncImplementation(WMZDialog, DialogShowAnination,         wShowAnimation)
WMZDialogSetFuncImplementation(WMZDialog, DialogHideAnination,         wHideAnimation)
WMZDialogSetFuncImplementation(WMZDialog, ChainType,                       wChainType)
WMZDialogSetFuncImplementation(WMZDialog, LoadingStyle,                  wLoadingType)
WMZDialogSetFuncImplementation(WMZDialog, DiaDirection,                    wDirection)
WMZDialogSetFuncImplementation(WMZDialog, diaLogCustomCellBlock,          wCustomCell)
WMZDialogSetFuncImplementation(WMZDialog, diaLogPresentCallBlock,     wParentHeadView)
WMZDialogSetFuncImplementation(WMZDialog, diaLogPresentCallBlock,   wParentBottomView)
WMZDialogSetFuncImplementation(WMZDialog, diaLogCellSelectlock,           wSelectCell)
WMZDialogSetFuncImplementation(WMZDialog, DialogClickBlock,               wEventClose)
WMZDialogSetFuncImplementation(WMZDialog, DialogMenuClickBlock,       wEventMenuClick)
WMZDialogSetFuncImplementation(WMZDialog, diaLogMyViewCallBlock,        wMyDiaLogView)
WMZDialogSetFuncImplementation(WMZDialog, diaLogCellCallBlock,                wMyCell)
WMZDialogSetFuncImplementation(WMZDialog, DiaLogCollectionCellBlock,    wCalanderCell)
WMZDialogSetFuncImplementation(WMZDialog, DiaLogCollectionClickBlock,wCalanderCellClick)
WMZDialogSetFuncImplementation(WMZDialog, DialogClickBlock,            wEventOKFinish)
WMZDialogSetFuncImplementation(WMZDialog, DialogClickBlock,        wEventCancelFinish)
WMZDialogSetFuncImplementation(WMZDialog, DialogTableClickBlock,         wEventFinish)
WMZDialogSetFuncImplementation(WMZDialog, DialogCustomMainViewBlock,  wCustomMainView)
WMZDialogSetFuncImplementation(WMZDialog, DialogCustomTitle,           wCustomTitleLa)
WMZDialogSetFuncImplementation(WMZDialog, DialogCustomMessage,       wCustomMessageLa)
WMZDialogSetFuncImplementation(WMZDialog, DialogCustomOKBtn,             wCustomOKBtn)
WMZDialogSetFuncImplementation(WMZDialog, DialogCustomCancelBtn,     wCustomCancelBtn)
WMZDialogSetFuncImplementation(WMZDialog, DialogCustomCloseBtn,       wCustomCloseBtn)
WMZDialogSetFuncImplementation(WMZDialog, DialogCustomTextView,       wCustomTextView)
WMZDialogSetFuncImplementation(WMZDialog, DialogCustomImageView,     wCustomImageView)
WMZDialogSetFuncImplementation(WMZDialog, DialogCustomTableView,     wCustomTableView)

- (instancetype)init{
    if (self = [super init]) {
        _wType = DialogTypeNornal;
        _wWidth = Dialog_GetWNum(500);
        _wHeight = DialogHeight;
        _wAnimationDurtion = 0.5f;
        _wDisappelSecond = 1.5f;
        _wMainBtnHeight = Dialog_GetWNum(60);
        _wCellHeight = Dialog_GetWNum(80);
        _wOKTitle = @"确定";
        _wCancelTitle = @"取消";
        _wOKColor = DialogColor(0xFF9900);
        _wCancelColor = DialogColor(0x666666);
        _wMainRadius = 8.0f;
        _wMainBackColor = DialogColor(0xFFFFFF);
        _wLineColor =  DialogLineColor;
        _wTitleColor = DialogColor(0x333333);
        _wMessageColor = DialogColor(0x333333);
        _wMainOffsetY = Dialog_GetWNum(20);
        _wMainOffsetX = Dialog_GetWNum(15);
        _wLineAlpha = 0.9f;
        _wTitleFont = 14.0f;
        _wMessageFont = 16.0f;
        _wOKFont = 16.0f;
        _wCancelFont = 16.0f;
        _wTitle = @"标题";
        _wMessage = @"内容";
        _wShadowAlpha = 0.4f;
        _wShadowColor = DialogColor(0x333333);
        _wKeyBoardMarginY = Dialog_GetWNum(40);
        _wPayNum = 5;
        _wDefaultSelectPayStr = @"农业银行";
        _wShadowCanTap = YES;
        _wShadowShow = YES;
        _wWirteTextMaxNum  = -1;
        _wWirteTextMaxLine = 7;
        _wPercentAngle =  0.5f;
        _wPercentOrginX = 1.0f;
        _wDirection = directionDowm;
        _wImageSize = CGSizeMake(Dialog_GetWNum(110), Dialog_GetWNum(110));
        _wProgressTintColor = DialogColor(0xFF9900);
        _wTrackTintColor = DialogColor(0xF3F4F6);
        _wTableViewColor = @[DialogColor(0xFFFFFF),DialogColor(0xF6F7FA),DialogColor(0xEBECF0),DialogColor(0xFFFFFF)];
        _wTextAlignment = NSTextAlignmentCenter;
        _wLocationType = 3;
        _wChainType = ChainPickView;
        _wDateTimeType = @"yyyy-MM-dd HH:mm:ss";
        _wPlaceholder = @"请输入";
        _wLoadingSize = CGSizeMake(Dialog_GetWNum(90),  Dialog_GetWNum(90));
        _wLoadingColor = DialogColor(0x108ee9);
        _wSeparator = @",";
        _wLeftScrollClose = YES;
        _wOpenScrollClose = YES;
        _wOpenDragging = YES;
        _wScaleParentVC = YES;
        _wCalanderCanScroll = YES;
        _wOpenChineseDate = YES;
        _wHideCalanderBtn = YES;
        _wDefaultDate = [NSDate date];
        _wCanSelectPay = YES;
        _wPopViewBorderColor = _wMainBackColor;
        _wTapRect = CGRectZero;
        _wPopViewRectCorner = DialogRectCornerNone;
        _wOpenCalanderRule = YES;
        _wTag = 10086;
        _wListScrollCount = 8;
        _wSeparatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}
- (void)addNotification{
    //监听横竖屏
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(change:) name:UIDeviceOrientationDidChangeNotification object:nil];
}

/*
 *根据type设置默认属性
 */
- (void)setUpDefaultParam{
    
    if (self.wListDefaultValue&&[self.wListDefaultValue isKindOfClass:[NSArray class]]) {
        self.tempArr = [NSMutableArray arrayWithArray:self.wListDefaultValue];
        if (self.tempArr.count>1&&!self.wMultipleSelection) {
            NSMutableArray *temp = [NSMutableArray arrayWithObject:self.tempArr[0]];
            self.tempArr = [NSMutableArray arrayWithArray:temp];
        }
    }
    
    switch (self.wType) {
        case DialogTypeSheet:{
            if (self.wHeight == DialogHeight) {
                self.wHeight = Dialog_GetWNum(200);
            }
            self.wMainToBottom = YES;
            if (self.wWidth == Dialog_GetWNum(500)) {
                self.wWidth = Device_Dialog_Width;
            }
            if (self.wMainBtnHeight == Dialog_GetWNum(60)) {
                self.wMainBtnHeight = Dialog_GetWNum(88);
            }
        }
            break;
        case DialogTypePay:{
            if ([self.wTitle isEqualToString:@"提示"]) {
                self.wTitle = @"请输入支付密码";
            }
            if ([self.wMessage isEqualToString:@"内容"]) {
                self.wMessage = @"￥100.00";
            }
        }
        break;
        case DialogTypeShare:{
            if (self.wHeight == DialogHeight) {
                self.wHeight = Dialog_GetWNum(150);
            }
            self.wMainToBottom = YES;
            if (self.wWidth == Dialog_GetWNum(500)) {
                self.wWidth = Device_Dialog_Width;
            }
            if (self.wMainBtnHeight == Dialog_GetWNum(60)) {
                self.wMainBtnHeight+=Dialog_GetWNum(10);
            }
            if ([self.wTitle isEqualToString:@"提示"]) {
                self.wTitle = @"分享到";
            }
            if (!self.wColumnCount) {
                self.wColumnCount = 4;
            }
            if (!self.wRowCount) {
                self.wRowCount = 2;
            }
            self.wShowAnimation = AninatonShowNone;
        }
        break;
        case DialogTypePickSelect:{
            self.wMainToBottom = YES;

            if (self.wWidth == Dialog_GetWNum(500)) {
                self.wWidth = Device_Dialog_Width;
            }
        }
        break;
        case DialogTypePop:
        {
             if (self.wWidth == Dialog_GetWNum(500)) {
                  self.wWidth = Dialog_GetWNum(300);
              }
              self.wTextAlignment = NSTextAlignmentLeft;
        }
            break;
        case DialogTypeMenusSelect:
        {
            if (self.wHeight == DialogHeight) {
                self.wHeight = self.wCellHeight*3;
            }
            self.wMainToBottom = YES;
    
            if (self.wWidth == Dialog_GetWNum(500)) {
                self.wWidth = Device_Dialog_Width;
            }
        }
            break;
        case DialogTypeAdvertisement:
        {
            self.wMainBackColor = [UIColor clearColor];
            self.wShadowCanTap = NO;
        }
            break;
        case DialogTypeLocation:
        {
            
            self.wTextAlignment = NSTextAlignmentLeft;
            if (self.wHeight == DialogHeight) {
                if (self.wChainType == ChainTableView) {
                    self.wHeight = self.wCellHeight*3;
                }
            }
            self.wMainToBottom = YES;
            if (self.wWidth == Dialog_GetWNum(500)) {
                self.wWidth = Device_Dialog_Width;
            }
        }
            break;
        case DialogTypeDatePicker:
        {
            self.wMainToBottom = YES;
            if (self.wWidth == Dialog_GetWNum(500)) {
                self.wWidth = Device_Dialog_Width;
            }
        }
            break;
        case DialogTypeTabbarMenu:
        {
            if (self.wHeight == DialogHeight) {
                self.wHeight = Dialog_GetWNum(150);
            }
            self.wMainToBottom = YES;

            if (self.wWidth == Dialog_GetWNum(500)) {
                self.wWidth = Device_Dialog_Width;
            }
            if (self.wMainBtnHeight == Dialog_GetWNum(60)) {
                self.wMainBtnHeight+=Dialog_GetWNum(10);
            }
            if (!self.wColumnCount) {
                self.wColumnCount = 4;
            }
            if (!self.wRowCount) {
                self.wRowCount = 1;
            }
            self.wShowAnimation = AninatonShowNone;
            self.wEffectShow = YES;
        }
            break;
        case DialogTypeNaviMenu:
        {
            if (self.wHeight == DialogHeight) {
                self.wHeight = Dialog_GetWNum(150);
            }
            self.wMainToBottom = YES;

            if (self.wWidth == Dialog_GetWNum(500)) {
                self.wWidth = Device_Dialog_Width;
            }
            if (self.wMainBtnHeight == Dialog_GetWNum(60)) {
                self.wMainBtnHeight+=Dialog_GetWNum(10);
            }
            if (!self.wColumnCount) {
                self.wColumnCount = 3;
            }
            if (!self.wRowCount) {
                self.wRowCount = 2;
            }
            self.wShowAnimation = AninatonShowNone;
        }
            break;
        case DialogTypeLoading:{
            self.wShadowAlpha = 0.2;
            self.wWidth = self.wLoadingSize.width*1.5;
        }
             break;
        case DialogTypeAuto:{
            if (self.wWidth == Dialog_GetWNum(500)) {
                self.wWidth = Dialog_GetWNum(400);
            }
            self.wShadowShow = NO;
            if ([WMZDialogTool isEqualToColor:self.wMainBackColor anotherColor:DialogColor(0xFFFFFF)]) {
                self.wMainBackColor = DialogColor(0x333333);
            }
            if ([WMZDialogTool isEqualToColor:self.wMessageColor anotherColor:DialogColor(0x333333)]) {
                self.wMessageColor = DialogColor(0xffffff);
            }
        }
            break;
        case DialogTypeCardPresent:{
            self.wMainToBottom = YES;
            if (self.wWidth == Dialog_GetWNum(500)) {
                self.wWidth = Device_Dialog_Width;
            }
            if (self.wHeight == DialogHeight) {
                self.wHeight = Device_Dialog_Height-NavigationBar_Dialog_Height;
            }
            if (self.wAnimationDurtion == 0.5f) {
                self.wAnimationDurtion = 0.3;
            }
            if (self.wHeight> (Device_Dialog_Height - ([[UIApplication sharedApplication] statusBarFrame].size.height)) ) {
                self.wHeight = (Device_Dialog_Height - ([[UIApplication sharedApplication] statusBarFrame].size.height));
            }
        }
            break;
        case DialogTypeCalander:{
            if (self.wWidth == Dialog_GetWNum(500)) {
                self.wWidth = Device_Dialog_Width;
            }
        }
            break;
        case  DialogTypeMyView:{
            if (self.wHeight == DialogHeight) {
                self.wHeight = 0;
            }
            break;
        }
        case DialogTypeNornal:
             DialogTypeSelect:
             DialogTypeWrite:
             DialogTypeTime:
             DialogTypeDown:
             break;
        default:
            break;
    }
    if (self.wHeight > Device_Dialog_Height&&self.wType!=DialogTypeCardPresent) {
        self.wHeight = Device_Dialog_Height;
    }
    if (self.wWidth > Device_Dialog_Width) {
        self.wWidth = Device_Dialog_Width;
    }
}

/*
 *UI赋值
 */
- (void)setUpUI{
    self.backgroundColor = [UIColor clearColor];
    self.frame = CGRectMake(0, 0, Device_Dialog_Width, Device_Dialog_Height);
    if (self.wType == DialogTypePay || self.wType == DialogTypeWrite) {
        //监听键盘出现
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        //监听键盘出现
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    if (self.wType != DialogTypeShare&&
        self.wType != DialogTypeMyView&&
        self.wType != DialogTypeTabbarMenu&&
        self.wType != DialogTypeDatePicker&&
        self.wType != DialogTypePickSelect&&
        self.wType != DialogTypeSheet&&
        self.wType != DialogTypePop&&
        self.wType != DialogTypeMenusSelect&&
        self.wType != DialogTypeLocation&&
        self.wType != DialogTypeAdvertisement&&
        self.wType != DialogTypeCardPresent) {
        self.mainView.layer.cornerRadius = self.wMainRadius;
        self.mainView.layer.masksToBounds = YES;
    }
    self.titleLabel.text = _wTitle;
    self.titleLabel.font = [UIFont systemFontOfSize:_wTitleFont];
    self.titleLabel.textColor =  _wTitleColor;

    self.textLabel.text = _wMessage;
    self.textLabel.font = [UIFont systemFontOfSize:_wMessageFont];
    self.textLabel.textColor =  _wMessageColor;
    
    [self.cancelBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.cancelBtn setTitle:_wCancelTitle forState:UIControlStateNormal];
    self.cancelBtn.titleLabel.font = [UIFont systemFontOfSize:_wCancelFont];
    [self.cancelBtn setTitleColor:_wCancelColor forState:UIControlStateNormal];
    self.cancelBtn.backgroundColor = _wMainBackColor;
    
    [self.OKBtn setTitle:_wOKTitle forState:UIControlStateNormal];
    [self.OKBtn setTitleColor:_wOKColor forState:UIControlStateNormal];
    self.OKBtn.titleLabel.font = [UIFont systemFontOfSize:_wOKFont];
    self.OKBtn.backgroundColor = _wMainBackColor;
    [self.OKBtn addTarget:self action:@selector(OKAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.wCloseBtn addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
    [self.wCloseBtn setTitle:@"X" forState:UIControlStateNormal];
    [self.wCloseBtn setTitleColor:self.wCancelColor forState:UIControlStateNormal];
    self.wCloseBtn.backgroundColor = self.wMainBackColor;
    self.wCloseBtn.layer.borderWidth = DialogK1px;
    self.wCloseBtn.layer.borderColor = self.wCancelColor.CGColor;
    
    self.mainView.frame = CGRectMake(0, 0, self.wWidth, Dialog_GetWNum(267));
    self.mainView.backgroundColor = _wMainBackColor;
    
    self.shadowView.frame = self.bounds;
    self.shadowView.backgroundColor = _wShadowColor;
    self.shadowView.alpha = _wShadowAlpha;
    
    if (self.wShadowCanTap) {
        self.shadowView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeView)];
        [self.shadowView addGestureRecognizer:tap];
    }
}

//设置UI代理
- (void)setUIdelagate:(nullable UIView*)showView{
    if (self.wType == DialogTypeSelect ||
        self.wType == DialogTypeSheet ||
        self.wType == DialogTypePop||
        self.wType == DialogTypeCardPresent) {
        if (self.wData&&([self.wData isKindOfClass:[NSArray class]]||[self.wData isKindOfClass:[NSMutableArray class]])) {
            self.tableView.delegate = self;
            self.tableView.dataSource = self;
            self.tableView.estimatedRowHeight = 100;
            self.tableView.separatorStyle = self.wSeparatorStyle;;
            if (@available(iOS 11.0, *)) {
                self.tableView.estimatedSectionFooterHeight = 0.01;
                self.tableView.estimatedSectionHeaderHeight = 0.01;
                self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            }
            if (self.wType == DialogTypeCardPresent) {
                self.tableView.wOpenScrollClose = self.wOpenScrollClose;
                self.tableView.wCardPresent = (self.wType == DialogTypeCardPresent);
            }
        }

        if ([self.wData count]>self.wListScrollCount) {
            self.tableView.scrollEnabled = YES;
        }else{
            self.tableView.scrollEnabled = NO;
        }
    }
    
    if (self.wType == DialogTypePickSelect) {
        if (self.wData&&([self.wData isKindOfClass:[NSArray class]]||[self.wData isKindOfClass:[NSMutableArray class]])) {
            self.pickView.delegate = self;
            self.pickView.dataSource = self;
        }
    }
    
    if (self.wType == DialogTypeLocation||self.wType == DialogTypeDatePicker) {
        self.pickView.delegate = self;
        self.pickView.dataSource = self;
    }
    
    [self addSubview:self.mainView];
    
    if (self.wMyDiaLogView) {
        [self showView:showView];
        UIView *bottomView = self.wMyDiaLogView(self.mainView);
        [self.mainView layoutIfNeeded];
        [bottomView layoutIfNeeded];
        BOOL customHeight = (self.wHeight>0);
        if (self.wAddBottomView) {
            UIView *addBottomView  = [self addBottomView:CGRectGetMaxY(bottomView.frame)+self.wMainOffsetY];
            [self reSetMainViewFrame:CGRectMake(0, 0, self.wWidth, customHeight?self.wHeight:(CGRectGetMaxY(addBottomView.frame)+self.wMainOffsetY))];
        }else{
            
            [self reSetMainViewFrame:CGRectMake(0, 0, self.wWidth, customHeight?self.wHeight:CGRectGetMaxY(bottomView.frame))];
        }
    }else{
        SEL sel = NSSelectorFromString(self.configDic[@(self.wType)]);
        if (!sel) return;
        SuppressPerformSelectorLeakWarning(
                                           [self performSelector:sel];
                                           [self performSelector:@selector(showView:) withObject:showView];
                                           );
    }
}
/*
 *开始
 */
- (void)showView:(nullable UIView*)showView{
    DialogWeakSelf(self);
    UIView *view = showView?:[UIApplication sharedApplication].keyWindow;
    if (self.wTag) {
        self.tag = self.wTag;
        if ([view viewWithTag:self.wTag]) return;
    }
    [view addSubview:self];
    if (self.wShowAnimation != AninatonShowNone ) {
        self.userInteractionEnabled = NO;
    }
    if (self.wEffectShow) {
        [self addSubview:self.effectView];
        self.shadowView.backgroundColor = [UIColor clearColor];
        [self sendSubviewToBack:self.effectView];
    }
    if (self.wShadowShow) {
        [self insertSubview:self.shadowView  belowSubview:self.mainView];
    }
    [self bringSubviewToFront:self.mainView];
    [self setParentVCView:0.9];
    [self dealAnamtionShowWithView:self.mainView withType:self.wShowAnimation withTime:self.wAnimationDurtion block:^{
        weakObject.userInteractionEnabled = YES;
    }];
}
/*
*关闭
*/
- (void)closeView:(nullable animalBlock)block{
    self.close = YES;
    if (self.wType == DialogTypePay || self.wType == DialogTypeWrite) {
        [self.mainView endEditing:YES];
    }
    __weak WMZDialog *weak = self;
    if (self.wType == DialogTypeShare||self.wType == DialogTypeTabbarMenu||self.wType == DialogTypeNaviMenu) {
        WMZDialogAnimation *animation = [WMZDialogAnimation new];
        if (self.wEffectShow) {
            [UIView animateWithDuration:self.wAnimationDurtion animations:^{
                self.effectView.alpha = 0;
            }];
        }
        if (self.wShadowShow) {
            [UIView animateWithDuration:self.wAnimationDurtion animations:^{
                self.shadowView.alpha = 0;
            }];
        }
        for (UIView *view in [self.mainView subviews]) {
            if (view.tag!=10086) {
                [UIView animateWithDuration:self.wAnimationDurtion animations:^{
                    view.alpha = 0;
                }];
            }
        }
        [animation rotationClockwiseAnimationWithView:self.wCloseBtn duration:self.wAnimationDurtion];
        animation.block = ^{
            [weak.wCloseBtn removeFromSuperview];
        };
        UIScrollView *sc = [self.mainView viewWithTag:10086];
        springHideAnimation(sc, self.wAnimationDurtion, [sc subviews], ^{
           if (weak.wEventClose) {
               weak.wEventClose(@"关闭", nil);
           }
            if (block) {
                block();
            }
            [weak removeFromSuperview];
        });
        
    }else{
        [self closeAction:block];
    }
    [self setParentVCView:1.0];
}

/*
 *关闭
 */
- (void)closeView{
    [self closeView:nil];
}
- (void)closeAction:(animalBlock)block{
    __weak WMZDialog *weakSelf = self;
    self.userInteractionEnabled = NO;
    if (self.wHideAnimation) {
         if (self.wShadowShow) {
             [UIView animateWithDuration:self.wAnimationDurtion animations:^{
                 self.shadowView.alpha = 0;
             }];
        }
        [self dealAnamtionHideWithView:self.mainView withType:self.wHideAnimation withTime:self.wAnimationDurtion block:^{
            if (weakSelf.wEventClose) {
                weakSelf.wEventClose(@"关闭", nil);
            }
            if (block) {
                block();
            }
            [weakSelf removeFromSuperview];
        }];
    }else{
         if (block) {
             block();
         }
         if (self.wEventClose) {
             self.wEventClose(@"关闭", nil);
         }
        [self removeFromSuperview];
    }
    
}
/*
 *缩放底部控制器
 */
- (void)setParentVCView:(CGFloat)scale{
    if (!self.wScaleParentVC) return;
    if (self.wType != DialogTypeCardPresent) return;
    [UIView animateWithDuration:0.3 animations:^{
        UIViewController *VC = [WMZDialogTool getCurrentVC];
        if (VC.navigationController) {
            VC.navigationController.view.transform = CGAffineTransformMakeScale(scale, scale);
        }else{
            VC.view.transform = CGAffineTransformMakeScale(scale, scale);
        }
    }];
}
/*
 *重新设置mainView的frame
 */
- (void)reSetMainViewFrame:(CGRect)frame{
    CGPoint center = CGPointZero;
    if (self.wMainToBottom) {
        frame.origin.y = Device_Dialog_Height- CGRectGetMaxY(frame);
        if (isIphoneX) {
            frame.origin.y -= 15;
            frame.size.height += 15;
            UIView *view =  [UIView new];
            view.backgroundColor = self.mainView.backgroundColor;
            view.frame = CGRectMake(frame.origin.x, frame.size.height-10, frame.size.width, 10);
            [self.mainView addSubview:view];
        }
        self.mainView.frame =frame;
        center = CGPointMake(self.center.x, self.mainView.center.y);
        
    }else{
        center = self.center;
        self.mainView.frame =frame;
    }
    self.mainView.center = center;
    if (self.wCustomTitleLa) {
        self.wCustomTitleLa(self.titleLabel);
    }
    if (self.wCustomMessageLa) {
        self.wCustomTitleLa(self.textLabel);
    }
    if (self.wCustomOKBtn) {
        self.wCustomOKBtn(self.OKBtn);
    }
    if (self.wCustomCancelBtn) {
        self.wCustomCancelBtn(self.cancelBtn);
    }
    if (self.wCustomCloseBtn) {
        self.wCustomCloseBtn(self.wCloseBtn);
    }
    if (self.wCustomMainView) {
        self.wCustomMainView(self.mainView);
    }
    if (self.wCustomTableView) {
        self.wCustomTableView(self.tableView);
    }
}
/*
 *添加底部
 */
- (UIView*)addBottomView:(CGFloat)maxY{
    if (self.bottomView) {
        CGRect rect = self.bottomView.frame;
        rect.origin.y = maxY;
        self.bottomView.frame = rect;
        return self.bottomView;
    }
    
    self.bottomView = [UIView new];
    [self.mainView addSubview:self.bottomView];
    
    UIView *upLine = [UIView new];
    upLine.alpha = self.wLineAlpha;
    [self.bottomView addSubview:upLine];
    upLine.backgroundColor = self.wLineColor;
    upLine.frame = CGRectMake(0, 0, self.wWidth, DialogK1px);
    
    if (self.wEventCancelFinish) {
        [self.bottomView addSubview:self.cancelBtn];
        self.cancelBtn.frame = CGRectMake(0, CGRectGetMaxY(upLine.frame)+self.wMainOffsetX, self.wWidth/2-DialogK1px/2, self.wMainBtnHeight);
        
        UIView *Line = [UIView new];
        Line.alpha = self.wLineAlpha;
        Line.tag = 11111;
        [self.bottomView addSubview:Line];
        Line.backgroundColor = self.wLineColor;
        Line.frame = CGRectMake(CGRectGetMaxX(self.cancelBtn.frame), self.cancelBtn.frame.origin.y, DialogK1px, self.wMainBtnHeight);
    }
    
    [self.bottomView addSubview:self.OKBtn];
    self.OKBtn.frame = CGRectMake(self.wEventCancelFinish?CGRectGetMaxX(self.cancelBtn.frame)+DialogK1px:0, CGRectGetMaxY(upLine.frame)+self.wMainOffsetX,self.wEventCancelFinish?self.wWidth/2-DialogK1px/2:self.wWidth, self.wMainBtnHeight);
    
    CGSize OKSize = [WMZDialogTool sizeForTextView:CGSizeMake(self.wWidth - self.wMainOffsetX, CGFLOAT_MAX) text:self.wOKTitle font:self.wOKFont];
    CGSize cancelSize ;
    if (self.wEventCancelFinish) {
        cancelSize = [WMZDialogTool sizeForTextView:CGSizeMake(self.wWidth - self.wMainOffsetX, CGFLOAT_MAX) text:self.wCancelTitle font:self.wCancelFont];
    }
    if (OKSize.width >self.OKBtn.frame.size.width - self.wMainOffsetX||
        cancelSize.width >self.OKBtn.frame.size.width - self.wMainOffsetX) {
        UIView *line = [self.bottomView viewWithTag:11111];
        if (self.wEventCancelFinish) {
            self.cancelBtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
            self.cancelBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
            self.cancelBtn.frame = CGRectMake(self.wMainOffsetX, CGRectGetMaxY(upLine.frame)+self.wMainOffsetX, self.wWidth  - self.wMainOffsetX*2, cancelSize.height);
            if (line) {
                line.frame = CGRectMake(0, CGRectGetMaxY(self.cancelBtn.frame)+self.wMainOffsetX, self.wWidth, DialogK1px);
            }
        }
        self.OKBtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.OKBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.OKBtn.frame = CGRectMake(self.wMainOffsetX, self.wEventCancelFinish?(CGRectGetMaxY(line.frame)+self.wMainOffsetX): (CGRectGetMaxY(upLine.frame)+self.wMainOffsetX),self.wWidth - self.wMainOffsetX*2, OKSize.height);
    }
    
    self.bottomView.frame = CGRectMake(0, maxY, self.wWidth, CGRectGetMaxY(self.OKBtn.frame)+self.wMainOffsetX);
    return self.bottomView;
}
/*
 *添加顶部
 */
- (UIView*)addTopView{
    if (self.diaLogHeadView) return self.diaLogHeadView;
    CGFloat btnWidth = 50;
    self.diaLogHeadView = [UIView new];
    self.diaLogHeadView.backgroundColor = self.wMainBackColor;
    self.diaLogHeadView.frame = CGRectMake(0, 0, self.wWidth, self.wMainBtnHeight+self.wMainOffsetY);
    [self.mainView addSubview:self.diaLogHeadView];
          
    [self.diaLogHeadView addSubview:self.cancelBtn];
    self.cancelBtn.frame = CGRectMake(self.wMainOffsetX, self.wMainOffsetY/2, btnWidth, self.wMainBtnHeight);
    self.cancelBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
          
    [self.diaLogHeadView addSubview:self.OKBtn];
    [self.OKBtn removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
    self.OKBtn.frame = CGRectMake(self.wWidth-btnWidth-self.wMainOffsetX, self.wMainOffsetY/2,btnWidth, self.wMainBtnHeight);
    self.OKBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
          
    [self.diaLogHeadView addSubview:self.titleLabel];
    self.titleLabel.frame = CGRectMake(btnWidth+2*self.wMainOffsetX, self.wMainOffsetY/2, self.wWidth-2*btnWidth-4*self.wMainOffsetX, self.wMainBtnHeight);
    
    
    UIView *line = [UIView new];
    line.backgroundColor = DialogLineColor;
    line.frame = CGRectMake(0, self.diaLogHeadView.frame.size.height, self.diaLogHeadView.frame.size.width, DialogK1px);
    [self.diaLogHeadView addSubview:line];
    return self.diaLogHeadView;
}

# pragma  mark tableView 代理
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{return nil;}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{return nil;}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{return 0.01;}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{return 0.01;}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.wType == DialogTypeMenusSelect || self.wType == DialogTypeLocation?[[self getMyDataArr:tableView.tag withType:0] count]:[self.wData count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    id data = (self.wType == DialogTypeMenusSelect || self.wType == DialogTypeLocation?[self getMyDataArr:tableView.tag withType:0]:self.wData)[indexPath.row];
    BOOL isSelect = NO;
    if (![data isKindOfClass:[WMZTree class]]) {
        for (int i = 0; i<self.tempArr.count; i++) {
            id obj = self.tempArr[i];
            if (([obj isKindOfClass:[NSNumber class]]&&([obj intValue] == indexPath.row))||
                ([obj isKindOfClass:[NSIndexPath class]]&&indexPath.row == [(NSIndexPath*)obj row])||
                ([obj isKindOfClass:[NSString class]]&&[data isKindOfClass:[NSDictionary class]]&&
                [data[@"id"] isEqualToString:obj])||
                (([data isEqual:obj]))) {
                isSelect = YES;
                if ([self.selectArr indexOfObject:data] == NSNotFound) {
                    [self.selectArr addObject:data];
                }
                if ([self.pathArr indexOfObject:indexPath] == NSNotFound) {
                    [self.pathArr addObject:indexPath];
                }
                break;
             }
        }
    }
    if (self.wCustomCell) {
        return self.wCustomCell(indexPath,self.tableView,data,isSelect);
    }
    if (self.wMyCell) {
        return self.wMyCell(indexPath,self.tableView,data);
    }
    DialogCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DialogCell"];
    if (!cell) {
        cell = [[DialogCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DialogCell"];
    }
    cell.backgroundColor = [UIColor whiteColor];
    cell.tintColor = self.wOKColor;
    cell.textLabel.textAlignment = self.wTextAlignment;
    cell.textLabel.font = [UIFont systemFontOfSize:self.wMessageFont];
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    if ([data isKindOfClass:[WMZTree class]]) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        WMZTree *selectDic = (WMZTree*)data;
        cell.textLabel.text = selectDic.name;
        if (self.wTableViewColor.count>self.depth-1) {
             cell.backgroundColor = self.wTableViewColor[selectDic.depth-1];
        }
        if (selectDic.isSelected) {
            cell.textLabel.textColor = self.wOKColor;
            cell.accessoryType = self.wSelectShowChecked?UITableViewCellAccessoryCheckmark:UITableViewCellAccessoryNone;
        }else{
            cell.textLabel.textColor = self.wMessageColor;
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }else{
        if([data isKindOfClass:[NSDictionary class]]){
            NSString *iconStr = data[@"image"];
            BOOL hasImage = NO;
            if (iconStr&&[iconStr isKindOfClass:[NSString class]]&&iconStr.length) {
                hasImage = YES;
            }
            UIImage *icon = [UIImage imageNamed:iconStr?:@" "];
            cell.imageView.image = icon;
            CGSize itemSize = CGSizeMake(hasImage?30:0, 30);
            UIGraphicsBeginImageContextWithOptions(itemSize, NO, 0.0);
            CGRect imageRect = CGRectMake(0, 0, itemSize.width, itemSize.height);
            [icon drawInRect:imageRect];
            cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            cell.textLabel.text = data[@"name"]?:@"";
            cell.textLabel.textColor =  isSelect?self.wOKColor:self.wMessageColor;
        }else if([data isKindOfClass:[NSString class]]){
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (isSelect) {
                cell.accessoryType = self.wSelectShowChecked?UITableViewCellAccessoryCheckmark:UITableViewCellAccessoryNone;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.textLabel.textColor = self.wOKColor;
            }else{
                cell.accessoryType = UITableViewCellAccessoryNone;
                cell.textLabel.textColor = self.wMessageColor;
            }
            cell.textLabel.text = data;
        }
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{return self.wCellHeight?:UITableViewAutomaticDimension;}//为0则自动计算高度
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    id data = (self.wType == DialogTypeMenusSelect || self.wType == DialogTypeLocation?[self getMyDataArr:tableView.tag withType:0]:self.wData)[indexPath.row];
    if (self.wSelectCell) {
        self.wSelectCell(indexPath,tableView,data);return;
    }
    BOOL isSelect = NO;
    NSInteger index = NSNotFound;
    for (int i = 0; i<self.tempArr.count; i++) {
        id obj = self.tempArr[i];
        if (([obj isKindOfClass:[NSNumber class]]&&([obj intValue] == indexPath.row))||
            ([obj isKindOfClass:[NSIndexPath class]]&&indexPath.row == [(NSIndexPath*)obj row])||
            ([obj isKindOfClass:[NSString class]]&&[data isKindOfClass:[NSDictionary class]]&&
            [data[@"id"] isEqualToString:obj])||
            (([data isEqual:obj]))) {
            isSelect = YES;
            index = i;
            break;
         }
    }
    if (isSelect&&self.wMultipleSelection) {
        [self.tempArr removeObjectAtIndex:index];
        [self.selectArr removeObjectAtIndex:index];
        [self.pathArr removeObjectAtIndex:index];
    }
    if (!isSelect) {
        if (!self.wMultipleSelection) {
            [self.tempArr removeAllObjects];
            [self.selectArr removeAllObjects];
            [self.pathArr removeAllObjects];
        }
        [self.tempArr addObject:indexPath];
        [self.selectArr addObject:data];
        [self.pathArr addObject:indexPath];
    }
    if (self.wType == DialogTypeMenusSelect || self.wType == DialogTypeLocation) {
        [self selectWithTableView:tableView withIndexPath:indexPath];
    }else{
        [self.tableView reloadData];
        if (!self.wMultipleSelection) {
            if (self.wType != DialogTypeCardPresent) {
                DialogWeakSelf(self)
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [weakObject closeView:^{
                           if (weakObject.wEventFinish) {
                               weakObject.wEventFinish(data, indexPath,weakObject.wType);
                           }
                       }];
                });
            }
        }
    }
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.wType != DialogTypeCardPresent || scrollView != self.tableView || !self.wOpenScrollClose) return;
    if (self.tableView.contentOffset.y<=0) {
        scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, 0);
    }
}
# pragma  mark pickView 代理
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return self.tree?self.depth:[self.wData count];
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.tree?[[self getMyDataArr:component+100 withType:0] count]*(self.wPickRepeat?pickViewCount:1):[self.wData[component] count]*(self.wPickRepeat?pickViewCount:1);
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSArray *arr = self.tree?[self getMyDataArr:component+100 withType:0]:self.wData[component];
    id data = arr[row%arr.count];
    if ([data isKindOfClass:[WMZTree class]]) {
        WMZTree *selectDic = (WMZTree*)data;
        return selectDic.name;
    }
    return data;
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        pickerLabel.font = [UIFont systemFontOfSize:self.wMessageFont];
    }
    pickerLabel.textColor = self.wMessageColor;
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return self.wMainBtnHeight;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if(self.wType == DialogTypeDatePicker){
        NSCharacterSet* nonDigits =[[NSCharacterSet decimalDigitCharacterSet] invertedSet];
        //符合年月日的才改变天数
        if (component == 0) {
            if ([self.wDateTimeType rangeOfString:@"dd"].location != NSNotFound &&
                [self.wDateTimeType rangeOfString:@"yyyy"].location!= NSNotFound &&
                [self.wDateTimeType rangeOfString:@"MM"].location!= NSNotFound ) {
                if ([self.wData count]>2) {
                    NSArray *yearArr = self.wData[component];
                    int year =[[yearArr[self.wPickRepeat?row%yearArr.count:row] stringByTrimmingCharactersInSet:nonDigits] intValue];
                    NSArray *monthArr = self.wData[component+1];
                    NSInteger monthIndex = [self.pickView selectedRowInComponent:component+1];
                    int month =[[monthArr[self.wPickRepeat?monthIndex%monthArr.count:monthIndex] stringByTrimmingCharactersInSet:nonDigits] intValue];
                    NSArray *arr = @[@(year),@(month)];
                    
                    SuppressPerformSelectorLeakWarning(
                        self.wData[2] = [self performSelector:NSSelectorFromString(@"timeDayWithArr:Data:") withObject:arr withObject:@{}];
                    );
                    [self.pickView reloadComponent:2];
                }
            }
        }
        if (component == 1) {
            if ([self.wDateTimeType rangeOfString:@"dd"].location != NSNotFound&&
                [self.wDateTimeType rangeOfString:@"yyyy"].location != NSNotFound&&
                [self.wDateTimeType rangeOfString:@"MM"].location != NSNotFound) {
                if ([self.wData count]>2) {
                    NSArray *yearArr = self.wData[component-1];
                    NSInteger yearIndex = [self.pickView selectedRowInComponent:component-1];
                    int year =[[yearArr[self.wPickRepeat?yearIndex%yearArr.count:yearIndex] stringByTrimmingCharactersInSet:nonDigits] intValue];
                    NSArray *monthArr = self.wData[component];
                    int month =[[monthArr[self.wPickRepeat?row%monthArr.count:row] stringByTrimmingCharactersInSet:nonDigits] intValue];
                    NSArray *arr = @[@(year),@(month)];
                    SuppressPerformSelectorLeakWarning(
                        self.wData[2] = [self performSelector:NSSelectorFromString(@"timeDayWithArr:Data:") withObject:arr withObject:@{}];
                    );
                    [self.pickView reloadComponent:2];
                }
            }
        }
        SuppressPerformSelectorLeakWarning(
             [self performSelector:NSSelectorFromString(@"updateTime:component:") withObject:@(row) withObject:@(component)];
        );
        return;
    }
    if (self.tree) {
        NSMutableArray *dataArr = [self getMyDataArr:component+100 withType:0];
        if (component<self.depth-1) {
            for (int i = 0 ; i<dataArr.count; i++) {
                WMZTree *tree = dataArr[i];
                if (i == row%dataArr.count) {
                    tree.isSelected = YES;
                }else{
                    tree.isSelected = NO;
                }
            }
            WMZTree *selectTree =  dataArr[self.wPickRepeat?row%dataArr.count:row];
            //下一级选中全变为NO
            for (WMZTree *tree in selectTree.children) {
                tree.isSelected = NO;
            }
            [self.pickView reloadComponent:component+1];
            [pickerView selectRow:0 inComponent:component+1 animated:YES];
            if (component == 0 && self.depth >= 3 && self.wType == DialogTypeLocation) {
                [self.pickView reloadComponent:component+2];
                [pickerView selectRow:0 inComponent:component+2 animated:YES];
            }
        }else{
            for (int i = 0 ; i<dataArr.count; i++) {
                WMZTree *tree = dataArr[i];
                if (i == (self.wPickRepeat?row%dataArr.count:row)) {
                    tree.isSelected = YES;
                }else{
                    tree.isSelected = NO;
                }
            }
            [self.pickView reloadComponent:component];
        }
    }
}
//数据处理  type 1返回tree对象
- (id)getMyDataArr:(NSInteger )tableViewTag withType:(NSInteger)type{
    if (tableViewTag==100) {
        return type?self.tree:self.tree.children;
    }else{
        NSInteger taNum = 100;
        WMZTree *resultDic = nil;
        while (taNum < tableViewTag) {
            NSMutableArray *arr = (taNum == 100?self.tree.children:resultDic.children);
            NSInteger selectLastIndex = 0;
            for (int i = 0; i<arr.count; i++) {
                WMZTree *tree = arr[i];
                if (tree.isSelected) {
                    selectLastIndex = i;
                    break;
                }
            }
            if (arr.count) {
                resultDic = arr[selectLastIndex];
            }
            taNum++;
        }
        return  type?resultDic:resultDic.children;
    }
}
/*
 *键盘将要出现
 */
- (void)keyboardWillShow:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    CGRect endFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.keyBoardHeight = endFrame.size.height;
    CGRect frame = self.mainView.frame;
    frame.origin.y = Device_Dialog_Height-(endFrame.size.height+self.mainView.frame.size.height+DialogK1px+self.wKeyBoardMarginY);
    self.mainView.frame = frame;
}
/*
 *键盘将要消失
 */
- (void)keyboardWillHide:(NSNotification *)notification{
    self.keyBoardHeight = 0;
    self.mainView.center = self.center;
}
/*
 *取消
 */
- (void)cancelAction:(UIButton*)btn{
    DialogWeakSelf(self)
    [self closeView:^{
        if (weakObject.wEventCancelFinish) {
            weakObject.wEventCancelFinish(@"取消",nil);
        }
    }];
}
/*
 *确定
 */
- (void)OKAction:(UIButton*)btn{
    DialogWeakSelf(self)
    [self closeView:^{
        if (weakObject.wEventOKFinish) {
            weakObject.wEventOKFinish(@"确定",nil);
        }
    }];
}
/*
 *横竖屏通知
 */
-(void)change:(NSNotification*)notification
{
    NSMutableArray *marr = [NSMutableArray new];
    [marr addObject:self];
    while (marr.count) {
        UIView *view = marr.firstObject;
        [marr removeLastObject];
        if (view.subviews.count) {
            for (UIView *sonView in view.subviews) {
                 [sonView removeFromSuperview];
                 [marr addObject:sonView];
             }
        }
    }
    [self removeFromSuperview];
    [self performSelector:@selector(setUpUI:) withObject:self.superview afterDelay:0.001];
}

- (NSMutableDictionary *)configDic{
    if (!_configDic) {
        NSDictionary *dic = @{
            @(DialogTypeNornal):@"normalAction",
            @(DialogTypeSheet):@"sheetAction",
            @(DialogTypeAuto):@"autoDisappealAction",
            @(DialogTypePay):@"payAction",
            @(DialogTypeShare):@"shareAction",
            @(DialogTypeWrite):@"writeAction",
            @(DialogTypeTime):@"timeAction",
            @(DialogTypeSelect):@"selectAction",
            @(DialogTypeDown):@"downAction",
            @(DialogTypePop):@"popViewAction",
            @(DialogTypePickSelect):@"pickAction",
            @(DialogTypeMenusSelect):@"menusSelectAction",
            @(DialogTypeAdvertisement):@"advertisementAction",
            @(DialogTypeLocation):@"locationAction",
            @(DialogTypeDatePicker):@"datePickerAction",
            @(DialogTypeTabbarMenu):@"tabbarMenuAction",
            @(DialogTypeNaviMenu):@"naviMenuAction",
            @(DialogTypeLoading):@"loadingAction",
            @(DialogTypeCardPresent):@"cardPresentAction",
            @(DialogTypeCalander):@"calanderAction",
        };
        _configDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    }
    return _configDic;
}
@end
