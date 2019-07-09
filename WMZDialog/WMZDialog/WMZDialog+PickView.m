//
//  WMZDialog+PickView.m
//  WMZDialog
//
//  Created by wmz on 2019/6/20.
//  Copyright © 2019年 wmz. All rights reserved.
//

#import "WMZDialog+PickView.h"
@implementation WMZDialog (PickView)
- (UIView*)pickAction{
    
    UIView *headView = [UIView new];
    headView.backgroundColor = self.wMainBackColor;
    headView.frame = CGRectMake(0, 0, self.wWidth, self.wMainBtnHeight);
    [self.mainView addSubview:headView];
    
    [self.mainView addSubview:self.cancelBtn];
    self.cancelBtn.frame = CGRectMake(self.wMainOffsetX, 0, self.wWidth/2-self.wMainOffsetX, self.wMainBtnHeight);
    self.cancelBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    [self.mainView addSubview:self.OKBtn];
    [self.OKBtn removeTarget:self action:NSSelectorFromString(@"OKAction:") forControlEvents:UIControlEventTouchUpInside];
    [self.OKBtn addTarget:self action:@selector(PickOKAction:) forControlEvents:UIControlEventTouchUpInside];
    self.OKBtn.frame = CGRectMake(self.wWidth/2, 0,self.wWidth/2-self.wMainOffsetX, self.wMainBtnHeight);
    self.OKBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;

    
    self.pickView.frame =  CGRectMake(0, CGRectGetMaxY(headView.frame), self.wWidth, self.wHeight);
    [self.mainView addSubview:self.pickView];

    
    [self reSetMainViewFrame:CGRectMake(0,0,self.wWidth, CGRectGetMaxY(self.pickView.frame))];
    //设置只有一半圆角
    [WMZDialogTool setView:self.mainView Radii:CGSizeMake(self.wMainRadius,self.wMainRadius) RoundingCorners:UIRectCornerTopLeft |UIRectCornerTopRight];
    
    return self.mainView;
}

//重设确定的方法
- (void)PickOKAction:(UIButton*)btn{
    [self closeView];
    if (self.wEventOKFinish) {
        NSMutableString *mStr = [NSMutableString new];
        for (int i = 0; i<[self.wData count]; i++) {
            NSString *str = self.wData[i][[self.pickView selectedRowInComponent:i]];
            [mStr appendString:[NSString stringWithFormat:@"%@ ",str]];
        }
        self.wEventOKFinish(mStr, self.wType);
    }
}



@end
