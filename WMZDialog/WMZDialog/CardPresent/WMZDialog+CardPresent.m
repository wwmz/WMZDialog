//
//  WMZDialog+CardPresent.m
//  WMZDialog
//
//  Created by wmz on 2019/11/5.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "WMZDialog+CardPresent.h"
@implementation WMZDialog (CardPresent)
- (UIView*)cardPresentAction{
    
    UIView *headView = nil;
    if (self.wParentHeadView) {
        headView =  self.wParentHeadView(self.mainView,self.tableView);
        if (headView != self.mainView){
            [self.mainView addSubview:headView];
        }
    }
    
    UIView *bottomView = nil;
    if (self.wParentBottomView) {
        bottomView =  self.wParentBottomView(self.mainView,self.tableView);
        if (bottomView != self.mainView){
            CGRect rect = CGRectZero;
            rect.origin.x = 0;
            rect.origin.y = 0;
            if (headView) {
                 rect.origin.y = CGRectGetMaxY(headView.frame);
            }
            rect.size.width = self.wWidth;
            rect.size.height = bottomView.frame.size.height;
            bottomView.frame = rect;
            [self.mainView addSubview:bottomView];
            [self reSetMainViewFrame:CGRectMake(0, 0, self.wWidth,CGRectGetMaxY(bottomView.frame))];
        }
    }else{
        if (!self.wParentHeadView) {
           [self reSetMainViewFrame:CGRectMake(0, 0, self.wWidth,self.wHeight)];
        }else{
            [self reSetMainViewFrame:CGRectMake(0, 0, self.wWidth,CGRectGetMaxY(headView.frame))];
        }
    }
    
    //设置只有一半圆角
    [WMZDialogTool setView:self.mainView radio:CGSizeMake(self.wMainRadius,self.wMainRadius) roundingCorners:UIRectCornerTopLeft |UIRectCornerTopRight];

    if (self.wOpenDragging) {
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panAction:)];
        self.mainView.userInteractionEnabled = YES;
        [self.mainView addGestureRecognizer:pan];
    }
    
    self.normalPoint = self.mainView.center;
    return self.mainView;
}

- (void)panAction:(UIPanGestureRecognizer*)pan{
    if (!self.wOpenDragging) return;
    CGPoint transP = [pan translationInView:self.mainView];
    CGPoint center =  self.mainView.center;
    CGFloat scale = 0;
    CGFloat alpha = 0;
    if (center.x<=self.normalPoint.x) {
        center.y+=transP.y;
        scale = (0.1* fabs(center.y-self.normalPoint.y))/self.mainView.frame.size.height;
        alpha = (self.wShadowAlpha* fabs(center.y-self.normalPoint.y))/self.mainView.frame.size.height;
    }
    if (center.y<=self.normalPoint.y&&self.wLeftScrollClose) {
        center.x+=transP.x;
        scale = (0.1* fabs(center.x-self.normalPoint.x))/self.mainView.frame.size.width;
        alpha = (self.wShadowAlpha* fabs(center.x-self.normalPoint.x))/self.mainView.frame.size.width;
    }
    [pan setTranslation:CGPointZero inView:self.mainView];
    switch (pan.state) {
        case UIGestureRecognizerStateEnded:
        {
            self.tableView.scrollEnabled = YES;
            if (center.x<=self.normalPoint.x) {
                if (center.y<self.normalPoint.y+self.mainView.frame.size.height/2) {
                    center = self.normalPoint;
                    scale = 0;
                    alpha = 0;
                }
                if (center.y>=self.normalPoint.y+self.mainView.frame.size.height/2) {
                    self.wHideAnimation = AninatonHideTop;
                    [self closeView]; return;
                }
            }
            
            if (center.y<=self.normalPoint.y&&self.wLeftScrollClose) {
                if (center.x<self.normalPoint.x+self.mainView.frame.size.width/2) {
                    scale = 0;
                    alpha = 0;
                    center = self.normalPoint;
                    }
                if (center.x>=self.normalPoint.x+self.mainView.frame.size.width/2) {
                     self.wHideAnimation = AninatonHideRight;
                    [self closeView]; return;
                }
            }
        }
            break;
        case UIGestureRecognizerStateBegan:{
            if (center.y<self.normalPoint.y) return;
            if (center.x<self.normalPoint.x) return;
            if (self.tableView.contentOffset.y<=0) {
                self.tableView.scrollEnabled = NO;
            }
        }
            break;
        case UIGestureRecognizerStateChanged:{
            if (center.y<self.normalPoint.y) return;
            if (center.x<self.normalPoint.x) return;
            if (self.tableView.contentOffset.y<=0) {
                self.tableView.scrollEnabled = NO;
            }
        }
            break;
        default:
            break;
    }
    if (scale>0.1) {
        scale = 0.1;
    }
    if (scale<0) {
        scale = 0;
    }
    if (alpha>self.wShadowAlpha) {
        alpha = self.wShadowAlpha;
    }
    if (alpha<0) {
        alpha = 0;
    }
    [UIView animateWithDuration:0.1 animations:^{
        self.mainView.center = center;
        self.shadowView.alpha = self.wShadowAlpha - alpha;
        if (self.wScaleParentVC) {
            UIViewController *VC = [WMZDialogTool getCurrentVC];
            if (VC.navigationController) {
                VC.navigationController.view.transform = CGAffineTransformMakeScale(0.9+scale, 0.9+scale);
            }else{
                VC.view.transform = CGAffineTransformMakeScale(0.9+scale, 0.9+scale);
            }
        }
    }];
}

@end
