//
//  WMZDialog.m
//  WMZDialog
//
//  Created by wmz on 2019/6/5.
//  Copyright © 2019年 wmz. All rights reserved.
//
#import "WMZDialog.h"
@implementation WMZDialog
WMZDialogSetFuncImplementation(WMZDialog, BOOL,                         wOpenKeyBoard)
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
WMZDialogSetFuncImplementation(WMZDialog, BOOL,                            wAutoClose)
WMZDialogSetFuncImplementation(WMZDialog, BOOL,                           wPickRepeat)
WMZDialogSetFuncImplementation(WMZDialog, BOOL,                         wMainToBottom)
WMZDialogSetFuncImplementation(WMZDialog, BOOL,                         wCanSelectPay)
WMZDialogSetFuncImplementation(WMZDialog, BOOL,                      wDeviceDidChange)
WMZDialogSetFuncImplementation(WMZDialog, BOOL,                 wTapViewTableViewFoot)
WMZDialogSetFuncImplementation(WMZDialog, BOOL,                        wOpenMultiZone)
WMZDialogSetFuncImplementation(WMZDialog, BOOL,                         wHideExistTop)
WMZDialogSetFuncImplementation(WMZDialog, BOOL,                            wShowClose)
WMZDialogSetFuncImplementation(WMZDialog, BOOL,                       wFillBottomLine)
WMZDialogSetFuncImplementation(WMZDialog, BOOL,                       wMainShadowShow)
WMZDialogSetFuncImplementation(WMZDialog, BOOL,               wUserInteractionEnabled)
WMZDialogSetFuncImplementation(WMZDialog, BOOL,                              wBounces)
WMZDialogSetFuncImplementation(WMZDialog, DiaPopInView,                  wTapViewType)
WMZDialogSetFuncImplementation(WMZDialog, DialogPopType,                wPopStyleType)
WMZDialogSetFuncImplementation(WMZDialog, DialogLevel,                         wLevel)
WMZDialogSetFuncImplementation(WMZDialog, DialogToastPosition,         wToastPosition)
WMZDialogSetFuncImplementation(WMZDialog, UIColor*,                       wThemeColor)
WMZDialogSetFuncImplementation(WMZDialog, CGPoint,                             wPoint)
WMZDialogSetFuncImplementation(WMZDialog, NSInteger,                 wListScrollCount)
WMZDialogSetFuncImplementation(WMZDialog, NSInteger,            wTableViewSectionHead)
WMZDialogSetFuncImplementation(WMZDialog, NSArray*,                   wDateShowCircle)
WMZDialogSetFuncImplementation(WMZDialog, NSArray<DialogCalanderLimitTypeKey>*,wMinMaxResultArr)
WMZDialogSetFuncImplementation(WMZDialog, CGFloat,                        wAngleRadio)
WMZDialogSetFuncImplementation(WMZDialog, CGFloat,                   wInputAreaHeight)
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
WMZDialogSetFuncImplementation(WMZDialog, id,                                wOKTitle)
WMZDialogSetFuncImplementation(WMZDialog, id,                            wCancelTitle)
WMZDialogSetFuncImplementation(WMZDialog, NSDictionary*,                     wRegular)
WMZDialogSetFuncImplementation(WMZDialog, UIColor*,                  wBottomLineColor)
WMZDialogSetFuncImplementation(WMZDialog, UIColor*,                          wOKColor)
WMZDialogSetFuncImplementation(WMZDialog, UIColor*,                      wCancelColor)
WMZDialogSetFuncImplementation(WMZDialog, id,                                  wTitle)
WMZDialogSetFuncImplementation(WMZDialog, id,                                wMessage)
WMZDialogSetFuncImplementation(WMZDialog, CGFloat,                   wKeyBoardMarginY)
WMZDialogSetFuncImplementation(WMZDialog, UIColor*,                      wShadowColor)
WMZDialogSetFuncImplementation(WMZDialog, CGFloat,                            wOKFont)
WMZDialogSetFuncImplementation(WMZDialog, CGFloat,                        wCancelFont)
WMZDialogSetFuncImplementation(WMZDialog, CGFloat,                         wLineAlpha)
WMZDialogSetFuncImplementation(WMZDialog, id,                                   wData)
WMZDialogSetFuncImplementation(WMZDialog, NSArray*,                          wSonData)
WMZDialogSetFuncImplementation(WMZDialog, NSArray*,                 wListDefaultValue)
WMZDialogSetFuncImplementation(WMZDialog, CGFloat,                         wTitleFont)
WMZDialogSetFuncImplementation(WMZDialog, CGFloat,                       wMessageFont)
WMZDialogSetFuncImplementation(WMZDialog, CGFloat,                       wShadowAlpha)
WMZDialogSetFuncImplementation(WMZDialog, NSInteger,                             wTag)
WMZDialogSetFuncImplementation(WMZDialog, NSInteger,                          wPayNum)
WMZDialogSetFuncImplementation(WMZDialog, CGFloat,                      wAutoMaxWidth)
WMZDialogSetFuncImplementation(WMZDialog, NSString*,             wDefaultSelectPayStr)
WMZDialogSetFuncImplementation(WMZDialog, UIColor*,                    wMainBackColor)
WMZDialogSetFuncImplementation(WMZDialog, UIColor* ,            wInputBackGroundColor)
WMZDialogSetFuncImplementation(WMZDialog, CGFloat,                        wMainRadius)
WMZDialogSetFuncImplementation(WMZDialog, CGFloat,                        wLimitAlpha)
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
WMZDialogSetFuncImplementation(WMZDialog, NSString*,                 wPopNestStopView)
WMZDialogSetFuncImplementation(WMZDialog, NSString*,           wReginerCollectionCell)
WMZDialogSetFuncImplementation(WMZDialog, DialogLocationType,           wLocationType)
WMZDialogSetFuncImplementation(WMZDialog, UIColor*,                wProgressTintColor)
WMZDialogSetFuncImplementation(WMZDialog, UIColor*,                   wTrackTintColor)
WMZDialogSetFuncImplementation(WMZDialog, UIColor*,                   wInputTextColor)
WMZDialogSetFuncImplementation(WMZDialog, NSArray* ,                  wTableViewColor)
WMZDialogSetFuncImplementation(WMZDialog, NSString*,                    wDateTimeType)
WMZDialogSetFuncImplementation(WMZDialog, NSTextAlignment,             wTextAlignment)
WMZDialogSetFuncImplementation(WMZDialog, CGSize,                        wLoadingSize)
WMZDialogSetFuncImplementation(WMZDialog, UIColor*,                     wLoadingColor)
WMZDialogSetFuncImplementation(WMZDialog, CGFloat,                        wCellHeight)
WMZDialogSetFuncImplementation(WMZDialog, NSString*,                       wSeparator)
WMZDialogSetFuncImplementation(WMZDialog, NSString*,                     wXMLPathName)
WMZDialogSetFuncImplementation(WMZDialog, CGSize,                   wCalanderCellSize)
WMZDialogSetFuncImplementation(WMZDialog, NSDate*,                       wDefaultDate)
WMZDialogSetFuncImplementation(WMZDialog, NSDate*,                           wMaxDate)
WMZDialogSetFuncImplementation(WMZDialog, NSDate*,                           wMinDate)
WMZDialogSetFuncImplementation(WMZDialog, CGSize,                          wAngleSize)
WMZDialogSetFuncImplementation(WMZDialog, CGFloat,                      wLoadingWidth)
WMZDialogSetFuncImplementation(WMZDialog, CGFloat,                wPopViewBorderWidth)
WMZDialogSetFuncImplementation(WMZDialog, CGSize,                       wCellIconSize)
WMZDialogSetFuncImplementation(WMZDialog, DialogCellAlignType,           wCellAlignType)
WMZDialogSetFuncImplementation(WMZDialog, UIColor*,               wPopViewBorderColor)
WMZDialogSetFuncImplementation(WMZDialog, UITableViewCellSeparatorStyle,wSeparatorStyle)
WMZDialogSetFuncImplementation(WMZDialog, UIImage*,                       wCheckImage)
WMZDialogSetFuncImplementation(WMZDialog, NSArray<NSString*>*,  wCalanderWeekTitleArr)
WMZDialogSetFuncImplementation(WMZDialog, UIColor*,              wCellBackgroundColor)
WMZDialogSetFuncImplementation(WMZDialog, DialogPopCustomBlock,        wPopCustomView)
WMZDialogSetFuncImplementation(WMZDialog, DialogRectCorner,        wPopViewRectCorner)
WMZDialogSetFuncImplementation(WMZDialog, DialogType,                           wType)
WMZDialogSetFuncImplementation(WMZDialog, DialogShowAnination,         wShowAnimation)
WMZDialogSetFuncImplementation(WMZDialog, DialogHideAnination,         wHideAnimation)
WMZDialogSetFuncImplementation(WMZDialog, ChainType,                       wChainType)
WMZDialogSetFuncImplementation(WMZDialog, LoadingStyle,                  wLoadingType)
WMZDialogSetFuncImplementation(WMZDialog, DiaDirection,                    wDirection)
WMZDialogSetFuncImplementation(WMZDialog, DiaLogCustomCellBlock,          wCustomCell)
WMZDialogSetFuncImplementation(WMZDialog, DiaLogPresentCallBlock,     wParentHeadView)
WMZDialogSetFuncImplementation(WMZDialog, DiaLogPresentCallBlock,   wParentBottomView)
WMZDialogSetFuncImplementation(WMZDialog, DiaLogCellSelectlock,           wSelectCell)
WMZDialogSetFuncImplementation(WMZDialog, DialogClickBlock,               wEventClose)
WMZDialogSetFuncImplementation(WMZDialog, DialogClickBlock,         wEventShadomClose)
WMZDialogSetFuncImplementation(WMZDialog, DialogMenuClickBlock,       wEventMenuClick)
WMZDialogSetFuncImplementation(WMZDialog, DiaLogMyViewCallBlock,        wMyDiaLogView)
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
WMZDialogSetFuncImplementation(WMZDialog, DialogCustomMainShadomLayer,wCustomMainShadom)
WMZDialogSetFuncImplementation(WMZDialog, DialogCustomAnimal,  wEventCustomShowAmimal)
WMZDialogSetFuncImplementation(WMZDialog, DialogCustomAnimal,  wEventCustomHideAmimal)
WMZDialogSetFuncImplementation(WMZDialog, DialogCustomShareView,     wCustomShareView)
WMZDialog * Dialog(void){
    return  [WMZDialog  new];
}

- (WMZDialog * _Nonnull (^)(NSDictionary<DialogDarkColorKey,UIColor *> * _Nullable))wDarkMode{
    return ^WMZDialog*(NSDictionary<DialogDarkColorKey,UIColor *> * _Nullable info){
        self.param.wOpenDark = self.wOpenDark = YES;
        if (info && [info isKindOfClass:NSDictionary.class]) {
            for (NSString *key in info.allKeys) {
                if (WMZDialogManage.shareInstance.darkColorInfo[key]) {
                    if ([info[key] isKindOfClass:UIColor.class])
                        WMZDialogManage.shareInstance.darkColorInfo[key] = info[key];
                }
            }
        }
        [WMZDialogManage setDefaultColorPropertiess:(WMZDialogParam*)self];
        return self;
    };
}

- (WMZDialog * _Nonnull (^)(void))wStart{
     return ^WMZDialog*(){
         [self setUpUI:nil useConfig:YES];
         return self;
     };
}

- (WMZDialog * _Nonnull (^)(UIView * _Nonnull))wStartView{
    return ^WMZDialog*(UIView *startView){
        [self setUpUI:startView useConfig:YES];
        return self;
    };
}

- (WMZDialog * _Nonnull (^)(WMZDialogParam * _Nonnull))wStartParam{
    return ^WMZDialog*(WMZDialogParam *param){
        if (param) self.param = param;
        [self setUpUI:nil useConfig:param ? NO : YES];
        return self;
    };
}

- (WMZDialog * _Nonnull (^)(WMZDialogParam * _Nonnull, UIView * _Nonnull))wStartParamView{
    return ^WMZDialog*(WMZDialogParam *param,UIView *startView){
        if (param) self.param = param;
        [self setUpUI:startView useConfig:param ? NO : YES];
        return self;
    };
}

- (WMZDialog * _Nonnull (^)(UIView<WMZCustomPrototol> * _Nonnull))wCustomView{
    return ^WMZDialog*(UIView<WMZCustomPrototol> *customView){
        self.wType = DialogTypeMyView;
        self.mainView = (WMZDialogNormal*)customView;
        return self;
    };
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [WMZDialogManage.shareInstance setUpManageDefaultParam:(WMZDialogParam*)self];
    }
    return self;
}

- (void)setUpUI:(nullable UIView*)startView useConfig:(BOOL)useeConfig{
    UIView *parentView = startView ? : DialogWindow;
    NSAssert(parentView != nil, @"检查传入的StartView或者当前的UIWindow");
    dispatch_async(dispatch_get_main_queue(), ^{
        [parentView layoutIfNeeded];
        self.frame = parentView.bounds;
        self.normalRect = self.frame;
        self.beforeRect = CGRectZero;
        if (useeConfig) [self setPropertiesToParam];
        [self.param setUpDefaultParam];
        [self setUpUI];
        [self setUIdelagate:startView];
    });
}

- (void)setPropertiesToParam{
    u_int count = 0;
    objc_property_t *properties = class_copyPropertyList([WMZDialogParentParam class], &count);
    for (int i = 0; i < count; i++) {
        const char *propertyName = property_getName(properties[i]);
        NSString *proper = [NSString stringWithUTF8String:propertyName];
        if (![proper isEqualToString:@"wOpenDark"]) {
            id object = [self valueForKey:proper];
            id paramObject = [self.param valueForKey:proper];
            if (object && paramObject != object) {
                [self.param setValue:object forKey:proper];
            }
        }
    }
    free(properties);
}

/// UI赋值
- (void)setUpUI{
    if (self.param.wType == DialogTypeWrite ||
        self.param.wType == DialogTypePay ||
        self.param.wOpenKeyBoard) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:NSSelectorFromString(@"keyboardWillShow:") name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:NSSelectorFromString(@"keyboardWillHide:") name:UIKeyboardWillHideNotification object:nil];
    }
    self.shadowView.frame = self.bounds;
    self.shadowView.backgroundColor = self.param.wShadowColor;
    self.shadowView.alpha = self.param.wShadowAlpha;
    
    if (self.param.wShadowCanTap) {
        self.shadowView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(shadomClick)];
        [self.shadowView addGestureRecognizer:tap];
    }
    
    if (self.param.wDeviceDidChange)
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(change:) name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
    
}

/// 设置UI代理
- (void)setUIdelagate:(nullable UIView*)showView{
    /// 兼容旧版本自定义方式
    if (self.param.wMyDiaLogView && self.wType == DialogTypeMyView) {
        [self addSubview:self.mainView];
        self.mainView.param = self.param;
        self.mainView.backgroundColor = self.param.wMainBackColor;
        self.mainView.frame = CGRectMake(0, 0, self.wWidth, DialogRealW(267));
        if (self.param.wHeight == DialogRealW(400)) self.param.wHeight = 0;
        [self showView:showView];
        UIView *bottomView = self.param.wMyDiaLogView(self.mainView);
        [self.mainView layoutIfNeeded];
        [bottomView layoutIfNeeded];
        self.param.wWidth = MAX(bottomView.frame.size.width, self.param.wWidth);
        BOOL customHeight = (self.param.wHeight > 0);
        if (self.param.wAddBottomView) {
            UIView *addBottomView  = [self.mainView addBottomView:CGRectGetMaxY(bottomView.frame) + self.param.wMainOffsetY];
            [self reSetMainViewFrame:CGRectMake(0, 0, self.param.wWidth, customHeight?self.param.wHeight:(CGRectGetMaxY(addBottomView.frame)+self.param.wMainOffsetY))];
        }else{
            [self reSetMainViewFrame:CGRectMake(0, 0, self.param.wWidth, customHeight?self.param.wHeight:CGRectGetMaxY(bottomView.frame))];
        }
        
        if (self.param.wDisappelSecond != DialogDisappealTime && self.param.wDisappelSecond) {
            [self performSelector:@selector(closeView) withObject:nil afterDelay:self.param.wDisappelSecond];
        }
        [self showView:showView];
    }else {
        if (self.wType != DialogTypeMyView){
            self.mainView  = [NSClassFromString(self.configDic[@(self.param.wType)]) initWithParam:self.param];
        }else{
            if ([self.mainView isKindOfClass:NSClassFromString(@"WMZDialogView")] && !self.mainView.param)
                self.mainView.param = self.param;
        }
        [self addSubview:self.mainView];
        self.mainView.backgroundColor = self.param.wMainBackColor;
        if ([self.mainView conformsToProtocol:@protocol(WMZCustomPrototol)]) {
            if ([self.mainView respondsToSelector:@selector(mz_setupView)])
                [self.mainView mz_setupView];
            if ([self.mainView respondsToSelector:@selector(mz_setupRect)]) {
                BOOL center = YES;
                if ([self.mainView respondsToSelector:@selector(mz_centerView)])
                    center = [self.mainView mz_centerView];
                
                CGRect rect = [self.mainView mz_setupRect];
                if (!CGRectIsEmpty(rect)){
                    if (center) {
                        [self reSetMainViewFrame:rect];
                    }else{
                        self.mainView.frame = rect;
                        if ([self.mainView respondsToSelector:@selector(mz_changeFrame:)])
                            [self.mainView mz_changeFrame:[NSValue valueWithCGRect:self.mainView.frame]];
                    }
                }else{
                    if ([self.mainView respondsToSelector:@selector(mz_changeFrame:)])
                        [self.mainView mz_changeFrame:[NSValue valueWithCGRect:self.mainView.frame]];
                }
            }

            if ([self.mainView respondsToSelector:@selector(mz_setupCorner)]) {
                UIRectCorner corner = [self.mainView mz_setupCorner];
                if (corner != -99999)
                    [WMZDialogUntils setCornerView:self.mainView radio:CGSizeMake(self.param.wMainRadius,self.param.wMainRadius) rectCorner:corner];
            }else{
                self.mainView.layer.cornerRadius = self.param.wMainRadius;
                self.mainView.layer.masksToBounds = YES;
            }
        }

        [self showView:showView];
        /// 自动消失
        if ([self.mainView conformsToProtocol:@protocol(WMZCustomPrototol)] &&
            [self.mainView respondsToSelector:@selector(mz_autoDisappeal)]) {
            CGFloat disappealTime = [self.mainView mz_autoDisappeal];
            
            if (disappealTime > 0){
                [self performSelector:@selector(closeView) withObject:nil afterDelay:disappealTime];
            }else{
                if (self.param.wDisappelSecond != DialogDisappealTime && self.param.wDisappelSecond) {
                    [self performSelector:@selector(closeView) withObject:nil afterDelay:self.param.wDisappelSecond];
                }
            }
            
            if ([self.mainView respondsToSelector:@selector(mz_changeValue:)])
                [self.mainView mz_changeValue:self.param.wData];
        }else{
            if (self.param.wDisappelSecond != DialogDisappealTime && self.param.wDisappelSecond) {
                [self performSelector:@selector(closeView) withObject:nil afterDelay:self.param.wDisappelSecond];
            }
        }
    }
    
    if (self.param.wMainShadowShow && self.param.wType != DialogTypeCardPresent) {
        CGRect rect = self.mainView.frame;
        UIView *shadowView = [[UIView alloc]initWithFrame:rect];
        [self addSubview:shadowView];
        shadowView.layer.shadowColor = [UIColor blackColor].CGColor;
        shadowView.layer.shadowOffset = CGSizeMake(5, 5);
        shadowView.layer.shadowOpacity = 0.5;
        shadowView.layer.shadowRadius = 9.0;
        shadowView.layer.cornerRadius = 9.0;
        shadowView.clipsToBounds = NO;
        
        if (self.param.wCustomMainShadom)
            self.param.wCustomMainShadom(shadowView.layer);
        
        [shadowView addSubview:self.mainView];
        self.mainView.frame = shadowView.bounds;
    }
    
    if (!CGPointEqualToPoint(self.param.wPoint, CGPointMake(-999, -999))) {
        CGRect rect = self.mainView.frame;
        rect.origin = self.param.wPoint;
        self.mainView.frame = rect;
    }
    if (self.param.wCustomTitleLa && [self.mainView valueForKey:@"titleLabel"])
        self.param.wCustomTitleLa([self.mainView valueForKey:@"titleLabel"]);
    if (self.param.wCustomMessageLa && [self.mainView valueForKey:@"textLabel"])
        self.param.wCustomMessageLa([self.mainView valueForKey:@"textLabel"]);
    if (self.param.wCustomOKBtn && [self.mainView valueForKey:@"OKBtn"])
        self.param.wCustomOKBtn([self.mainView valueForKey:@"OKBtn"]);
    if (self.param.wCustomCancelBtn && [self.mainView valueForKey:@"cancelBtn"])
        self.param.wCustomCancelBtn([self.mainView valueForKey:@"cancelBtn"]);
    if (self.param.wCustomCloseBtn && [self.mainView valueForKey:@"closeBtn"])
        self.param.wCustomCloseBtn([self.mainView valueForKey:@"closeBtn"]);
    if (self.param.wCustomImageView && [self.mainView valueForKey:@"iconIV"])
        self.param.wCustomImageView([self.mainView valueForKey:@"iconIV"]);
    if (self.param.wCustomTableView && [self.mainView valueForKey:@"tableView"]){
        WMZDialogTableView *tableView = [self.mainView valueForKey:@"tableView"];
        [tableView reloadData];
        [tableView layoutIfNeeded];
        self.param.wCustomTableView(tableView);
    }
    if (self.param.wCustomMainView) self.param.wCustomMainView(self.mainView);
}

/// 开始
- (void)showView:(nullable UIView*)showView{
    @DialogWeakify(self);
    UIView *view = showView?:DialogWindow;
    if (self.param.wTag) {
        self.tag = self.param.wTag;
        WMZDialog *existView = [view viewWithTag:self.param.wTag];
        if ([existView isKindOfClass:WMZDialog.class] &&
            existView.wType == self.param.wType) return;
    }
    NSAssert(view != nil, @"检查传入的StartView或者当前的UIWindow");
    
    self.userInteractionEnabled = self.param.wUserInteractionEnabled;
    [WMZDialogManage.shareInstance addDialog:self cover:NO superView:view];
    if (self.param.wShowAnimation != AninatonShowNone ) {
        self.mainView.userInteractionEnabled = NO;
        self.shadowView.userInteractionEnabled = NO;
    }
    if (self.param.wEffectShow) {
        [self addSubview:self.effectView];
        self.shadowView.backgroundColor = [UIColor clearColor];
        [self insertSubview:self.effectView  belowSubview:self.mainView];
    }
    if (self.param.wShadowShow) {
        [self insertSubview:self.shadowView  belowSubview:self.mainView];
        if (self.param.wShowAnimation != AninatonShowNone) {
            self.shadowView.alpha = 0;
            [UIView animateWithDuration:0.3 animations:^{
                self.shadowView.alpha = self.param.wShadowAlpha;
            }];
        }
    }
    [self bringSubviewToFront:self.mainView];
    [self setParentVCView:0.9];
 
    if(self.param.wEventCustomShowAmimal){
        self.param.wEventCustomShowAmimal(self.mainView, ^{
            @DialogStrongify(self)
            self.mainView.userInteractionEnabled = YES;
            self.shadowView.userInteractionEnabled = self.param.wShadowCanTap;
        });
    }else{
        [self dealAnamtionShowWithView:self.mainView withType:self.param.wShowAnimation withTime:self.param.wAnimationDurtion block:^{
            @DialogStrongify(self)
            self.mainView.userInteractionEnabled = YES;
            self.shadowView.userInteractionEnabled = self.param.wShadowCanTap;
        }];
    }
}

/// 关闭
- (void)closeView:(nullable AnimalBlock)block{
    if (!self.param.wAutoClose){
        if (block) block();
        return;;
    }
    self.close = YES;
    if (self.param.wType == DialogTypePay || self.param.wType == DialogTypeWrite)
        [self.mainView endEditing:YES];
    
    @DialogWeakify(self)
    if (self.param.wType == DialogTypeShare||
        self.param.wType == DialogTypeTabbarMenu||
        self.param.wType == DialogTypeNaviMenu) {
        WMZDialogAnimation *animation = [WMZDialogAnimation new];
        if (self.param.wEffectShow) {
            [UIView animateWithDuration:self.param.wAnimationDurtion animations:^{
                self.effectView.alpha = 0;
            }];
        }
        if (self.param.wShadowShow) {
            [UIView animateWithDuration:self.param.wAnimationDurtion animations:^{
                self.shadowView.alpha = 0;
            }];
        }
        for (UIView *view in [self.mainView subviews]) {
            if (view.tag != 10086) {
                [UIView animateWithDuration:self.param.wAnimationDurtion animations:^{
                    view.alpha = 0;
                }];
            }
        }
        [animation rotationDisappealClockwiseAnimationWithView:[self.mainView viewWithTag:666] duration:self.param.wAnimationDurtion];
        animation.block = ^{
            @DialogStrongify(self)
            [[self.mainView viewWithTag:666] removeFromSuperview];
        };
        UIScrollView *sc = [self.mainView viewWithTag:10086];
        if (sc && [sc isKindOfClass:UIScrollView.class]) {
            [UIView animateWithDuration:self.param.wAnimationDurtion * 1.5 animations:^{
                self.alpha = 0;
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
            }];
            springHideAnimation(sc, self.param.wAnimationDurtion, [sc subviews], ^{
                @DialogStrongify(self)
                [self closeBlock];
                if (block) block();
            });
        }
    }else{
        [self closeAction:block];
    }
    [self setParentVCView:1.0];
}

- (void)closeView{
    [self closeView:nil];
}

- (void)closeAction:(AnimalBlock)block{
    @DialogWeakify(self)
    if(self.isUserInteractionEnabled) self.userInteractionEnabled = NO;
    if(self.param.wEventCustomHideAmimal){
        if (self.param.wShadowShow) {
            [UIView animateWithDuration:self.param.wAnimationDurtion animations:^{
                self.shadowView.alpha = 0;
            }];
        }
        self.param.wEventCustomHideAmimal(self.mainView, ^{
            @DialogStrongify(self)
            [self closeBlock];
            if (block) block();
            [self removeFromSuperview];
        });
    }else{
        if (self.param.wHideAnimation) {
             if (self.param.wShadowShow) {
                 [UIView animateWithDuration:self.param.wAnimationDurtion animations:^{
                     self.shadowView.alpha = 0;
                 }];
            }
            [self dealAnamtionHideWithView:self.mainView withType:self.param.wHideAnimation withTime:self.param.wAnimationDurtion block:^{
                @DialogStrongify(self)
                [self closeBlock];
                if (block) block();
                [self removeFromSuperview];
            }];
        }else{
            if (block) block();
            [self closeBlock];
            [self removeFromSuperview];
        }
    }
}
- (void)closeBlock{
    if (self.param.wEventClose) self.param.wEventClose(self, self);
    [WMZDialogManage.shareInstance deleteDialog:self];
}

+ (void)closeWithshowView:(nullable UIView*)showView block:(nullable AnimalBlock)block{
    [WMZDialog closeWithshowView:showView tag:0 block:block];
}

+ (void)closeWithshowView:(nullable UIView*)showView tag:(NSInteger)tag block:(nullable AnimalBlock)block{
    UIView *view = showView?:DialogWindow;
    WMZDialog *dialog = nil;
    for (WMZDialog *sonView in view.subviews) {
        if ([sonView isKindOfClass:[WMZDialog class]]) {
            if (tag) {
                if (sonView.tag == tag) {
                    dialog = sonView;
                    break;
                }
            }else{
                dialog = sonView;
                break;
            }
        }
    }
    if (dialog) {
        dialog.param.wAutoClose = YES;
        [dialog closeView:block];;
    }
}

/// 缩放底部控制器
- (void)setParentVCView:(CGFloat)scale{
    if (!self.param.wScaleParentVC) return;
    if (self.param.wType != DialogTypeCardPresent) return;
    [UIView animateWithDuration:0.3 animations:^{
        UIViewController *VC = [WMZDialogUntils getCurrentVC];
        if (VC.navigationController) {
            VC.navigationController.view.transform = CGAffineTransformMakeScale(scale, scale);
        }else{
            VC.view.transform = CGAffineTransformMakeScale(scale, scale);
        }
    }];
}

/// 重新设置frame
- (void)reSetMainViewFrame:(CGRect)frame{
    CGPoint center = CGPointZero;
    frame.size.width = MIN(DialogScreenW, frame.size.width);
    frame.size.height = MIN(DialogScreenH - DialogStatusH - DialogSafeBottomHeight, frame.size.height);
    if (self.param.wMainToBottom) {
        frame.origin.y = DialogScreenH - CGRectGetMaxY(frame);
        if (DialogIsIphoneX) {
            frame.origin.y -= DialogSafeBottomHeight;
            frame.size.height += DialogSafeBottomHeight;
            UIView *view =  [UIView new];
            if (self.param.wType == DialogTypeShare) {
                view.backgroundColor = self.mainView.cancelBtn.backgroundColor;
            }else{
                view.backgroundColor = self.mainView.backgroundColor;
            }
            view.frame = CGRectMake(frame.origin.x, frame.size.height - DialogSafeBottomHeight, frame.size.width, DialogSafeBottomHeight);
            [self.mainView addSubview:view];
        }
        self.mainView.frame = frame;
        center = CGPointMake(self.center.x, self.mainView.center.y);
    }else{
        center = self.center;
        self.mainView.frame = frame;
    }
    self.mainView.center = center;
    if ([self.mainView respondsToSelector:@selector(mz_changeFrame:)]) {
        [self.mainView mz_changeFrame:[NSValue valueWithCGPoint:center]];
    }
}

/// 阴影点击
- (void)shadomClick{
    [self closeView];
    if (self.param.wEventShadomClose) self.param.wEventShadomClose(self, self.shadowView);
}

/// 横竖屏通知
- (void)change:(NSNotification*)notification{
    self.frame = self.superview.bounds;
    self.shadowView.frame = self.bounds;
    CGRect frame = self.mainView.frame;
    if (self.param.wMainToBottom) {
        frame.origin.y = DialogScreenH - frame.size.height;
        self.mainView.frame = frame;
        self.mainView.center = CGPointMake(self.center.x, self.mainView.center.y);
    }else{
        self.mainView.center = self.center;
        if (self.param.wType == DialogTypePay || self.param.wType == DialogTypeWrite) {
            [self becomeFirstResponder];
        }
    }
}

@end
