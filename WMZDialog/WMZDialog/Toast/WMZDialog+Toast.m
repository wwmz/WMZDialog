//
//  WMZDialog+Toast.m
//  WMZDialog
//
//  Created by wmz on 2021/4/22.
//  Copyright © 2021 wmz. All rights reserved.
//

#import "WMZDialog+Toast.h"

@implementation WMZDialog (Toast)
- (UIView*)toastAction{
    CGFloat height = self.wHeight;
    BOOL fixHeight = (height != DialogHeight);
    [self.mainView addSubview:self.textLabel];
    CGSize size = [WMZDialogTool sizeForTextView:CGSizeMake(self.wWidth - 20, CGFLOAT_MAX) text:self.textLabel.text font:self.textLabel.font.pointSize];
    self.textLabel.frame =  CGRectMake(10 , self.wMainOffsetY, self.wWidth - 20 , fixHeight ? (height - self.wMainOffsetY * 2) : (size.height + 10));
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    [self reSetMainViewFrame:CGRectMake(0, 0, self.wWidth, fixHeight? height:(CGRectGetMaxY(self.textLabel.frame) + self.wMainOffsetY))];
    [self performSelector:@selector(closeView) withObject:nil afterDelay:self.wDisappelSecond];
    CGRect rect = self.mainView.frame;
    if (self.wToastPosition == DialogToastTop) {
        rect.origin.y = StatusBar_Dialog_Height;
    }else if (self.wToastPosition == DialogToastBottom) {
        rect.origin.y = Device_Dialog_Height - CGRectGetMaxY(self.textLabel.frame) - self.wMainOffsetY * 2 - ( DialogIsIphoneX ? 15 : 10);
    }
    self.mainView.frame = rect;
    if (self.wCustomMainView) {
        self.wCustomMainView(self.mainView);
    }
    return self.mainView;
}
@end
