





//
//  WMZDialog+Loading.m
//  WMZDialog
//
//  Created by wmz on 2019/9/13.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "WMZDialog+Loading.h"
@implementation WMZDialog (Loading)
-(UIView*)loadingAction{
    self.mainView.backgroundColor = [UIColor clearColor];
    
    UIView *loadingView = [UIView new];
    loadingView.backgroundColor = [UIColor clearColor];
    loadingView.frame = CGRectMake((self.wWidth-self.wLoadingSize.width)/2,0,self.wLoadingSize.width,self.wLoadingSize.height);
    [self.mainView addSubview:loadingView];
    
    if (self.wLoadingType == LoadingStyleWait) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            loadingAnimation(loadingView, self.wAnimationDurtion, self.wLoadingColor, 4);
        });
    }else  if (self.wLoadingType == LoadingStyleRight) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            waitAnimation(loadingView, self.wAnimationDurtion, self.wLoadingColor,5.0f);
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8*self.wAnimationDurtion * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            rightAnimation(loadingView, self.wAnimationDurtion, self.wLoadingColor, 4.0f);
        });

    }else  if (self.wLoadingType == LoadingStyleError) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01*self.wAnimationDurtion * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            waitAnimation(loadingView, self.wAnimationDurtion, self.wLoadingColor,5.0f);
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8*self.wAnimationDurtion * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            errorAnimation(loadingView, self.wAnimationDurtion, self.wLoadingColor, 4.0f);
        });
    }
    
    [self.mainView addSubview:self.titleLabel];
    self.titleLabel.frame = CGRectMake(self.wMainOffsetX, CGRectGetMaxY(loadingView.frame)+self.wMainOffsetY, self.wWidth-self.wMainOffsetX*2, [WMZDialogTool heightForTextView:CGSizeMake(self.wWidth-self.wMainOffsetX*2, CGFLOAT_MAX) WithText:self.titleLabel.text WithFont:self.titleLabel.font.pointSize]);

    
    [self reSetMainViewFrame:CGRectMake(0,0,self.wWidth,CGRectGetMaxY(self.titleLabel.frame))];
    
    return self.mainView;
}
@end
