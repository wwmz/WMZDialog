//
//  DemoOneView.m
//  WMZDialog
//
//  Created by wmz on 2021/9/28.
//  Copyright © 2021 wmz. All rights reserved.
//

#import "DemoOneView.h"

@implementation DemoOneView

+ (DemoOneView*)loadNibView{
    return [[NSBundle mainBundle] loadNibNamed:@"DemoOneView" owner:nil options:nil].firstObject;
}

/// 所处的frame位置
- (CGRect)mz_setupRect{
    [self layoutIfNeeded];
    BOOL left = ([UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeLeft || [UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeRight);
    CGFloat width = left? UIScreen.mainScreen.bounds.size.height : UIScreen.mainScreen.bounds.size.width;
    return CGRectMake( left?(width - 30)/2 : 15, UIScreen.mainScreen.bounds.size.height - self.frame.size.height - 20, width - 30, self.frame.size.height);
}

/// 不居中 可选实现
- (BOOL)mz_centerView{
    return NO;
}

@end
