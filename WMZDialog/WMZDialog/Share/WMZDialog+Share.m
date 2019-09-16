
//
//  WMZDialog+Share.m
//  WMZDialog
//
//  Created by wmz on 2019/6/10.
//  Copyright © 2019年 wmz. All rights reserved.
//

#import "WMZDialog+Share.h"
@implementation WMZDialog (Share)
- (UIView*)shareAction{
    [self.mainView addSubview:self.titleLabel];
    self.titleLabel.frame = CGRectMake(self.wMainOffsetX, self.wMainOffsetY, self.wWidth-self.wMainOffsetX*2, [WMZDialogTool heightForTextView:CGSizeMake(self.wWidth-self.wMainOffsetX*2, CGFLOAT_MAX) WithText:self.titleLabel.text WithFont:self.titleLabel.font.pointSize]);

    
    UIView *upLine = [UIView new];
    [self.mainView addSubview:upLine];
    upLine.alpha = self.wLineAlpha;
    upLine.backgroundColor = self.wLineColor;
    upLine.frame = CGRectMake(self.wMainOffsetX, CGRectGetMaxY(self.titleLabel.frame)+self.wMainOffsetY, self.wWidth-self.wMainOffsetX*2, DialogK1px);
    

    UIScrollView *shareView = [UIScrollView new];
    shareView.tag = 10086;
    shareView.showsVerticalScrollIndicator = NO;
    shareView.showsHorizontalScrollIndicator = NO;
    shareView.pagingEnabled = YES;
    shareView.bounces = NO;
    
    [self.mainView addSubview:shareView];

    shareView.frame = CGRectMake(0, CGRectGetMaxY(upLine.frame)+self.wMainOffsetY, self.wWidth ,self.wHeight*2);
    __weak WMZDialog *WEAK = self;
    if (self.wData&&([self.wData isKindOfClass:[NSArray class]]||[self.wData isKindOfClass:[NSMutableArray class]])) {
        for (int i = 0; i<[self.wData count]; i++) {
            NSDictionary *dic = self.wData[i];
            if (![dic isKindOfClass:[NSDictionary class]]) break;
            WMZDialogShareView *iconView = [[WMZDialogShareView alloc] initWithText:dic[@"name"] withImage:dic[@"image"]  withBlock:^(NSInteger index,id anyId) {
                [WEAK imageAction:index-1000 withAny:anyId];
            } withTag:i+1000];
            [shareView addSubview:iconView];
        }
    }
    UIView *downLine = [UIView new];
    [self.mainView addSubview:downLine];
    downLine.alpha = self.wLineAlpha;
    downLine.backgroundColor = DialogColor(0xeeeeee);
    downLine.frame = CGRectMake(0, CGRectGetMaxY(shareView.frame)+self.wMainOffsetY, self.wWidth, self.wMainOffsetY*0.8);
    
    [self.mainView addSubview:self.cancelBtn];
    self.cancelBtn.frame = CGRectMake(0, CGRectGetMaxY(downLine.frame), self.wWidth, self.wMainBtnHeight);
    
    
    [self reSetMainViewFrame:CGRectMake(0,0,self.wWidth, CGRectGetMaxY(self.cancelBtn.frame))];
    //设置只有一半圆角
    [WMZDialogTool setView:self.mainView Radii:CGSizeMake(self.wMainRadius,self.wMainRadius) RoundingCorners:UIRectCornerTopLeft |UIRectCornerTopRight];
    

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        springShowAnimation(shareView, self.wAnimationDurtion , [shareView subviews], self.wColumnCount, self.wRowCount, 0, 0, 0, 0, YES,  ^{});
    });
    return self.mainView;
}



- (void)imageAction:(NSInteger)tag withAny:(id)any{
    [self closeView];
    NSInteger section = tag / (self.wColumnCount * self.wRowCount) ;
    NSInteger row = tag%(self.wColumnCount * self.wRowCount) ;
    if (self.wEventFinish) {
        self.wEventFinish(any,nil,self.wType);
    }
    if (self.wEventMenuClick) {
        self.wEventMenuClick(any, row, section);
    }
    
}
@end


