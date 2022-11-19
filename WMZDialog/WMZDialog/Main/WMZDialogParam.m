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

DialogCalanderLimitTypeKey const DialogCalanderLimitCloseClick = @"WMZDialogCalanderLimitCloseClick";
DialogCalanderLimitTypeKey const DialogCalanderLimitHide = @"WMZDialogCalanderLimitHide";
DialogCalanderLimitTypeKey const DialogCalanderLimitGray = @"WMZDialogCalanderLimitGray";
DialogCalanderLimitTypeKey const DialogCalanderLimitCloseScroll = @"WMZDialogCalanderLimitCloseScroll";

@implementation WMZDialogParam
- (instancetype)init{
    if (self = [super init]){
        [WMZDialogManage.shareInstance setUpManageDefaultParam:self];
    }
    return self;
}
@end

@implementation WMZDialogParentParam

/// 根据type设置默认属性
- (void)setUpDefaultParam{
    self.wLevel = MIN(999, MAX(0, self.wLevel));
    BOOL left = ([UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeLeft || [UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeRight);
    switch (self.wType) {
        case DialogTypeSheet:{
            if (self.wHeight == DialogSize.height) self.wHeight = DialogRealW(200);
            self.wMainToBottom = YES;
            if (self.wWidth == DialogSize.width) self.wWidth =  left ? DialogScreenH : DialogScreenW;
            if (self.wMainBtnHeight == DialogRealW(60)) self.wMainBtnHeight = DialogRealW(88);
        }
            break;
        case DialogTypePay:{
            if (!self.wTitle) self.wTitle = @"请输入支付密码";
            if (!self.wMessage) self.wMessage = @"￥100.00";
        }
        break;
        case DialogTypeShare:{
            if (self.wHeight == DialogSize.height) self.wHeight = DialogRealW(150);
            self.wMainToBottom = YES;
            if (self.wWidth == DialogSize.width) self.wWidth = left ? DialogScreenH : DialogScreenW;
            if (self.wMainBtnHeight == DialogRealW(60)) self.wMainBtnHeight += DialogRealW(10);
            self.wShowAnimation = AninatonShowNone;
        }
        break;
        case DialogTypePickSelect:{
            self.wMainToBottom = YES;
            if (self.wWidth == DialogSize.width) self.wWidth = left ? DialogScreenH : DialogScreenW;
        }
        break;
        case DialogTypePop:{
            if (self.wMainOffsetY == DialogRealW(20)) self.wMainOffsetY = 0;
            if (self.wPopStyleType == DialogPopTypeTable) {
                if (self.wWidth == DialogSize.width) self.wWidth = DialogRealW(300);
            }else if(self.wPopStyleType == DialogPopTypeShare){
                self.wTextAlignment = NSTextAlignmentCenter;
                if (self.wCellHeight == DialogRealW(80)) self.wCellHeight = DialogRealW(100);
            }
            
        }
            break;
        case DialogTypeMenusSelect:{
            if (self.wHeight == DialogSize.height) self.wHeight = self.wCellHeight * 3;
            self.wMainToBottom = YES;
            if (self.wWidth == DialogSize.width) self.wWidth = left ? DialogScreenH : DialogScreenW;
        }
            break;
        case DialogTypeAdvertisement:{
            self.wMainBackColor = [UIColor clearColor];
            self.wShadowCanTap = NO;
        }
            break;
        case DialogTypeLocation:{
            if (self.wHeight == DialogSize.height && self.wChainType == ChainTableView) self.wHeight = self.wCellHeight * 3;
            self.wMainToBottom = YES;
            if (self.wWidth == DialogSize.width) self.wWidth = left ? DialogScreenH : DialogScreenW;
        }
            break;
        case DialogTypeDatePicker:{
            self.wMainToBottom = YES;
            if (self.wWidth == DialogSize.width) self.wWidth = left ? DialogScreenH : DialogScreenW;
        }
            break;
        case DialogTypeTabbarMenu:{
            if (self.wHeight == DialogSize.height) self.wHeight = DialogRealW(150);
            self.wMainToBottom = YES;
            if (self.wWidth == DialogSize.width) self.wWidth = left ? DialogScreenH : DialogScreenW;
            if (self.wMainBtnHeight == DialogRealW(60)) self.wMainBtnHeight += DialogRealW(10);
            self.wShowAnimation = AninatonShowNone;
            self.wEffectShow = YES;
        }
            break;
        case DialogTypeNaviMenu:{
            if (self.wHeight == DialogSize.height) self.wHeight = DialogRealW(150);
            self.wMainToBottom = YES;
            if (self.wWidth == DialogSize.width) self.wWidth = left ? DialogScreenH : DialogScreenW;
            if (self.wMainBtnHeight == DialogRealW(60)) self.wMainBtnHeight += DialogRealW(10);
            self.wShowAnimation = AninatonShowNone;
        }
            break;
        case DialogTypeLoading:{
            if (self.wWidth == DialogSize.width) self.wWidth = self.wLoadingSize.width * 2.5;
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
            if (self.wWidth == DialogSize.width) {
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
            if (self.wWidth == DialogSize.width) self.wWidth = left ? DialogScreenH : DialogScreenW;
            if (self.wHeight == DialogSize.height) self.wHeight = DialogScreenH - DialogNaviH;
            if (self.wAnimationDurtion == 0.5f)  self.wAnimationDurtion = 0.3;
            self.wHeight = MIN(DialogScreenH - [[UIApplication sharedApplication] statusBarFrame].size.height, self.wHeight);
        }
            break;
        case DialogTypeMyView:{
            if (self.wHeight == DialogSize.height) self.wHeight = 0;
            break;
        }
        case DialogTypeCalander:{
            if(!DialogArrayNotEmpty(self.wCalanderWeekTitleArr) || self.wCalanderWeekTitleArr.count != 7){
                NSLog(@"周期错误");
                self.wCalanderWeekTitleArr = @[@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"];
            }
            break;
        }
        default:
            break;
    }
    if (self.wHeight > (left ? DialogScreenW : DialogScreenH) && self.wType != DialogTypeCardPresent) self.wHeight = left ? DialogScreenW : DialogScreenH;
    if (self.wWidth > (left ? DialogScreenH : DialogScreenW)) self.wWidth = left ? DialogScreenH : DialogScreenW;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

- (id)valueForUndefinedKey:(NSString *)key{
    return nil;
}
@end
