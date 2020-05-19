


//
//  WMZDialog+NaviMenu.m
//  WMZDialog
//
//  Created by wmz on 2019/9/12.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "WMZDialog+NaviMenu.h"

@implementation WMZDialog (NaviMenu)
- (UIView*)naviMenuAction{
    self.wCloseBtn.layer.borderWidth = 0;
    [self.mainView addSubview:self.wCloseBtn];
    self.wCloseBtn.frame = CGRectMake(self.wWidth-60, 20, 60, self.wMainBtnHeight);

    
    UIScrollView *shareView = [UIScrollView new];
    shareView.tag = 10086;
    shareView.showsVerticalScrollIndicator = NO;
    shareView.showsHorizontalScrollIndicator = NO;
    shareView.pagingEnabled = YES;
    shareView.bounces = NO;
    
    [self.mainView addSubview:shareView];
    
    shareView.frame = CGRectMake(0, CGRectGetMaxY(self.wCloseBtn.frame)+self.wMainOffsetY, self.wWidth , self.wHeight*2);
    __weak WMZDialog *WEAK = self;
    if (self.wData&&([self.wData isKindOfClass:[NSArray class]]||[self.wData isKindOfClass:[NSMutableArray class]])) {
        for (int i = 0; i<[self.wData count]; i++) {
            NSDictionary *dic = self.wData[i];
            if (![dic isKindOfClass:[NSDictionary class]]) break;
            WMZDialogShareView *iconView = [[WMZDialogShareView alloc] initWithText:dic[@"name"] withImage:dic[@"image"]  withBlock:^(NSInteger index,id anyId) {
                [WEAK imageAction2:index-1000 withAny:anyId];
            } withTag:i+1000];
            [shareView addSubview:iconView];
        }
    }
  
    self.mainView.frame = CGRectMake(0, 0, self.wWidth, CGRectGetMaxY(shareView.frame));
    
    springShowAnimation(shareView, self.wAnimationDurtion , [shareView subviews], self.wColumnCount, self.wRowCount, 0, 0, 0, 0, YES,  ^{});
    return self.mainView;
}



- (void)imageAction2:(NSInteger)tag withAny:(id)any{
    NSInteger section = tag / (self.wColumnCount * self.wRowCount) ;
    NSInteger row = tag%(self.wColumnCount * self.wRowCount) ;
    DialogWeakSelf(self)
    [self closeView:^{
        if (weakObject.wEventFinish) {
            weakObject.wEventFinish(any,nil,weakObject.wType);
        }
        if (weakObject.wEventMenuClick) {
            weakObject.wEventMenuClick(any, row, section);
        }
    }];
}
@end
