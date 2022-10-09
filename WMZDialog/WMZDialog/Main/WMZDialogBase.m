//
//  WMZDialogBase.m
//  WMZDialog
//
//  Created by wmz on 2019/6/21.
//  Copyright © 2019年 wmz. All rights reserved.
//

#import "WMZDialogBase.h"

@interface WMZDialogBase ()<CAAnimationDelegate>
@property (nonatomic, copy, readwrite) NSDictionary <NSNumber* , NSString*> *configDic;
@end

@implementation WMZDialogBase

- (void)dealAnamtionShowWithView:(UIView*)view withType:(DialogShowAnination)type withTime:(NSTimeInterval)time block:(AnimalBlock)block{
    WMZDialogAnimation *animal = [WMZDialogAnimation new];
    if (type == AninatonCurverOn) {
        [animal curverOnAnimationWithView:view duration:time];
    }else if (type == AninatonZoomIn) {
        [animal zoomInAnimationWithView:view duration:time];
    }else if (type == AninatonCounterclockwise) {
        [animal rotationClockwiseAnimationWithView:view duration:time];
    }else if (type == AninationCombineOne) {
        [animal combineShowOneAnimationWithView:view duration:time];
    }else if (type == AninationCombineTwo) {
        [animal combineShowTwoAnimationWithView:view duration:time];
    }else if (type == AninatonShowTop) {
        [animal verticalMoveShowAnimationWithView:view duration:time top:YES];
    }else if (type == AninatonShowBottom) {
        [animal verticalMoveShowAnimationWithView:view duration:time top:NO];
    }else if (type == AninatonShowLeft) {
        [animal landscapeMoveShowAnimationWithView:view duration:time right:NO];
    }else if (type == AninatonShowRight) {
        [animal landscapeMoveShowAnimationWithView:view duration:time right:YES];
    }else if (type == AninatonShowScaleFade) {
        [animal scaleShowAninationWithView:view duration:time];
    }else if (type == AninatonZoomInCombin) {
        [animal zoomInBigToNormalAnimationWithView:view duration:time];
    }
    if (block) {
        animal.block = ^{
            block();
        };
    }
}

- (void)dealAnamtionHideWithView:(UIView*)view withType:(DialogHideAnination)type withTime:(NSTimeInterval)time block:(AnimalBlock)block{
    WMZDialogAnimation *animal = [WMZDialogAnimation new];
    if (type == AninatonCurverOff) {
        [animal curverOffAnimationWithView:view duration:time];
    }else if (type == AninatonZoomOut) {
        [animal zoomOutAnimationWithView:view duration:time];
    }else if (type == AninatonClockwise) {
        [animal rotationCounterclockwiseAnimationWithView:view duration:time];
    }else if (type == AninationHideCombineOne) {
        [animal combineHideOneAnimationWithView:view duration:time];
    }else if (type == AninatonHideTop) {
        [animal verticalMoveHideAnimationWithView:view duration:time top:YES];
    }else if (type == AninatonHideBottom) {
        [animal verticalMoveHideAnimationWithView:view duration:time top:NO];
    }else if (type == AninatonHideLeft) {
        [animal landscapeMoveHideAnimationWithView:view duration:time right:NO];
    }else if (type == AninatonHideRight) {
        [animal landscapeMoveHideAnimationWithView:view duration:time right:YES];
    }else if (type == AninatonHideScaleFade) {
        [animal scaleHideAninationWithView:view duration:time];
    }
    if (block) {
        animal.block = ^{
            block();
        };
    }
}
#pragma -mark 更新下载进度条
- (BOOL)updateAlertTypeDownProgress:(CGFloat)value{
    if ([self.mainView conformsToProtocol:@protocol(WMZCustomPrototol)] &&
        [self.mainView respondsToSelector:@selector(mz_changeValue:)])
        return [self.mainView mz_changeValue:@(value)];
    return NO;
}

- (void)updateMenuChildrenDataWithSection:(NSInteger)section  withUpdateChildren:(BOOL)update withData:(NSArray*)data{
    
}

- (void)keyboardWillShow:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    CGRect endFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.keyBoardHeight = endFrame.size.height;
    CGRect frame = self.mainView.frame;
    if (CGRectEqualToRect(self.beforeRect, CGRectZero))  self.beforeRect = frame;
    frame.origin.y = DialogScreenH - (endFrame.size.height + self.mainView.frame.size.height + DialogK1px + self.param.wKeyBoardMarginY);
    NSTimeInterval animationDuration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:animationDuration animations:^{
        self.mainView.frame = frame;
    }];
}

/// 键盘将要消失
- (void)keyboardWillHide:(NSNotification *)notification{
    if (CGRectEqualToRect(self.beforeRect, CGRectZero))  return;
    self.keyBoardHeight = 0;
    NSDictionary *userInfo = notification.userInfo;
    NSTimeInterval animationDuration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:animationDuration animations:^{
        self.mainView.frame = self.beforeRect;
    }];
}

- (WMZDialogNormal *)mainView{
    if (!_mainView) {
        _mainView = WMZDialogNormal.new;
    }
    return _mainView;
}

- (UIView *)shadowView{
    if (!_shadowView) {
        _shadowView = [UIView new];
    }
    return _shadowView;
}

- (UIVisualEffectView *)effectView{
    if (!_effectView) {
        UIBlurEffectStyle style = UIBlurEffectStyleLight;
        if (@available(iOS 13.0, *) ) {
            BOOL isDark = (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark);
            if (isDark && self.wOpenDark) style = UIBlurEffectStyleDark;
        }
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:style];
        _effectView= [[UIVisualEffectView alloc] initWithEffect:effect];
        _effectView.frame = self.bounds;
    }
    return _effectView;
}

- (WMZDialogParam *)param{
    if (!_param) {
        _param = WMZDialogParam.new;
    }
    return _param;
}

- (NSDictionary<NSNumber *,NSString *> *)configDic{
    if (!_configDic) {
        _configDic = @{
            @(DialogTypeNornal):@"WMZDialogNormalView",
            @(DialogTypeSheet):@"WMZDialogSelectView",
            @(DialogTypeAuto):@"WMZDialogNormalView",
            @(DialogTypePay):@"WMZDialogEditView",
            @(DialogTypeShare):@"WMZDialogNormalView",
            @(DialogTypeWrite):@"WMZDialogEditView",
            @(DialogTypeSelect):@"WMZDialogSelectView",
            @(DialogTypeDown):@"WMZDialogNormalView",
            @(DialogTypePop):@"WMZDialogSelectView",
            @(DialogTypePickSelect):@"WMZDialogSelectView",
            @(DialogTypeMenusSelect):@"WMZDialogSelectView",
            @(DialogTypeAdvertisement):@"WMZDialogNormalView",
            @(DialogTypeLocation):@"WMZDialogSelectView",
            @(DialogTypeDatePicker):@"WMZDialogDateView",
            @(DialogTypeTabbarMenu):@"WMZDialogNormalView",
            @(DialogTypeNaviMenu):@"WMZDialogNormalView",
            @(DialogTypeLoading):@"WMZDialogNormalView",
            @(DialogTypeCardPresent):@"WMZDialogSelectView",
            @(DialogTypeCalander):@"WMZDialogDateView",
            @(DialogTypeToast):@"WMZDialogNormalView",
        };
    }
    return _configDic;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

- (id)valueForUndefinedKey:(NSString *)key{
    return nil;
}

@end

