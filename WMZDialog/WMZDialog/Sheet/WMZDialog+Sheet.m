

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
    UIView *headView = nil;
    if (self.wMultipleSelection) {
        headView = [UIView new];
        headView.backgroundColor = self.wMainBackColor;
        headView.frame = CGRectMake(0, 0, self.wWidth, self.wMainBtnHeight);
        [self.mainView addSubview:headView];
        
        [self.mainView addSubview:self.cancelBtn];
        self.cancelBtn.frame = CGRectMake(self.wMainOffsetX*2, 0, self.wWidth/2-self.wMainOffsetX*2, self.wMainBtnHeight);
        self.cancelBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        [self.mainView addSubview:self.OKBtn];
        [self.OKBtn removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
        [self.OKBtn addTarget:self action:@selector(sheetSelectAction:) forControlEvents:UIControlEventTouchUpInside];
        self.OKBtn.frame = CGRectMake(self.wWidth/2, 0,self.wWidth/2-self.wMainOffsetX, self.wMainBtnHeight);
        self.OKBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }else{
        if (self.wTitle) {
            [self.mainView addSubview:self.titleLabel];
            self.titleLabel.frame = CGRectMake(self.wMainOffsetX, self.wMainOffsetY, self.wWidth-self.wMainOffsetX*2, [WMZDialogTool heightForTextView:CGSizeMake(self.wWidth-self.wMainOffsetX*2, CGFLOAT_MAX) WithText:self.titleLabel.text WithFont:self.titleLabel.font.pointSize]);
        }
    }
    self.tableView.frame = CGRectMake(0, headView?
                                      CGRectGetMaxY(headView.frame):
                                      (self.wTitle?CGRectGetMaxY(self.titleLabel.frame)+self.wMainOffsetY:0), self.wWidth, self.wCellHeight*([self.wData count]>8?8:[self.wData count]));
    
    [self.mainView addSubview:self.tableView];
    
    if (!headView) {
        UIView *emptyView =  [UIView new];
        emptyView.backgroundColor = self.tableView.backgroundColor;
        emptyView.frame = CGRectMake(0, CGRectGetMaxY(self.tableView.frame), self.wWidth, Dialog_GetHNum(20));
        [self.mainView addSubview:emptyView];
        
        [self.mainView addSubview:self.cancelBtn];
        self.cancelBtn.frame = CGRectMake(0, CGRectGetMaxY(emptyView.frame), self.wWidth, self.wMainBtnHeight);
    }
    [self reSetMainViewFrame:CGRectMake(0, 0, self.wWidth, headView?CGRectGetMaxY(self.tableView.frame):CGRectGetMaxY(self.cancelBtn.frame))];
    //设置只有一半圆角
    [WMZDialogTool setView:self.mainView Radii:CGSizeMake(self.wMainRadius,self.wMainRadius) RoundingCorners:UIRectCornerTopLeft |UIRectCornerTopRight];
     return self.mainView;
}

//多选 确定事件
- (void)sheetSelectAction:(UIButton*)sender{
    if (!self.selectArr.count) {
        Alert(@"请选择至少一个");
        return;
    }
    if (self.wEventOKFinish) {
        self.wEventOKFinish(self.selectArr, self.pathArr);
    }
    [self closeView];
}

@end
