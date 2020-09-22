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
    CGFloat scale = 0.8;
    UIImageView *downImage = nil;
    if (self.wImageName&&self.wImageName.length) {
        downImage = [UIImageView new];
        downImage.image = [UIImage imageNamed:self.wImageName];
        downImage.frame = CGRectMake((self.wWidth-self.wImageSize.width*scale)/2, self.wMainOffsetY, self.wImageSize.width*scale , self.wImageSize.height*scale);
        downImage.layer.masksToBounds = YES;
        downImage.layer.cornerRadius = self.wImageSize.width*scale/2;
        [self.mainView addSubview:downImage];
    }
    [self.mainView addSubview:self.textLabel];
    CGSize size = [WMZDialogTool sizeForTextView:CGSizeMake(self.wWidth-self.wMainOffsetX*2, CGFLOAT_MAX) text:self.textLabel.text font:self.textLabel.font.pointSize];
    if (downImage) {
        size.width = self.wWidth-self.wMainOffsetX*2;
    }
    self.textLabel.frame =  CGRectMake(self.wMainOffsetX,(downImage?CGRectGetMaxY(downImage.frame):0)+self.wMainOffsetY, size.width, size.height);
    
    [self reSetMainViewFrame:CGRectMake(0, 0,  downImage?self.wWidth:(self.textLabel.frame.size.width+self.wMainOffsetX*2), CGRectGetMaxY(self.textLabel.frame)+self.wMainOffsetY)];

    [self performSelector:@selector(closeView) withObject:nil afterDelay:self.wDisappelSecond];
    
    return self.mainView;
}
@end
