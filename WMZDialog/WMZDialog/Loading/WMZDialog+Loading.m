





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
    UIImageView *loadingView = [UIImageView new];
    loadingView.frame = CGRectMake((self.wWidth-self.wLoadingSize.width)/2,self.wMainOffsetY *2,self.wLoadingSize.width,self.wLoadingSize.height);
    [self.mainView addSubview:loadingView];
    if (self.wLoadingType == LoadingStyleWait) {
        loadingAnimation(loadingView, self.wAnimationDurtion, self.wLoadingColor, 4);
    }else  if (self.wLoadingType == LoadingStyleSystem) {
        UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [self.mainView addSubview:activity];
        activity.tag = 999;
        activity.frame = loadingView.frame;
        [activity startAnimating];
    }else{
        CGFloat imageWH = self.wLoadingSize.width ;
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, imageWH, imageWH) cornerRadius:imageWH/2];
        CGFloat addHeight = 3.0f;
        CAShapeLayer *lineLayer = [CAShapeLayer layer];
        if (self.wLoadingType == LoadingStyleError) {
            [path moveToPoint:CGPointMake(imageWH/2-imageWH/4, imageWH/4)];
            [path addLineToPoint:CGPointMake(imageWH/2+imageWH/4, imageWH*3/4)];
            [path moveToPoint:CGPointMake(imageWH/2+imageWH/4, imageWH/4)];
            [path addLineToPoint:CGPointMake(imageWH/2-imageWH/4, imageWH*3/4)];
        }else if (self.wLoadingType == LoadingStyleRight) {
            CGFloat addHeight = 3;
            [path moveToPoint:CGPointMake((imageWH-imageWH)/2+imageWH/4,addHeight + imageWH/2)];
            [path addLineToPoint:CGPointMake(imageWH/2, imageWH*3/4)];
            [path addLineToPoint:CGPointMake(imageWH/2 + imageWH*1/3, imageWH*1/3)];
        }else if (self.wLoadingType == LoadingStyleInfo) {
            [path moveToPoint:CGPointMake(imageWH/2,imageWH/4)];
            [path addLineToPoint:CGPointMake(imageWH/2,imageWH/4 + addHeight)];
            [path moveToPoint:CGPointMake(imageWH/2,imageWH/4 + 6)];
            [path addLineToPoint:CGPointMake(imageWH/2, imageWH*3/4 )];
        }
        lineLayer.frame = CGRectZero;
        lineLayer.fillColor = [UIColor clearColor].CGColor ;
        lineLayer.strokeColor = self.wLoadingColor.CGColor;
        lineLayer.lineWidth = self.wLoadingWidth;
        lineLayer.path = path. CGPath ;
        newLoadingAnimation(loadingView,lineLayer,self.wAnimationDurtion);
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
    
    if (self.wDisappelSecond) {
        [self performSelector:@selector(closeView) withObject:nil afterDelay:self.wDisappelSecond];
    }
    return self.mainView;
}
@end
