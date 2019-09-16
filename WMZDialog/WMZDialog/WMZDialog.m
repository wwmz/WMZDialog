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
         [self start];
         return self;
     };
}

WMZDialogSetFuncImplementation(WMZDialog, UIViewController* ,        wParentVC)
WMZDialogSetFuncImplementation(WMZDialog, UIView* ,                   wTapView)
WMZDialogSetFuncImplementation(WMZDialog, DialogType,                    wType)
WMZDialogSetFuncImplementation(WMZDialog, DialogShowAnination,  wShowAnimation)
WMZDialogSetFuncImplementation(WMZDialog, DialogHideAnination,  wHideAnimation)
WMZDialogSetFuncImplementation(WMZDialog, NSTimeInterval,    wAnimationDurtion)
WMZDialogSetFuncImplementation(WMZDialog, UIColor*,                wTitleColor)
WMZDialogSetFuncImplementation(WMZDialog, UIColor*,              wMessageColor)
WMZDialogSetFuncImplementation(WMZDialog, CGFloat,                      wWidth)
WMZDialogSetFuncImplementation(WMZDialog, CGFloat,                     wHeight)
WMZDialogSetFuncImplementation(WMZDialog, CGFloat,                wMainOffsetY)
WMZDialogSetFuncImplementation(WMZDialog, CGFloat,              wMainBtnHeight)
WMZDialogSetFuncImplementation(WMZDialog, CGFloat,                wMainOffsetX)
WMZDialogSetFuncImplementation(WMZDialog, CGFloat,             wDisappelSecond)
WMZDialogSetFuncImplementation(WMZDialog, UIColor*,                 wLineColor)
WMZDialogSetFuncImplementation(WMZDialog, NSString*,                  wOKTitle)
WMZDialogSetFuncImplementation(WMZDialog, NSString*,              wCancelTitle)
WMZDialogSetFuncImplementation(WMZDialog, UIColor*,                   wOKColor)
WMZDialogSetFuncImplementation(WMZDialog, UIColor*,               wCancelColor)
WMZDialogSetFuncImplementation(WMZDialog, NSString*,                    wTitle)
WMZDialogSetFuncImplementation(WMZDialog, NSString*,                  wMessage)
WMZDialogSetFuncImplementation(WMZDialog, CGFloat,            wKeyBoardMarginY)
WMZDialogSetFuncImplementation(WMZDialog, UIColor*,               wShadowColor)
WMZDialogSetFuncImplementation(WMZDialog, CGFloat,                     wOKFont)
WMZDialogSetFuncImplementation(WMZDialog, CGFloat,                 wCancelFont)
WMZDialogSetFuncImplementation(WMZDialog, BOOL,                  wMainToBottom)
WMZDialogSetFuncImplementation(WMZDialog, CGFloat,                  wLineAlpha)
WMZDialogSetFuncImplementation(WMZDialog, id,                            wData)
WMZDialogSetFuncImplementation(WMZDialog, id,                         wSonData)
WMZDialogSetFuncImplementation(WMZDialog, CGFloat,                  wTitleFont)
WMZDialogSetFuncImplementation(WMZDialog, CGFloat,                wMessageFont)
WMZDialogSetFuncImplementation(WMZDialog, CGFloat,                wShadowAlpha)
WMZDialogSetFuncImplementation(WMZDialog, NSInteger,                   wPayNum)
WMZDialogSetFuncImplementation(WMZDialog, BOOL,                  wShadowCanTap)
WMZDialogSetFuncImplementation(WMZDialog, BOOL,                    wShadowShow)
WMZDialogSetFuncImplementation(WMZDialog, BOOL,                    wEffectShow)
WMZDialogSetFuncImplementation(WMZDialog, DialogClickBlock,     wEventOKFinish)
WMZDialogSetFuncImplementation(WMZDialog, DialogClickBlock, wEventCancelFinish)
WMZDialogSetFuncImplementation(WMZDialog, NSString*,      wDefaultSelectPayStr)
WMZDialogSetFuncImplementation(WMZDialog, DialogTableClickBlock,  wEventFinish)
WMZDialogSetFuncImplementation(WMZDialog, UIColor*,             wMainBackColor)
WMZDialogSetFuncImplementation(WMZDialog, CGFloat,                 wMainRadius)
WMZDialogSetFuncImplementation(WMZDialog, NSInteger,          wWirteTextMaxNum)
WMZDialogSetFuncImplementation(WMZDialog, NSString*,              wPlaceholder)
WMZDialogSetFuncImplementation(WMZDialog, NSInteger,         wWirteTextMaxLine)
WMZDialogSetFuncImplementation(WMZDialog, UIKeyboardType,   wWirteKeyBoardType)
WMZDialogSetFuncImplementation(WMZDialog, CGFloat,               wPercentAngle)
WMZDialogSetFuncImplementation(WMZDialog, CGFloat,              wPercentOrginX)
WMZDialogSetFuncImplementation(WMZDialog, DiaDirection,             wDirection)
WMZDialogSetFuncImplementation(WMZDialog, diaLogCellCallBlock,         wMyCell)
WMZDialogSetFuncImplementation(WMZDialog, CGSize,                   wImageSize)
WMZDialogSetFuncImplementation(WMZDialog, NSInteger,              wColumnCount)
WMZDialogSetFuncImplementation(WMZDialog, NSInteger,                 wRowCount)
WMZDialogSetFuncImplementation(WMZDialog, NSString*,                wImageName)
WMZDialogSetFuncImplementation(WMZDialog, BOOL,                    wPickRepeat)
WMZDialogSetFuncImplementation(WMZDialog, NSInteger,             wLocationType)
WMZDialogSetFuncImplementation(WMZDialog, UIColor*,         wProgressTintColor)
WMZDialogSetFuncImplementation(WMZDialog, UIColor*,            wTrackTintColor)
WMZDialogSetFuncImplementation(WMZDialog, diaLogMyViewCallBlock, wMyDiaLogView)
WMZDialogSetFuncImplementation(WMZDialog, BOOL,                 wAddBottomView)
WMZDialogSetFuncImplementation(WMZDialog, NSArray* ,           wTableViewColor)
WMZDialogSetFuncImplementation(WMZDialog, ChainType,                wChainType)
WMZDialogSetFuncImplementation(WMZDialog, NSString*,             wDateTimeType)
WMZDialogSetFuncImplementation(WMZDialog, DialogClickBlock,        wEventClose)
WMZDialogSetFuncImplementation(WMZDialog, DialogMenuClickBlock,wEventMenuClick)
WMZDialogSetFuncImplementation(WMZDialog, BOOL,                wNavigationItem)
WMZDialogSetFuncImplementation(WMZDialog, NSTextAlignment,      wTextAlignment)
WMZDialogSetFuncImplementation(WMZDialog, LoadingStyle,           wLoadingType)
WMZDialogSetFuncImplementation(WMZDialog, CGSize,                 wLoadingSize)
WMZDialogSetFuncImplementation(WMZDialog, UIColor*,              wLoadingColor)
WMZDialogSetFuncImplementation(WMZDialog, BOOL,             wMultipleSelection)
WMZDialogSetFuncImplementation(WMZDialog, BOOL,             wSelectShowChecked)
WMZDialogSetFuncImplementation(WMZDialog, CGFloat,                 wCellHeight)
WMZDialogSetFuncImplementation(WMZDialog, NSString*,                wSeparator)
- (instancetype)init{
    if (self = [super init]) {
        _wType = DialogTypeNornal;
        _wWidth = Dialog_GetWNum(500);
        _wHeight = Dialog_GetHNum(300);
        _wAnimationDurtion = 1.0f;
        _wAnimationDurtion = 0.5f;
        _wDisappelSecond = 1.5f;
        _wMainBtnHeight = Dialog_GetHNum(60);
        _wCellHeight = Dialog_GetHNum(80);
        _wParentVC = [WMZDialogTool getCurrentVC];
        _wOKTitle = @"确定";
        _wCancelTitle = @"取消";
        _wOKColor = DialogColor(0xFF9900);
        _wCancelColor = DialogColor(0x666666);
        _wMainRadius = 15.0f;
        _wMainBackColor = DialogColor(0xFFFFFF);
        _wLineColor =  DialogColor(0x333333);
        _wTitleColor = DialogColor(0x333333);
        _wMessageColor = DialogColor(0x333333);
        _wMainOffsetY = Dialog_GetHNum(20);
        _wMainOffsetX = Dialog_GetWNum(15);
        _wLineAlpha = 0.5f;
        _wTitleFont = 14.0f;
        _wMessageFont = 16.0f;
        _wOKFont = 16.0f;
        _wCancelFont = 16.0f;
        _wTitle = @"提示";
        _wMessage = @"内容";
        _wShadowAlpha = 0.4f;
        _wShadowColor = DialogColor(0x333333);
        _wKeyBoardMarginY = Dialog_GetHNum(80);
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
        _wImageName = @"down_tyx";
        _wProgressTintColor = DialogColor(0xFF9900);
        _wTrackTintColor = DialogColor(0xF3F4F6);
        _wTableViewColor = @[DialogColor(0xFFFFFF),DialogColor(0xF6F7FA),DialogColor(0xEBECF0),DialogColor(0xFFFFFF)];
        _wTextAlignment = NSTextAlignmentCenter;
        _wLocationType = 3;
        _wChainType = ChainPickView;
        _wDateTimeType = @"yyyy-MM-dd HH:mm:ss";
        _wPickRepeat = YES;
        _wPlaceholder = @"请输入";
        _wLoadingSize = CGSizeMake( Dialog_GetHNum(90),  Dialog_GetHNum(90));
        _wLoadingColor = DialogColor(0x108ee9);
        _wSeparator = @",";
    }
    return self;
}

/*
 *设置
 */
- (void)start{
    [self setUpDefaultParam];
    [self setUpUI];
    [self setUIdelagate];
}

/*
 *根据type设置默认属性
 */
- (void)setUpDefaultParam{

    switch (self.wType) {
        case DialogTypeNornal:{}break;
        case DialogTypeSheet:{
            if (self.wHeight == Dialog_GetHNum(300)) {
                self.wHeight = Dialog_GetHNum(200);
            }
            self.wMainToBottom = YES;
            if (self.wMainRadius == 15.0f) {
                self.wMainRadius = 10.0f;
            }
            if (self.wWidth == Dialog_GetWNum(500)) {
                self.wWidth = Device_Dialog_Width;
            }
            if (self.wMainBtnHeight == Dialog_GetHNum(60)) {
                self.wMainBtnHeight+=Dialog_GetHNum(10);
            }
//            if (self.wMultipleSelection&&self.wSelectShowChecked) {
//                self.wTextAlignment = NSTextAlignmentLeft;
//            }
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
            if (self.wHeight == Dialog_GetHNum(300)) {
                self.wHeight = Dialog_GetHNum(150);
            }
            self.wMainToBottom = YES;
            if (self.wMainRadius == 15.0f) {
                self.wMainRadius = 10.0f;
            }
            if (self.wWidth == Dialog_GetWNum(500)) {
                self.wWidth = Device_Dialog_Width;
            }
            if (self.wMainBtnHeight == Dialog_GetHNum(60)) {
                self.wMainBtnHeight+=Dialog_GetHNum(10);
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
        case DialogTypeSelect:{
//            if (self.wMultipleSelection&&self.wSelectShowChecked) {
//                self.wTextAlignment = NSTextAlignmentLeft;
//            }
        }
        break;
        case DialogTypePickSelect:{
            if (self.wHeight == Dialog_GetHNum(300)) {
                self.wHeight = Dialog_GetHNum(200);
            }
            self.wMainToBottom = YES;
            if (self.wMainRadius == 15.0f) {
                self.wMainRadius = 10.0f;
            }
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
            if (self.wHeight == Dialog_GetHNum(300)) {
                self.wHeight = self.wCellHeight*3;
            }
            self.wMainToBottom = YES;
            if (self.wMainRadius == 15.0f) {
                self.wMainRadius = 10.0f;
            }
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
            if (self.wHeight == Dialog_GetHNum(300)) {
                if (self.wChainType == ChainTableView) {
                    self.wHeight = self.wCellHeight*3;
                }else{
                    self.wHeight = Dialog_GetHNum(250);
                }
            }
            self.wMainToBottom = YES;
            if (self.wMainRadius == 15.0f) {
                self.wMainRadius = 10.0f;
            }
            if (self.wWidth == Dialog_GetWNum(500)) {
                self.wWidth = Device_Dialog_Width;
            }
        }
            break;
        case DialogTypeDatePicker:
        {
            if (self.wHeight == Dialog_GetHNum(300)) {
                self.wHeight = Dialog_GetHNum(250);
            }
            self.wMainToBottom = YES;
            if (self.wMainRadius == 15.0f) {
                self.wMainRadius = 10.0f;
            }
            if (self.wWidth == Dialog_GetWNum(500)) {
                self.wWidth = Device_Dialog_Width;
            }
        }
            break;
        case DialogTypeTabbarMenu:
        {
            if (self.wHeight == Dialog_GetHNum(300)) {
                self.wHeight = Dialog_GetHNum(150);
            }
            self.wMainToBottom = YES;
            if (self.wMainRadius == 15.0f) {
                self.wMainRadius = 10.0f;
            }
            if (self.wWidth == Dialog_GetWNum(500)) {
                self.wWidth = Device_Dialog_Width;
            }
            if (self.wMainBtnHeight == Dialog_GetHNum(60)) {
                self.wMainBtnHeight+=Dialog_GetHNum(10);
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
            if (self.wHeight == Dialog_GetHNum(300)) {
                self.wHeight = Dialog_GetHNum(150);
            }
            self.wMainToBottom = YES;
            if (self.wMainRadius == 15.0f) {
                self.wMainRadius = 10.0f;
            }
            if (self.wWidth == Dialog_GetWNum(500)) {
                self.wWidth = Device_Dialog_Width;
            }
            if (self.wMainBtnHeight == Dialog_GetHNum(60)) {
                self.wMainBtnHeight+=Dialog_GetHNum(10);
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
        case DialogTypeBuyCar:
        {
            if (self.wHeight == Dialog_GetHNum(300)) {
                self.wHeight = Dialog_GetHNum(200);
            }
            self.wMainToBottom = YES;
            if (self.wMainRadius == 15.0f) {
                self.wMainRadius = 10.0f;
            }
            if (self.wWidth == Dialog_GetWNum(500)) {
                self.wWidth = Device_Dialog_Width;
            }
            if (self.wMainBtnHeight == Dialog_GetHNum(60)) {
                self.wMainBtnHeight+=Dialog_GetHNum(10);
            }
        }
            break;
        case DialogTypeLoading:{
            self.wShadowAlpha = 0.2;
            self.wWidth = self.wLoadingSize.width*1.5;
//            self.wShadowColor = [UIColor whiteColor];
        }
        case DialogTypeAuto:
             DialogTypeMyView:
             DialogTypeWrite:
             DialogTypeTime:
             DialogTypeDown:
             break;
        default:
            break;
    }
    
}

/*
 *UI赋值
 */
- (void)setUpUI{
    
    self.modalPresentationStyle = UIModalPresentationOverFullScreen;
    self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    
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
        self.wType != DialogTypeBuyCar) {
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
    
    self.mainView.frame = CGRectMake(0, 0, self.wWidth, Dialog_GetHNum(267));
    self.mainView.backgroundColor = _wMainBackColor;
    
    self.shadowView.backgroundColor = _wShadowColor;
    self.shadowView.alpha = _wShadowAlpha;
    
    if (self.wShadowCanTap) {
        self.shadowView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeView)];
        [self.shadowView addGestureRecognizer:tap];
    }
    
    
}

//设置UI代理
- (void)setUIdelagate{
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]&&self.wType!=DialogTypePop) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    
    if (self.wType == DialogTypeSelect || self.wType == DialogTypeSheet || self.wType == DialogTypePop|| self.wType == DialogTypeBuyCar) {
        if (self.wData&&([self.wData isKindOfClass:[NSArray class]]||[self.wData isKindOfClass:[NSMutableArray class]])) {
            self.tableView.delegate = self;
            self.tableView.dataSource = self;
            self.tableView.estimatedSectionFooterHeight = 0.01;
            self.tableView.estimatedSectionHeaderHeight = 0.01;
            self.tableView.estimatedRowHeight = 100.0;
//            self.tableView.rowHeight = self.wCellHeight;
            if (@available(iOS 11.0, *)) {
                self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            }
        }
        
        if (self.wType == DialogTypeBuyCar) {
            self.tableView.scrollEnabled = YES;
        }else{
            if ([self.wData count]>8) {
                self.tableView.scrollEnabled = YES;
            }else{
                self.tableView.scrollEnabled = NO;
            }
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
    
    [self.view addSubview:self.mainView];
    
    if (self.wMyDiaLogView) {
        [self start:self.mainView];
        UIView *bottomView = self.wMyDiaLogView(self.mainView);
        if (self.wAddBottomView) {
            UIView *addBottomView  = [self addBottomView:CGRectGetMaxY(bottomView.frame)+self.wMainOffsetY];
            [self reSetMainViewFrame:CGRectMake(0, 0, self.wWidth, CGRectGetMaxY(addBottomView.frame)+self.wMainOffsetY)];
        }else{
            [self reSetMainViewFrame:CGRectMake(0, 0, self.wWidth, CGRectGetMaxY(bottomView.frame)+self.wMainOffsetY)];
        }
    }else{
        SEL sel = NSSelectorFromString(self.configDic[@(self.wType)]);
        if (!sel) return;
        SuppressPerformSelectorLeakWarning(
                                           id alert = [self performSelector:sel];
                                           [self performSelector:@selector(start:) withObject:alert];
                                           );
    }
}

/*
 *开始
 */
- (void)start:(id)alert{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.wEffectShow) {
            [self.view addSubview:self.effectView];
            self.shadowView.backgroundColor = [UIColor clearColor];
            [self.view sendSubviewToBack:self.effectView];
        }
        if (self.wShadowShow) {
            [self.view insertSubview:self.shadowView  belowSubview:self.mainView];
        }
        BOOL animal = !self.wShowAnimation||self.wShowAnimation>=7;
        [self.wParentVC presentViewController:self animated:animal completion:nil];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self dealAnamtionShowWithView:self.mainView withType:self.wShowAnimation withTime:self.wAnimationDurtion];
        });
    });
    
}

/*
 *关闭
 */
- (void)closeView{
    self.close = YES;
    if (self.wType == DialogTypePay || self.wType == DialogTypeWrite) {
        [self.mainView endEditing:YES];
    }
   
    if (self.wEventClose) {
        self.wEventClose(@"关闭", nil);
    }

    __weak WMZDialog *weak = self;
    if (self.wType == DialogTypeShare||self.wType == DialogTypeTabbarMenu||self.wType == DialogTypeNaviMenu) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.00 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
             UIScrollView *sc = [self.mainView viewWithTag:10086];
            if (self.wEffectShow) {
                curverOffAnimation(self.effectView,self.wAnimationDurtion);
                if (self.wType == DialogTypeTabbarMenu||self.wType == DialogTypeNaviMenu ) {
                    rotationClockwiseAnimation(self.wCloseBtn, self.wAnimationDurtion);
                }
            }else{
                self.shadowView.userInteractionEnabled = NO;
                self.shadowView.hidden = YES;
                for (UIView *view in [self.mainView subviews]) {
                    if (view.tag != 10086) {
                        curverOffAnimation(view,self.wAnimationDurtion);
                    }
                }
            }
            springHideAnimation(sc, self.wAnimationDurtion, [sc subviews], ^{
                [weak dismissViewControllerAnimated:NO completion:nil];
            });
            curverOffAnimation(self.mainView,self.wAnimationDurtion);
        });
    }else{
        [self closeAction];
    }
    
}

- (void)closeAction{
    if (self.wHideAnimation&&self.wHideAnimation<5) {
        self.view.userInteractionEnabled = NO;
        self.shadowView.hidden = YES;
        [self dealAnamtionHideWithView:self.mainView withType:self.wHideAnimation withTime:self.wAnimationDurtion];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.wAnimationDurtion * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self dismissViewControllerAnimated:NO completion:nil];
        });
    }else{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.00 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self dismissViewControllerAnimated:YES completion:nil];
        });
    }
}

/*
 *重新设置mainView的frame
 */
- (void)reSetMainViewFrame:(CGRect)frame{
    CGPoint center = CGPointZero;
    
    if (self.wMainToBottom) {
        frame.origin.y = Device_Dialog_Height-frame.size.height;
        if (isIphoneX) {
            frame.origin.y -= 10;
            frame.size.height += 10;
            UIView *view =  [UIView new];
            view.backgroundColor = self.mainView.backgroundColor;
            view.frame = CGRectMake(frame.origin.x, frame.size.height-10, frame.size.width, 10);
            [self.mainView addSubview:view];
        }
        self.mainView.frame =frame;
        center = CGPointMake(self.view.center.x, self.mainView.center.y);
        
    }else{
        center = self.view.center;
        self.mainView.frame =frame;
    }
    
    self.mainView.center = center;
}


/*
 *添加底部
 */
- (UIView*)addBottomView:(CGFloat)maxY{
    if (self.bottomView) {
        self.bottomView.frame = CGRectMake(0, maxY, self.wWidth, CGRectGetMaxY(self.OKBtn.frame));
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
        [self.bottomView addSubview:Line];
        Line.backgroundColor = self.wLineColor;
        Line.frame = CGRectMake(CGRectGetMaxX(self.cancelBtn.frame), self.cancelBtn.frame.origin.y, DialogK1px, self.wMainBtnHeight);

    }
    
    [self.bottomView addSubview:self.OKBtn];
    self.OKBtn.frame = CGRectMake(self.wEventCancelFinish?CGRectGetMaxX(self.cancelBtn.frame)+DialogK1px:0, CGRectGetMaxY(upLine.frame)+self.wMainOffsetX,self.wEventCancelFinish?self.wWidth/2-DialogK1px/2:self.wWidth, self.wMainBtnHeight);
    
    self.bottomView.frame = CGRectMake(0, maxY, self.wWidth, CGRectGetMaxY(self.OKBtn.frame)+self.wMainOffsetX);
    return self.bottomView;
}

# pragma  mark tableView 代理
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return   self.wType == DialogTypeMenusSelect || self.wType == DialogTypeLocation?[[self getMyDataArr:tableView.tag withType:0] count]:[self.wData count];
    
}

# pragma  mark tableView 代理
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    id data = (self.wType == DialogTypeMenusSelect || self.wType == DialogTypeLocation?[self getMyDataArr:tableView.tag withType:0]:self.wData)[indexPath.row];
    
    if (self.wMyCell) {
        return self.wMyCell(indexPath,self.tableView,data);
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DiaLogCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DiaLogCell"];
        }
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
        }else if([data isKindOfClass:[NSDictionary class]]){
            
            UIImage *icon = [UIImage imageNamed:data[@"image"]];
            cell.imageView.image = icon;
            CGSize itemSize = CGSizeMake(30, 30);
            UIGraphicsBeginImageContextWithOptions(itemSize, NO, 0.0);
            CGRect imageRect = CGRectMake(0, 0, itemSize.width, itemSize.height);
            [icon drawInRect:imageRect];
            cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            cell.textLabel.text = data[@"name"]?:@"";
        }else{
            NSString *cellID = [NSString stringWithFormat:@"%ld-%ld",indexPath.section,indexPath.row];
            cell.selectionStyle = self.wMultipleSelection?UITableViewCellSelectionStyleNone:UITableViewCellSelectionStyleDefault;
            if ([self.tempArr indexOfObject:cellID]!=NSNotFound) {
                cell.accessoryType = self.wSelectShowChecked?UITableViewCellAccessoryCheckmark:UITableViewCellAccessoryNone;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.textLabel.textColor = self.wOKColor;
            }else{
                cell.accessoryType = UITableViewCellAccessoryNone;
                cell.textLabel.textColor = self.wMessageColor;
            }
            cell.textLabel.text = data;
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //为0则自动计算高度
    return  self.wCellHeight?:UITableViewAutomaticDimension;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.wType == DialogTypeMenusSelect || self.wType == DialogTypeLocation) {
        [self selectWithTableView:tableView withIndexPath:indexPath];
    }else if (self.wType == DialogTypeBuyCar) {
        return;
    }else{
        NSString *cellID = [NSString stringWithFormat:@"%ld-%ld",indexPath.section,indexPath.row];
        id any = self.wData[indexPath.row];
        if ([self.tempArr indexOfObject:cellID]==NSNotFound) {
            [self.selectArr addObject:any];
            [self.tempArr addObject:cellID];
            [self.pathArr addObject:indexPath];
        }else{
            [self.selectArr removeObject:any];
            [self.pathArr removeObject:indexPath];
            [self.tempArr removeObject:cellID];
        }
        [self.tableView reloadData];
        if (!self.wMultipleSelection) {
            if (self.wEventFinish) {
                self.wEventFinish(any, indexPath,self.wType);
            }
            [self closeView];
        }
    
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
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
        NSString *name = [self.wDateTimeType containsString:@"日"]?@"日":@"";
        NSCharacterSet* nonDigits =[[NSCharacterSet decimalDigitCharacterSet] invertedSet];
         //符合年月日的才改变天数
        if (component == 0) {
            if ([self.wDateTimeType containsString:@"dd"]&&[self.wDateTimeType containsString:@"yyyy"]&&[self.wDateTimeType containsString:@"MM"]) {
                if ([self.wData count]>2) {
                    NSArray *yearArr = self.wData[component];
                    int year =[[yearArr[self.wPickRepeat?row%yearArr.count:row] stringByTrimmingCharactersInSet:nonDigits] intValue];
                    NSArray *monthArr = self.wData[component+1];
                    NSInteger monthIndex = [self.pickView selectedRowInComponent:component+1];
                    int month =[[monthArr[self.wPickRepeat?monthIndex%monthArr.count:monthIndex] stringByTrimmingCharactersInSet:nonDigits] intValue];
                    self.wData[2] = [self timeDayWithArr:@[@(year),@(month)] withName:name];
                    [self.pickView reloadComponent:2];
                }
            }
        }
        if (component == 1) {
            if ([self.wDateTimeType containsString:@"dd"]&&[self.wDateTimeType containsString:@"yyyy"]&&[self.wDateTimeType containsString:@"MM"]) {
                if ([self.wData count]>2) {
                    NSArray *yearArr = self.wData[component-1];
                    NSInteger yearIndex = [self.pickView selectedRowInComponent:component-1];
                    int year =[[yearArr[self.wPickRepeat?yearIndex%yearArr.count:yearIndex] stringByTrimmingCharactersInSet:nonDigits] intValue];
                    NSArray *monthArr = self.wData[component];
                    int month =[[monthArr[self.wPickRepeat?row%monthArr.count:row] stringByTrimmingCharactersInSet:nonDigits] intValue];
                    self.wData[2] = [self timeDayWithArr:@[@(year),@(month)] withName:name];
                    [self.pickView reloadComponent:2];
                }
            }
        }
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
    self.mainView.center = self.view.center;
}


/*
 *取消
 */
- (void)cancelAction:(UIButton*)btn{
    if (self.wEventCancelFinish) {
        self.wEventCancelFinish(@"取消",nil);
    }
    [self closeView];
}

/*
 *确定
 */
- (void)OKAction:(UIButton*)btn{
    if (self.wEventOKFinish) {
        self.wEventOKFinish(@"确定",nil);
    }
    [self closeView];
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
                               @(DialogTypeBuyCar):@"bugCarAction",
                               @(DialogTypeLocation):@"locationAction",
                               @(DialogTypeDatePicker):@"datePickerAction",
                               @(DialogTypeTabbarMenu):@"tabbarMenuAction",
                               @(DialogTypeNaviMenu):@"naviMenuAction",
                               @(DialogTypeLoading):@"loadingAction",
                              };
        _configDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    }
    return _configDic;
}

- (void)dealloc{
    NSLog(@"销毁");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
