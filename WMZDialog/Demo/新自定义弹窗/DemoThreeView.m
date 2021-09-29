//
//  DemoThreeView.m
//  WMZDialog
//
//  Created by wmz on 2021/9/28.
//  Copyright © 2021 wmz. All rights reserved.
//

#import "DemoThreeView.h"

@implementation DemoThreeView

/// 常规布局
- (void)mz_setupView{
    if (!self.param) return;
    [self addSubview:self.iconIV];
    self.iconIV.image = [UIImage imageNamed:@"advise"];
    self.iconIV.frame = CGRectMake(0, 0, 300, 400);
    
    [self addSubview:self.tableView];
    self.param.wCellHeight = 380/3.0;
    self.tableView.frame = CGRectMake(10, 10, 280, 380);
    self.tableView.backgroundColor = UIColor.clearColor;
}

- (CGRect)mz_setupRect{
    return CGRectMake(0, 0, 300, CGRectGetMaxY(self.tableView.frame) + 10);
}

@end
