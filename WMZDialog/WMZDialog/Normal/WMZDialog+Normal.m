

//
//  WMZDialog+Normal.m
//  WMZDialog
//
//  Created by wmz on 2019/6/5.
//  Copyright © 2019年 wmz. All rights reserved.
//

#import "WMZDialog+Normal.h"

@implementation WMZDialog (Normal)
- (UIView*)normalAction{
    [self.mainView addSubview:self.titleLabel];
    self.titleLabel.frame = CGRectMake(self.wMainOffsetX, self.wTitle.length?self.wMainOffsetY:0, self.wWidth-self.wMainOffsetX*2, [WMZDialogTool sizeForTextView:CGSizeMake(self.wWidth-self.wMainOffsetX*2, CGFLOAT_MAX) text:self.titleLabel.text font:self.titleLabel.font.pointSize].height);

    [self.mainView addSubview:self.textLabel];
    self.textLabel.frame =  CGRectMake(self.wMainOffsetX,CGRectGetMaxY(self.titleLabel.frame)+ self.wMainOffsetY, self.wWidth-self.wMainOffsetX*2, [WMZDialogTool sizeForTextView:CGSizeMake(self.wWidth-self.wMainOffsetX*2, CGFLOAT_MAX) text:self.textLabel.text font:self.textLabel.font.pointSize].height);

    UIView *view =  [self addBottomView:CGRectGetMaxY(self.textLabel.frame)+self.wMainOffsetY];
    [self reSetMainViewFrame:CGRectMake(0, 0, self.wWidth, CGRectGetMaxY(view.frame))];
    
    return self.mainView;
    
}
@end
