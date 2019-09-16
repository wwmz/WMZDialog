//
//  WMZDialog+AutoDisappear.m
//  WMZDialog
//
//  Created by wmz on 2019/6/5.
//  Copyright © 2019年 wmz. All rights reserved.
//

#import "WMZDialog+AutoDisappear.h"

@implementation WMZDialog (AutoDisappear)
- (UIView*)autoDisappealAction{
    
    [self.mainView addSubview:self.textLabel];
    self.textLabel.frame =  CGRectMake(self.wMainOffsetX,self.wMainOffsetY, self.wWidth-self.wMainOffsetX*2, [WMZDialogTool heightForTextView:CGSizeMake(self.wWidth-self.wMainOffsetX*2, CGFLOAT_MAX) WithText:self.textLabel.text WithFont:self.textLabel.font.pointSize]);
    
    [self reSetMainViewFrame:CGRectMake(0, 0, self.wWidth, CGRectGetMaxY(self.textLabel.frame)+self.wMainOffsetY)];
    self.shadowView.userInteractionEnabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.wDisappelSecond * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self closeView];
    });
    
    return self.mainView;
}
@end
