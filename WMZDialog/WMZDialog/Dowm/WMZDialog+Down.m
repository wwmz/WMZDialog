//
//  WMZDialog+Down.m
//  WMZDialog
//
//  Created by wmz on 2019/6/25.
//  Copyright © 2019年 wmz. All rights reserved.
//

#import "WMZDialog+Down.h"
static NSString *progressViewKey = @"progressView"; //progressView的key
@interface WMZDialog()
@property(nonnull,retain)UIProgressView *progressView;
@end
@implementation WMZDialog (Down)
- (UIView*)downAction{
    UIImageView *downImage = [UIImageView new];
    downImage.image = [UIImage imageNamed:self.wImageName];
    downImage.frame = CGRectMake((self.wWidth-self.wImageSize.width)/2, self.wMainOffsetY, self.wImageSize.width , self.wImageSize.height);
    downImage.layer.masksToBounds = YES;
    downImage.layer.cornerRadius = self.wImageSize.width/2;
    [self.mainView addSubview:downImage];
    
    [self.mainView addSubview:self.titleLabel];
    self.titleLabel.frame = CGRectMake(self.wMainOffsetX, CGRectGetMaxY(downImage.frame)+ (self.wTitle.length?self.wMainOffsetY:0), self.wWidth-self.wMainOffsetX*2, [WMZDialogTool heightForTextView:CGSizeMake(self.wWidth-self.wMainOffsetX*2, CGFLOAT_MAX) WithText:self.titleLabel.text WithFont:self.titleLabel.font.pointSize]);
    
    [self.mainView addSubview:self.progressView];
    self.progressView.frame = CGRectMake(self.wMainOffsetX, CGRectGetMaxY(self.titleLabel.frame)+self.wMainOffsetY, self.wWidth*0.75, Dialog_GetHNum(20));
    [self.mainView addSubview:self.textLabel];
    
    self.textLabel.frame = CGRectMake(CGRectGetMaxX(self.progressView.frame)+ self.wMainOffsetX, 0, self.wWidth*0.25- self.wMainOffsetX*3, Dialog_GetHNum(30));
    self.textLabel.center = CGPointMake(self.textLabel.center.x, self.progressView.center.y);
    [self reSetMainViewFrame:CGRectMake(0, 0, self.wWidth, CGRectGetMaxY(self.textLabel.frame)+self.wMainOffsetY)];
    
    if (self.wData) {
        [self updateAlertTypeDownProgress: [self.wData floatValue]];
    }
    return self.mainView;
}



- (void)setProgressView:(UITextView *)progressView{
    objc_setAssociatedObject(self, &progressViewKey, progressView, OBJC_ASSOCIATION_RETAIN);
}

- (UIProgressView *)progressView{
    
    UIProgressView* progressView = objc_getAssociatedObject(self, &progressViewKey);
    if (!progressView) {
        progressView = [UIProgressView new];
        progressView.progressTintColor = self.wProgressTintColor;
        progressView.trackTintColor = self.wTrackTintColor;
        objc_setAssociatedObject(self, &progressViewKey, progressView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return progressView;
}

/*
 * 更新下载进度条
 *
 * @param  value  值
 *
 */
- (BOOL)updateAlertTypeDownProgress:(CGFloat)value{
    if (self.close) return NO;
    self.progressView.progress = value;
    NSMutableString *string = [NSMutableString stringWithFormat:@"%@", [NSString stringWithFormat:@"%.0f",value*100]];
    [string appendString:@"%"];
    self.textLabel.text = string;

    if (value*100>=100) {
        if (self.wEventFinish) {
            self.wEventFinish(@"下载完成",nil, self.wType);
        }
    }
    return YES;
}


@end
