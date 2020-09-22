

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
    BOOL hadBottomCancel = NO;
    if (self.wMultipleSelection) {
        headView = [UIView new];
        headView.backgroundColor = self.wMainBackColor;
        headView.frame = CGRectMake(0, 0, self.wWidth, self.wMainBtnHeight);
        [self.mainView addSubview:headView];
              
        [headView addSubview:self.cancelBtn];
        self.cancelBtn.frame = CGRectMake(self.wMainOffsetX, 0, self.wMainBtnHeight, self.wMainBtnHeight);
        self.cancelBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
              
        [headView addSubview:self.OKBtn];
        [self.OKBtn removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
        [self.OKBtn addTarget:self action:@selector(sheetSelectAction:) forControlEvents:UIControlEventTouchUpInside];
        self.OKBtn.frame = CGRectMake(self.wWidth-self.wMainBtnHeight-self.wMainOffsetX, 0,self.wMainBtnHeight, self.wMainBtnHeight);
        self.OKBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
              
        [headView addSubview:self.titleLabel];
        self.titleLabel.frame = CGRectMake(self.wMainBtnHeight+2*self.wMainOffsetX, 0, self.wWidth-2*self.wMainBtnHeight-4*self.wMainOffsetX, self.wMainBtnHeight);
              
    }else{
        if (self.wTitle&&self.wTitle.length) {
            [self.mainView addSubview:self.titleLabel];
            self.titleLabel.frame = CGRectMake(self.wMainOffsetX,self.wTitle.length?self.wMainOffsetY:0, self.wWidth-self.wMainOffsetX*2, [WMZDialogTool sizeForTextView:CGSizeMake(self.wWidth-self.wMainOffsetX*2, CGFLOAT_MAX) text:self.titleLabel.text font:self.titleLabel.font.pointSize].height);
        }
    }
    self.tableView.frame = CGRectMake(0, headView?
                                      CGRectGetMaxY(headView.frame):
                                      ((self.wTitle&&self.wTitle.length)?CGRectGetMaxY(self.titleLabel.frame)+self.wMainOffsetY:0), self.wWidth, self.wCellHeight*([self.wData count]>self.wListScrollCount?self.wListScrollCount:[self.wData count]));
    
    [self.mainView addSubview:self.tableView];
    
    if (!headView||self.wEventCancelFinish) {
        if (self.wCancelTitle&&self.wCancelTitle.length) {
            UIView *emptyView =  [UIView new];
            emptyView.backgroundColor = self.tableView.backgroundColor;
            emptyView.frame = CGRectMake(0, CGRectGetMaxY(self.tableView.frame), self.wWidth, Dialog_GetWNum(20));
            [self.mainView addSubview:emptyView];
            
            [self.mainView addSubview:self.cancelBtn];
            self.cancelBtn.frame = CGRectMake(0, CGRectGetMaxY(emptyView.frame), self.wWidth, self.wMainBtnHeight);
            self.cancelBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            hadBottomCancel = YES;
        }
    }
    [self reSetMainViewFrame:CGRectMake(0, 0, self.wWidth, !hadBottomCancel?CGRectGetMaxY(self.tableView.frame):CGRectGetMaxY(self.cancelBtn.frame))];
    //设置只有一半圆角
    [WMZDialogTool setView:self.mainView radio:CGSizeMake(self.wMainRadius,self.wMainRadius) roundingCorners:UIRectCornerTopLeft |UIRectCornerTopRight];
     return self.mainView;
}

//多选 确定事件
- (void)sheetSelectAction:(UIButton*)sender{
    DialogWeakSelf(self)
    [self closeView:^{
        if (weakObject.wEventOKFinish) {
            weakObject.wEventOKFinish(weakObject.selectArr, weakObject.pathArr);
        }
    }];
}

@end
