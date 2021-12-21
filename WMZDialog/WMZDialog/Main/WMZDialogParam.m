//
//  WMZDialogParam.m
//  WMZDialog
//
//  Created by wmz on 2021/7/17.
//  Copyright © 2021 wmz. All rights reserved.
//

#import "WMZDialogParam.h"

DialogRegularKey const DialogRegularMaxTip = @"maxNumTip";
DialogRegularKey const DialogRegulars = @"reguler";
DialogRegularKey const DialogRegularTip = @"regulerTip";

DialogDarkColorKey const DialogDarkFollowSystem = @"WMZDialogDarkFollowSystem";
DialogDarkColorKey const DialogDarkMainColor = @"WMZDialogDarkMainColor";
DialogDarkColorKey const DialogDarkC2 = @"WMZDialogDarkC2";
DialogDarkColorKey const DialogDarkC3 = @"WMZDialogDarkC3";
DialogDarkColorKey const DialogDarkC4 = @"WMZDialogDarkC4";

@implementation WMZDialogParam
- (instancetype)init{
    if (self = [super init]) [WMZDialogParam setDefaultPropertiess:self];
    return self;
}

+ (void)setDefaultPropertiess:(WMZDialogParam*)param{
    BOOL left = ([UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeLeft || [UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeRight);
    param.wType = DialogTypeNornal;
    param.wWidth = DialogRealW(500);
    param.wHeight = DialogRealW(400);
    param.wAnimationDurtion = 0.3f;
    param.wDisappelSecond = 1.5f;
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
    param.wShadowAlpha = 0.4f;
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
    param.wLocationType = 3;
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
    param.wListScrollCount = left ? 5 : 8;
    param.wSeparatorStyle = UITableViewCellSeparatorStyleNone;
    param.wAngleSize = CGSizeMake(DialogRealW(24), DialogRealW(16));
    param.wOpenMultiZone = YES;
    param.wXMLPathName = [[NSBundle bundleWithPath:[[NSBundle bundleForClass:[WMZDialogParam class]] pathForResource:@"WMZDialog" ofType:@"bundle"]] pathForResource:@"province_data" ofType:@"xml"];
    param.wCheckImage = [UIImage imageNamed:[[NSBundle bundleWithPath:[[NSBundle bundleForClass:[WMZDialogParam class]] pathForResource:@"WMZDialog" ofType:@"bundle"]] pathForResource:@"dialog_check" ofType:@"png"]];
    param.wLoadingWidth = 2.5f;
    param.wAutoClose = YES;
    param.wLevel = DialogLevelHigh;
    param.wLimitAlpha = 1;
    param.wPoint = CGPointMake(-999, -999);
    param.wPopStyleType = DialogPopTypeTable;
    [self setDefaultColorPropertiess:param];
}

+ (void)setDefaultColorPropertiess:(WMZDialogParam*)param{
    param.wShadowColor = DialogColor(0x333333);
    param.wOKColor = DialogColor(0xFF9900);
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
    param.wInputBackGroundColor =  DialogDarkOpenColor(DialogColor(0xffffff), WMZDialogManage.shareInstance.darkColorInfo[DialogDarkMainColor], param.wOpenDark);
}

/// 根据type设置默认属性
- (void)setUpDefaultParam{
    self.wLevel = MIN(999, MAX(0, self.wLevel));
    BOOL left = ([UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeLeft || [UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeRight);
    switch (self.wType) {
        case DialogTypeSheet:{
            if (self.wHeight == DialogRealW(400)) self.wHeight = DialogRealW(200);
            self.wMainToBottom = YES;
            if (self.wWidth == DialogRealW(500)) self.wWidth =  left ? DialogScreenH : DialogScreenW;
            if (self.wMainBtnHeight == DialogRealW(60)) self.wMainBtnHeight = DialogRealW(88);
        }
            break;
        case DialogTypePay:{
            if (!self.wTitle) self.wTitle = @"请输入支付密码";
            if (!self.wMessage) self.wMessage = @"￥100.00";
        }
        break;
        case DialogTypeShare:{
            if (self.wHeight == DialogRealW(400)) self.wHeight = DialogRealW(150);
            self.wMainToBottom = YES;
            if (self.wWidth == DialogRealW(500)) self.wWidth = left ? DialogScreenH : DialogScreenW;
            if (self.wMainBtnHeight == DialogRealW(60)) self.wMainBtnHeight+=DialogRealW(10);
            self.wShowAnimation = AninatonShowNone;
        }
        break;
        case DialogTypePickSelect:{
            self.wMainToBottom = YES;
            if (self.wWidth == DialogRealW(500)) self.wWidth = left ? DialogScreenH : DialogScreenW;
        }
        break;
        case DialogTypePop:{
            if (self.wMainOffsetY == DialogRealW(20)) self.wMainOffsetY = 0;
            if (self.wPopStyleType == DialogPopTypeTable) {
                if (self.wWidth == DialogRealW(500)) self.wWidth = DialogRealW(300);
                if (DialogArrayNotEmpty(self.wData)) {
                    for (id data in self.wData) {
                        if ([data isKindOfClass:[NSDictionary class]]) {
                            if (data[@"image"]) {
                                self.wTextAlignment = NSTextAlignmentLeft;
                            }
                        }
                    }
                }
            }else if(self.wPopStyleType == DialogPopTypeShare){
                self.wTextAlignment = NSTextAlignmentCenter;
                if (self.wCellHeight == DialogRealW(80)) self.wCellHeight = DialogRealW(100);
            }
            
        }
            break;
        case DialogTypeMenusSelect:{
            if (self.wHeight == DialogRealW(400)) self.wHeight = self.wCellHeight*3;
            self.wMainToBottom = YES;
            if (self.wWidth == DialogRealW(500)) self.wWidth = left ? DialogScreenH : DialogScreenW;
        }
            break;
        case DialogTypeAdvertisement:{
            self.wMainBackColor = [UIColor clearColor];
            self.wShadowCanTap = NO;
        }
            break;
        case DialogTypeLocation:{
            self.wTextAlignment = NSTextAlignmentLeft;
            if (self.wHeight == DialogRealW(400) && self.wChainType == ChainTableView) self.wHeight = self.wCellHeight * 3;
            self.wMainToBottom = YES;
            if (self.wWidth == DialogRealW(500)) self.wWidth = left ? DialogScreenH : DialogScreenW;
        }
            break;
        case DialogTypeDatePicker:{
            self.wMainToBottom = YES;
            if (self.wWidth == DialogRealW(500)) self.wWidth = left ? DialogScreenH : DialogScreenW;
        }
            break;
        case DialogTypeTabbarMenu:{
            if (self.wHeight == DialogRealW(400)) self.wHeight = DialogRealW(150);
            self.wMainToBottom = YES;
            if (self.wWidth == DialogRealW(500)) self.wWidth = left ? DialogScreenH : DialogScreenW;
            if (self.wMainBtnHeight == DialogRealW(60)) self.wMainBtnHeight+=DialogRealW(10);
            self.wShowAnimation = AninatonShowNone;
            self.wEffectShow = YES;
        }
            break;
        case DialogTypeNaviMenu:{
            if (self.wHeight == DialogRealW(400)) self.wHeight = DialogRealW(150);
            self.wMainToBottom = YES;
            if (self.wWidth == DialogRealW(500)) self.wWidth = left ? DialogScreenH : DialogScreenW;
            if (self.wMainBtnHeight == DialogRealW(60)) self.wMainBtnHeight+=DialogRealW(10);
            self.wShowAnimation = AninatonShowNone;
        }
            break;
        case DialogTypeLoading:{
            if (self.wWidth == DialogRealW(500)) self.wWidth = self.wLoadingSize.width*2.5;
            if (self.wWidth < self.wLoadingSize.width) self.wWidth = self.wLoadingSize.width;
            if (CGColorEqualToColor(self.wMainBackColor.CGColor, DialogColor(0xFFFFFF).CGColor))
                self.wMainBackColor = DialogColor(0x333333);
            if (CGColorEqualToColor(self.wTitleColor.CGColor, DialogColor(0x333333).CGColor))
                self.wTitleColor = DialogColor(0xffffff);
            if (self.wDisappelSecond == 1.5) self.wDisappelSecond = 0;
        }
             break;
        case DialogTypeAuto:
        case DialogTypeToast:{
            if (self.wWidth == DialogRealW(500)) {
                if (self.wType == DialogTypeToast) {
                    self.wWidth = left ? DialogScreenH : DialogScreenW - 2 * self.wMainOffsetX;
                }else{
                    self.wWidth = DialogRealW(400);
                }
            }
            if (self.wType == DialogTypeAuto && !self.wAutoMaxWidth)
                self.wAutoMaxWidth = self.wWidth;
            
            self.wShadowShow = NO;
            if (CGColorEqualToColor(self.wMainBackColor.CGColor, DialogColor(0xFFFFFF).CGColor))
                self.wMainBackColor = DialogColor(0x333333);
            if (CGColorEqualToColor(self.wMessageColor.CGColor, DialogColor(0x333333).CGColor))
                self.wMessageColor = DialogColor(0xffffff);
        }
            break;
        case DialogTypeCardPresent:{
            self.wMainToBottom = YES;
            if (self.wWidth == DialogRealW(500)) self.wWidth = left ? DialogScreenH : DialogScreenW;
            if (self.wHeight == DialogRealW(400)) self.wHeight = DialogScreenH - DialogNaviH;
            if (self.wAnimationDurtion == 0.5f)  self.wAnimationDurtion = 0.3;
            self.wHeight = MIN(DialogScreenH - [[UIApplication sharedApplication] statusBarFrame].size.height, self.wHeight);
        }
            break;
        case  DialogTypeMyView:{
            if (self.wHeight == DialogRealW(400)) self.wHeight = 0;
            break;
        }
        default:
            break;
    }
    if (self.wHeight > (left ? DialogScreenW : DialogScreenH) && self.wType != DialogTypeCardPresent) self.wHeight = left ? DialogScreenW : DialogScreenH;
    if (self.wWidth > (left ? DialogScreenH : DialogScreenW)) self.wWidth = left ? DialogScreenH : DialogScreenW;
}
@end
