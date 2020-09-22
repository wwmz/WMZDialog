//
//  WMZDialog+TabbarMenu.m
//  WMZDialog
//
//  Created by wmz on 2019/9/12.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "WMZDialog+TabbarMenu.h"

@implementation WMZDialog (TabbarMenu)
- (UIView*)tabbarMenuAction{

    self.mainView.backgroundColor = [UIColor clearColor];
    self.wCloseBtn.backgroundColor = [UIColor clearColor];
    UIScrollView *shareView = [UIScrollView new];
    shareView.tag = 10086;
    shareView.showsVerticalScrollIndicator = NO;
    shareView.showsHorizontalScrollIndicator = NO;
    shareView.pagingEnabled = YES;
    shareView.bounces = NO;
    
    [self.mainView addSubview:shareView];
    
    shareView.frame = CGRectMake(0, 10 , self.wWidth ,  self.wHeight);
    __weak WMZDialog *WEAK = self;
    if (self.wData&&([self.wData isKindOfClass:[NSArray class]]||[self.wData isKindOfClass:[NSMutableArray class]])) {
        for (int i = 0; i<[self.wData count]; i++) {
            NSDictionary *dic = self.wData[i];
            if (![dic isKindOfClass:[NSDictionary class]]) break;
            WMZDialogShareView *iconView = [[WMZDialogShareView alloc] initWithText:dic[@"name"] withImage:dic[@"image"]  withBlock:^(NSInteger index,id anyId) {
                [WEAK imageAction1:index-1000 withAny:anyId];
            } withTag:i+1000];
            [shareView addSubview:iconView];
        }
    }

    self.wCloseBtn.layer.borderWidth = 0;
    [self.mainView addSubview:self.wCloseBtn];
    self.wCloseBtn.frame = CGRectMake((self.wWidth-60)/2, CGRectGetMaxY(shareView.frame)+100, 60, self.wMainBtnHeight);
    
    
    [self reSetMainViewFrame:CGRectMake(0,0,self.wWidth, CGRectGetMaxY(self.wCloseBtn.frame))];
    //设置只有一半圆角
    [WMZDialogTool setView:self.mainView radio:CGSizeMake(self.wMainRadius,self.wMainRadius) roundingCorners:UIRectCornerTopLeft |UIRectCornerTopRight];
    
    springShowAnimation(shareView, self.wAnimationDurtion , [shareView subviews], self.wColumnCount, self.wRowCount, 0, 0, 0, 0, YES,  ^{});
    return self.mainView;
}



- (void)imageAction1:(NSInteger)tag withAny:(id)any{
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
