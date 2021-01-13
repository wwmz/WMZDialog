





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
    UIView *loadingView = [UIView new];
    loadingView.backgroundColor = [UIColor clearColor];
    loadingView.frame = CGRectMake((self.wWidth-self.wLoadingSize.width)/2,self.wMainOffsetY *2,self.wLoadingSize.width,self.wLoadingSize.height);
    [self.mainView addSubview:loadingView];
    if (self.wLoadingType == LoadingStyleWait) {
        loadingAnimation(loadingView, self.wAnimationDurtion, self.wLoadingColor, 4);
    }else  if (self.wLoadingType == LoadingStyleRight) {
        waitAnimation(loadingView, self.wAnimationDurtion, self.wLoadingColor,5.0f);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8*self.wAnimationDurtion * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            rightAnimation(loadingView, self.wAnimationDurtion, self.wLoadingColor, 4.0f);
        });
    }else  if (self.wLoadingType == LoadingStyleError) {
        waitAnimation(loadingView, self.wAnimationDurtion, self.wLoadingColor,5.0f);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8*self.wAnimationDurtion * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            errorAnimation(loadingView, self.wAnimationDurtion, self.wLoadingColor, 4.0f);
        });
    }else  if (self.wLoadingType == LoadingStyleSystem) {
        UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [self.mainView addSubview:activity];
        activity.tag = 999;
        activity.frame = loadingView.frame;
        [activity startAnimating];
    }
    
    if (self.titleLabel.text.length) {
        [self.mainView addSubview:self.titleLabel];
        self.titleLabel.frame = CGRectMake(self.wMainOffsetX, CGRectGetMaxY(loadingView.frame)+self.wMainOffsetY, self.wWidth-self.wMainOffsetX*2, [WMZDialogTool sizeForTextView:CGSizeMake(self.wWidth-self.wMainOffsetX*2, CGFLOAT_MAX) text:self.titleLabel.text font:self.titleLabel.font.pointSize].height);

    }
    if (self.wShowClose) {
        [self.mainView addSubview:self.wCloseBtn];
        self.wCloseBtn.layer.borderWidth = 0;
        [self.wCloseBtn setTitle:@"" forState:UIControlStateNormal];
        [self.wCloseBtn setImage:[UIImage imageWithContentsOfFile:[self.dialogBundle pathForResource:@"dialog_close1" ofType:@"png"]] forState:UIControlStateNormal];
        CGFloat width = Dialog_GetWNum(40);
        self.wCloseBtn.frame = CGRectMake(self.wWidth - width - 5 , 5, width, width);
        self.wCloseBtn.layer.cornerRadius = width/2;
        self.wCloseBtn.layer.backgroundColor = DialogColor(0x809199).CGColor;
    }
    
    [self reSetMainViewFrame:CGRectMake(0,0,self.wWidth,
                                        CGRectGetMaxY(self.titleLabel.text.length?self.titleLabel.frame:loadingView.frame) + self.wMainOffsetY)];
    
    
    return self.mainView;
}
@end
