

//
//  WMZDialog+Sheet.m
//  WMZDialog
//
//  Created by wmz on 2019/6/21.
//  Copyright © 2019年 wmz. All rights reserved.
//

#import "WMZDialog+Sheet.h"
@implementation WMZDialog (Sheet)
- (UIView*)sheetAction{
    
    self.tableView.frame = CGRectMake(0, 0, self.wWidth, self.wMainBtnHeight*([self.wData count]>8?8:[self.wData count]));

    [self.mainView addSubview:self.tableView];
    
    UIView *emptyView =  [UIView new];
    emptyView.backgroundColor = self.tableView.backgroundColor;
    emptyView.frame = CGRectMake(0, CGRectGetMaxY(self.tableView.frame), self.wWidth, Dialog_GetHNum(20));
    [self.mainView addSubview:emptyView];
        
    [self.mainView addSubview:self.cancelBtn];
    self.cancelBtn.frame = CGRectMake(0, CGRectGetMaxY(emptyView.frame), self.wWidth, self.wMainBtnHeight);
    
    [self reSetMainViewFrame:CGRectMake(0, 0, self.wWidth,CGRectGetMaxY(self.cancelBtn.frame))];

     return self.mainView;
}


@end
