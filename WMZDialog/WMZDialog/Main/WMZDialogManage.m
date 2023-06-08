//
//  WMZDialogManage.m
//  WMZDialog
//
//  Created by wmz on 2021/4/9.
//  Copyright © 2021 wmz. All rights reserved.
//

#import "WMZDialogManage.h"
#import "WMZDialogParam.h"
#import <objc/runtime.h>

static WMZDialogManage* dialogManage = nil;

@interface WMZDialogManage()
/// 全局
@property (nonatomic, strong, readwrite) WMZDialogParentParam *globalParam;

@end

@implementation WMZDialogManage

+ (instancetype)shareInstance{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        dialogManage = [[super allocWithZone:NULL] init];
        dialogManage.dialogInfo = [NSMutableDictionary new];
        dialogManage.globalParam = WMZDialogParentParam.new;
        [WMZDialogManage setDefaultPropertiess:dialogManage.globalParam];
    }) ;
    return dialogManage ;
}

/// 全局配置
+ (void)settingGlobalConfig:(DialogCustomParam)block{
    if(block) block((id)WMZDialogManage.shareInstance.globalParam);
}

- (void)setUpManageDefaultParam:(WMZDialogParentParam*)param{
    if(self.globalParam){
        u_int count = 0;
        objc_property_t *properties = class_copyPropertyList([WMZDialogParentParam class], &count);
        for (int i = 0; i < count; i++) {
            const char *propertyName = property_getName(properties[i]);
            NSString *proper = [NSString stringWithUTF8String:propertyName];
            if (![proper isEqualToString:@"wOpenDark"]) {
                id object = [self.globalParam valueForKey:proper];
                if(object){
                    [param setValue:object forKey:proper];
                }
            }
        }
        free(properties);
    }
}

+ (void)setDefaultPropertiess:(WMZDialogParentParam*)param{
    BOOL left = ([UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeLeft ||
                 [UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeRight);
    param.wType = DialogTypeNornal;
    param.wWidth = DialogSize.width;
    param.wHeight = DialogSize.height;
    param.wAnimationDurtion = 0.3f;
    param.wDisappelSecond = DialogDisappealTime;
    param.wMainBtnHeight = DialogRealW(60);
    param.wCellHeight =  DialogRealW(80);
    param.wOKTitle = @"确定";
    param.wCancelTitle = @"取消";
    param.wMainRadius = 8.0f;
    param.wMainOffsetY = DialogRealW(20);
    param.wMainOffsetX = DialogRealW(15);
    param.wLineAlpha = 0.9f;
    param.wTitleFont = 14.0f;
    param.wMessageFont = 16.0f;
    param.wOKFont = 16.0f;
    param.wCancelFont = 16.0f;
    param.wShadowAlpha = 0.3f;
    param.wKeyBoardMarginY = DialogRealW(40);
    param.wPayNum = 5;
    param.wDefaultSelectPayStr = @"农业银行";
    param.wShadowCanTap = YES;
    param.wShadowShow = YES;
    param.wWirteTextMaxNum  = -1;
    param.wWirteTextMaxLine = 7;
    param.wPercentAngle =  0.5f;
    param.wPercentOrginX = 1.0f;
    param.wColumnCount = 4;
    param.wRowCount = 1;
    param.wDirection = directionDowm;
    param.wImageSize = CGSizeMake(DialogRealW(110), DialogRealW(110));
    param.wTextAlignment = NSTextAlignmentCenter;
    param.wLocationType = DialogLocationProAndCityAndDis;
    param.wChainType = ChainPickView;
    param.wDateTimeType = @"yyyy-MM-dd HH:mm:ss";
    param.wPlaceholder = @"请输入";
    param.wLoadingSize = CGSizeMake(DialogRealW(90),  DialogRealW(90));
    param.wSeparator = @",";
    param.wLeftScrollClose = YES;
    param.wOpenScrollClose = YES;
    param.wOpenDragging = YES;
    param.wScaleParentVC = YES;
    param.wCalanderCanScroll = YES;
    param.wOpenChineseDate = YES;
    param.wHideCalanderBtn = YES;
    param.wDefaultDate = [NSDate date];
    param.wCanSelectPay = YES;
    param.wPopViewBorderColor = param.wMainBackColor;
    param.wTapRect = CGRectZero;
    param.wPopViewRectCorner = DialogRectCornerNone;
    param.wTag = 12345;
    param.wUserInteractionEnabled = YES;
    param.wListScrollCount = left ? 5 : 8;
    param.wSeparatorStyle = UITableViewCellSeparatorStyleNone;
    param.wAngleSize = CGSizeMake(DialogRealW(24), DialogRealW(16));
    param.wOpenMultiZone = YES;
    param.wXMLPathName = [[NSBundle bundleWithPath:[[NSBundle bundleForClass:[WMZDialogParam class]] pathForResource:@"WMZDialog" ofType:@"bundle"]] pathForResource:@"province_data" ofType:@"xml"];
    param.wCheckImage = [[UIImage imageNamed:[[NSBundle bundleWithPath:[[NSBundle bundleForClass:[WMZDialogParam class]] pathForResource:@"WMZDialog" ofType:@"bundle"]] pathForResource:@"dialog_check" ofType:@"png"]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    param.wLoadingWidth = 2.5f;
    param.wAutoClose = YES;
    param.wLevel = DialogLevelHigh;
    param.wLimitAlpha = 1;
    param.wPoint = CGPointMake(-999, -999);
    param.wPopStyleType = DialogPopTypeTable;
    param.wCalanderWeekTitleArr = @[@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"];
    param.wMinMaxResultArr = @[DialogCalanderLimitCloseClick];
    param.wCellBackgroundColor = DialogColor(0xffffff);
    param.wCellIconSize = CGSizeMake(DialogRealW(60), DialogRealW(60));
    param.wCellAlignType = DialogCellAlignLeft;
    param.wDeviceDidChange = NO;
    [self setDefaultColorPropertiess:param];
}

+ (void)setDefaultColorPropertiess:(WMZDialogParentParam*)param{
    param.wShadowColor = DialogColor(0x333333);
    param.wOKColor = DialogColor(0xFF9900);
    param.wThemeColor = param.wOKColor;
    param.wProgressTintColor = DialogColor(0xFF9900);
    param.wTrackTintColor = DialogColor(0xF3F4F6);
    param.wLoadingColor = DialogColor(0x108ee9);
    param.wTableViewColor = @[
        DialogDarkOpenColor(DialogColor(0xffffff), WMZDialogManage.shareInstance.darkColorInfo[DialogDarkMainColor], param.wOpenDark),
        DialogDarkOpenColor(DialogColor(0xF6F7FA), WMZDialogManage.shareInstance.darkColorInfo[DialogDarkMainColor], param.wOpenDark),
        DialogDarkOpenColor(DialogColor(0xEBECF0), WMZDialogManage.shareInstance.darkColorInfo[DialogDarkMainColor], param.wOpenDark),
        DialogDarkOpenColor(DialogColor(0xffffff), WMZDialogManage.shareInstance.darkColorInfo[DialogDarkMainColor], param.wOpenDark)];
    param.wCancelColor = DialogDarkOpenColor(DialogColor(0x666666), DialogColor(0xffffff), param.wOpenDark);
    param.wMainBackColor = DialogDarkOpenColor(DialogColor(0xffffff), WMZDialogManage.shareInstance.darkColorInfo[DialogDarkMainColor], param.wOpenDark);
    param.wLineColor =  DialogDarkOpenColor([[UIColor lightGrayColor] colorWithAlphaComponent:0.4], [[UIColor whiteColor] colorWithAlphaComponent:0.4],param.wOpenDark);
    param.wTitleColor =  DialogDarkOpenColor(DialogColor(0x333333), DialogColor(0xffffff), param.wOpenDark);
    param.wMessageColor = DialogDarkOpenColor(DialogColor(0x333333), DialogColor(0xffffff), param.wOpenDark);
    param.wInputTextColor = DialogDarkOpenColor(DialogColor(0x333333), DialogColor(0xffffff), param.wOpenDark);
    param.wInputBackGroundColor =  DialogDarkOpenColor(DialogColor(0xffffff), WMZDialogManage.shareInstance.darkColorInfo[DialogDarkMainColor], param.wOpenDark);
}

- (void)addDialog:(id)dialog cover:(BOOL)cover superView:(UIView*)superView{
    id key = nil;
    if ([dialog isKindOfClass:NSClassFromString(@"WMZDialog")]) {
        NSInteger tag = [[dialog valueForKey:@"wTag"] integerValue];
        key = @(tag);
    }
    if (key) {
        if ([self.dialogInfo objectForKey:key]) {
            if (cover) [self.dialogInfo setObject:dialog forKey:key];
        }else{
            [self.dialogInfo setObject:dialog forKey:key];
        }
        NSMutableArray *dialogArr = [NSMutableArray new];
        for (UIView *dialogView in superView.subviews) {
            if ([dialogView isKindOfClass:NSClassFromString(@"WMZDialog")]) {
                [dialogArr addObject:dialogView];
            }
        }
        NSInteger level = [[dialog valueForKey:@"wLevel"] integerValue];
        if (dialogArr.count > 0) {
            if (level == 999) { 
                [superView insertSubview:dialog aboveSubview:dialogArr.lastObject];
            }else if (level == 0) {
                [superView insertSubview:dialog belowSubview:dialogArr.firstObject];
            }else {
                UIView *lastDialog = nil;
                if (dialogArr.count == 1) {
                    lastDialog = dialogArr.firstObject;
                    NSInteger lastDialogLevel = [[lastDialog valueForKey:@"wLevel"] integerValue];
                    if (level >= lastDialogLevel) {
                        [superView insertSubview:dialog aboveSubview:lastDialog];
                    }else{
                        [superView insertSubview:dialog belowSubview:lastDialog];
                    }
                }else{
                    NSMutableArray *tempArr = [NSMutableArray arrayWithArray:dialogArr];
                    [tempArr sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                        NSInteger obj1Level = [[obj1 valueForKey:@"wLevel"] integerValue];
                        NSInteger obj2Level = [[obj2 valueForKey:@"wLevel"] integerValue];
                        return obj1Level > obj2Level;
                    }];
                    UIView *first = tempArr.firstObject;
                    UIView *last = tempArr.lastObject;
                    NSInteger firstLevel = [[first valueForKey:@"wLevel"] integerValue];
                    NSInteger lastLevel = [[last valueForKey:@"wLevel"] integerValue];
                    if (level < firstLevel) {
                        [superView insertSubview:dialog belowSubview:first];
                    }else if (level > lastLevel){
                        [superView insertSubview:dialog aboveSubview:last];
                    }else{
                        for (UIView *cueerntDialog in tempArr) {
                            NSInteger currentLevel = [[cueerntDialog valueForKey:@"wLevel"] integerValue];
                            if (level > currentLevel) {
                                [superView insertSubview:dialog aboveSubview:cueerntDialog];
                                break;
                            }
                        }
                    }
                }
            }
        }else{
            [superView addSubview:dialog];
        }
    }
}

- (void)deleteDialog:(id)dialog{
    id key = nil;
    if ([dialog isKindOfClass:NSClassFromString(@"WMZDialog")]) {
        NSInteger tag = [[dialog valueForKey:@"wTag"] integerValue];
        key = @(tag);
    }
    if ([self.dialogInfo objectForKey:key]) {
        [self.dialogInfo removeObjectForKey:key];
        dialog = nil;
    }
}

- (WMZDialog*)currentDialog:(UIView*)normalView{
    UIView *currentView = normalView;
    while (![currentView.superview isKindOfClass:NSClassFromString(@"WMZDialog")]) {
        currentView = currentView.superview;
    }
    if ([currentView.superview isKindOfClass:NSClassFromString(@"WMZDialog")]) return (WMZDialog*)currentView.superview;
    return nil;
}

- (NSMutableDictionary<NSString *,UIColor *> *)darkColorInfo{
    if (!_darkColorInfo) {
        _darkColorInfo = [NSMutableDictionary dictionaryWithDictionary:@{
            DialogDarkMainColor:DialogColor(0x191919),
            DialogDarkC2:DialogColor(0x373637),
            DialogDarkC3:DialogColor(0x2c2c2c),
        }];
    }
    return _darkColorInfo;
}

+ (id)allocWithZone:(struct _NSZone *)zone{
    return WMZDialogManage.shareInstance;
}

- (id)copyWithZone:(struct _NSZone *)zone{
    return  WMZDialogManage.shareInstance;
}

@end
