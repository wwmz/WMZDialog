




//
//  WMZDialog+PopView.m
//  WMZDialog
//
//  Created by wmz on 2019/6/24.
//  Copyright © 2019年 wmz. All rights reserved.
//

#import "WMZDialog+PopView.h"
@implementation WMZDialog (PopView)
- (UIView*)popViewAction{
    
     [self.wTapView setNeedsLayout];
     [self.wTapView layoutIfNeeded];
     self.tapRect = self.wTapView.frame;
    if (self.wTapView) {
        if (self.wTapViewType == DiaPopInViewNormal) {
            [self dealNested:@"UIViewControllerWrapperView"];
         }
         //获取导航栏的真实frame
         if (self.wTapViewType == DiaPopInViewNavi||
             self.wNavigationItem) {
              self.tapRect = [[WMZDialogTool getCurrentVC].navigationController.view convertRect:self.wTapView.frame fromView:self.wTapView.superview];
         }
         if (self.wTapViewType == DiaPopInViewTableView ||
             self.wTapViewType == DiaPopInViewCollectionView ||
             self.wTapViewType == DiaPopInViewScrollView) {
             UIView *otherView = nil;
             UIScrollView *ta = nil;
             NSMutableArray *arr = [NSMutableArray new];
             [arr addObject:self.wTapView];
             while (arr.count) {
               UIView *view = arr.lastObject;
               [arr removeLastObject];
               if ([view isKindOfClass:[UITableViewCell class]]&&!otherView) {
                   otherView = (UITableViewCell*)view;
               }
               if ([view isKindOfClass:[UICollectionViewCell class]]&&!otherView) {
                   otherView = (UICollectionViewCell*)view;
               }
               if ([view isKindOfClass:[UICollectionReusableView class]]&&!otherView) {
                   otherView = (UICollectionReusableView*)view;
               }
               if ([view isKindOfClass:[UITableView class]]&&!ta) {
                  ta = (UITableView*)view;
               }
               if ([view isKindOfClass:[UICollectionView class]]&&!ta) {
                  ta = (UICollectionView*)view;
               }
               if ([view isKindOfClass:[UIScrollView class]]&&!ta) {
                  ta = (UIScrollView*)view;
               }
               if (view.superview) {
                   [arr addObject:view.superview];
               }
             }
             
             
             if (ta) {
                 self.popInScrollView = ta;
                 [self.popInScrollView layoutIfNeeded];
                 [self.popInScrollView layoutSubviews];
                 CGRect rectInTableView = CGRectZero;
                 CGRect rect = CGRectZero;
                if ([ta isKindOfClass:[UITableView class]]) {
                    [self dealNested:@"UITableView"];
                    if (otherView&&[otherView isKindOfClass:[UITableViewCell class]]){
                        NSIndexPath *indexPath = [(UITableView*)self.popInScrollView indexPathForCell:(UITableViewCell*)otherView];
                         rectInTableView = [(UITableView*)self.popInScrollView rectForRowAtIndexPath:indexPath];
                         if (![self.wTapView isKindOfClass:[UITableViewCell class]]) {
                             rectInTableView.origin.x = self.tapRect.origin.x;
                             rectInTableView.origin.y += self.tapRect.origin.y;
                             rectInTableView.size = self.tapRect.size;
                         }
                    }else if([self.wTapView.superview isKindOfClass:[UITableView class]]){
                         rectInTableView = self.tapRect;
                    }else{
                         if (self.wTapViewTableViewFoot) {
                             rectInTableView = [(UITableView*)self.popInScrollView rectForFooterInSection:self.wTableViewSectionHead];
                         }else{
                             rectInTableView = [(UITableView*)self.popInScrollView rectForHeaderInSection:self.wTableViewSectionHead];
                         }
                                          
                         if (![self.wTapView.superview isKindOfClass:[UITableView class]]) {
                             rectInTableView.origin.x = self.tapRect.origin.x;
                             rectInTableView.origin.y += self.tapRect.origin.y;
                             rectInTableView.size = self.tapRect.size;
                         }
                    }
                     rect = [self.popInScrollView convertRect:rectInTableView toView:[self.popInScrollView superview]];
                 }else if ([ta isKindOfClass:[UICollectionView class]]){
                     [self dealNested:@"UICollectionView"];
                     if ([otherView isKindOfClass:[UICollectionViewCell class]]) {
                         NSIndexPath *indexPath = [(UICollectionView*)self.popInScrollView indexPathForCell:(UICollectionViewCell*)otherView];
                         UICollectionViewLayoutAttributes*attributes = [(UICollectionView*)self.popInScrollView layoutAttributesForItemAtIndexPath:indexPath];
                         rectInTableView = attributes.frame;
                         
                         if (![self.wTapView isKindOfClass:[UICollectionViewCell class]]) {
                             rectInTableView.origin.x += self.tapRect.origin.x;
                             rectInTableView.origin.y += self.tapRect.origin.y;
                             rectInTableView.size = self.tapRect.size;
                         }
                     }else if([self.wTapView.superview isKindOfClass:[UICollectionView class]]){
                         rectInTableView = self.tapRect;
                     }else{
                         rectInTableView = otherView.frame;
                         if (![self.wTapView.superview isKindOfClass:[UICollectionView class]]) {
                             rectInTableView.origin.x = self.tapRect.origin.x;
                             rectInTableView.origin.y += self.tapRect.origin.y;
                             rectInTableView.size = self.tapRect.size;
                         }
                     }
                     rect = [self.popInScrollView convertRect:rectInTableView toView:[self.popInScrollView superview]];
                 }else if ([ta isKindOfClass:[UIScrollView class]]){
                     [self dealNested:@"UIScrollView"];
                     rectInTableView = self.tapRect;
                     rect = [self.popInScrollView convertRect:rectInTableView toView:[self.popInScrollView superview]];
                     
                 }
                 if (self.popInScrollView.superview.frame.origin.y!=0) {
                     rect.origin.y+=self.popInScrollView.superview.frame.origin.y;
                 }
                 self.tapRect = rect;
            }
             
        }
    }
    //外部传入
    if(!CGRectEqualToRect(self.wTapRect, CGRectZero)) {// 两个区域不相等
        self.tapRect = self.wTapRect;
    }
    [self.mainView addSubview:self.titleLabel];
    self.tableView.frame = CGRectMake(0, 0, self.wWidth, self.wCellHeight*([self.wData count]>self.wListScrollCount?self.wListScrollCount:[self.wData count]));
    if (self.tableView.frame.size.height == 0 &&[self.wData count]) {
        CGRect rect = self.tableView.frame;
        rect.size.height = self.wHeight;
        self.tableView.frame = rect;
    }
    [self.mainView addSubview:self.tableView];
    CGRect rect = CGRectZero;
    rect.size.width = self.wWidth;
    rect.size.height = CGRectGetMaxY(self.tableView.frame);
    DiaDirection direction = self.wDirection;
    
    if (direction == directionDowm) {
        if (self.wNavigationItem||
        self.wTapViewType == DiaPopInViewNavi) {
            rect.origin.x = self.tapRect.origin.x*self.wPercentOrginX;
        }else{
            rect.origin.x = (self.tapRect.origin.x-(self.mainView.frame.size.width-self.tapRect.size.width)/2)*self.wPercentOrginX;
        }
        //超出屏幕方向变为上面
        if (rect.size.height+self.wMainOffsetY+CGRectGetMaxY(self.tapRect)>Device_Dialog_Height) {
            direction = directionUp;
            rect.origin.y = CGRectGetMinY(self.tapRect) - self.wMainOffsetY - rect.size.height;
        }else{
            rect.origin.y = self.wMainOffsetY+CGRectGetMaxY(self.tapRect);
        }
    }
    if (direction == directionUp) {
        rect.origin.x = (self.tapRect.origin.x-(self.mainView.frame.size.width-self.tapRect.size.width)/2)*self.wPercentOrginX;
        //超出屏幕方向变为下面
        if (CGRectGetMinY(self.tapRect) -self.wMainOffsetY - rect.size.height < (isIphoneX?15:0)) {
            direction = directionDowm;
            rect.origin.y = self.wMainOffsetY+CGRectGetMaxY(self.tapRect);
        }else{
            rect.origin.y = CGRectGetMinY(self.tapRect) - self.wMainOffsetY - rect.size.height;
        }
    }
    
    if (direction == directionright) {
        rect.origin.y = (self.tapRect.origin.y - self.mainView.frame.size.height/2)*self.wPercentOrginX;
        //超出屏幕方向变为左面
        if (rect.size.width+self.wMainOffsetY+CGRectGetMaxX(self.tapRect)>Device_Dialog_Width) {
            direction = directionLeft;
            rect.origin.x = CGRectGetMinX(self.tapRect) - self.wMainOffsetY - rect.size.width;
        }else{
            rect.origin.x = self.wMainOffsetY+CGRectGetMaxX(self.tapRect);
        }
    }
    
    if (direction == directionLeft) {
        rect.origin.y = (self.tapRect.origin.y - self.mainView.frame.size.height/2) *self.wPercentOrginX;
        //超出屏幕方向变为下面
        if (CGRectGetMinX(self.tapRect) - self.wMainOffsetY - rect.size.width<0) {
            direction = directionright;
            rect.origin.x = self.wMainOffsetY+CGRectGetMaxX(self.tapRect);
        }else{
            rect.origin.x = CGRectGetMinX(self.tapRect) - self.wMainOffsetY - rect.size.width;
        }
    }
    
    if (direction == directionUp) {
        rect.size.height+=self.wMainOffsetX;
    }
    if (direction == directionDowm) {
        rect.size.height+=self.wMainOffsetX;
        rect.origin.y-=self.wMainOffsetX;
        CGRect taRect = self.tableView.frame;
        taRect.origin.y+=self.wMainOffsetX;
        self.tableView.frame = taRect;
    }
    
    self.mainView.frame = rect;
    
    if (self.wNavigationItem||
        self.wTapViewType == DiaPopInViewNavi) {
        if (CGRectGetMaxX(self.mainView.frame)>Device_Dialog_Width) {
            CGRect myRect = self.mainView.frame;
            myRect.origin.x = CGRectGetMaxX(self.tapRect)-self.mainView.frame.size.width;
            self.mainView.frame = myRect;
        }
        if (CGRectGetMinX(self.mainView.frame)<0) {
            CGRect myRect = self.mainView.frame;
            myRect.origin.x = 0;
            self.mainView.frame = myRect;
        }
    }else{
        if (direction == directionDowm || direction == directionUp) {
            if (CGRectGetMaxX(self.mainView.frame)>Device_Dialog_Width) {
                CGRect myRect = self.mainView.frame;
                myRect.origin.x = CGRectGetMaxX(self.tapRect)-self.mainView.frame.size.width;
                self.mainView.frame = myRect;
            }
            if (CGRectGetMinX(self.mainView.frame)<0) {
                CGRect myRect = self.mainView.frame;
                myRect.origin.x = 0;
                self.mainView.frame = myRect;
            }
            
        }
        if (direction == directionLeft || direction == directionright) {
            if (CGRectGetMaxY(self.mainView.frame)>Device_Dialog_Height) {
                CGRect myRect = self.mainView.frame;
                myRect.origin.y = Device_Dialog_Height-self.mainView.frame.size.height;
                self.mainView.frame = myRect;
            }
            if (CGRectGetMinY(self.mainView.frame)<0) {
                CGRect myRect = self.mainView.frame;
                myRect.origin.y = 0;
                self.mainView.frame = myRect;
            }
        }
    }
    
    //箭头位置
    DiaDirection headType = 0;
    CGFloat offset = 0;
    if (direction == directionUp) {
        headType = directionDowm;
        offset = self.mainView.frame.size.width*self.wPercentAngle;
    }
    if (direction == directionDowm) {
        headType = directionUp;
        offset = self.mainView.frame.size.width*self.wPercentAngle;
    }
    if (direction == directionLeft) {
        headType = directionright;
        offset = self.mainView.frame.size.height*self.wPercentAngle;
    }
    if (direction == directionright) {
        headType = directionLeft;
        offset = self.mainView.frame.size.height*self.wPercentAngle;
    }
    
    [self.mainView addArrowBorderAt:headType offset:offset rectCorner:self.wPopViewRectCorner width:15 height:10 cornerRadius:self.wMainRadius borderWidth:self.wPopViewBorderWidth borderColor:self.wPopViewBorderColor];

    return self.mainView;
}
//处理嵌套问题
- (void)dealNested:(NSString*)stopView{
    NSMutableArray *arr = [NSMutableArray new];
    [arr addObject:self.wTapView];
    //父视图
    NSMutableArray *superViewArr = [NSMutableArray new];
    while (arr.count) {
        UIView *view = arr.lastObject;
        [arr removeLastObject];
        if ([NSStringFromClass([view class]) isEqualToString:stopView]) {
            //取消最后一个
            [superViewArr removeLastObject];
            break;
        }else{
            if (view != self.wTapView) {
                [superViewArr addObject:view];
            }
        }
        if (view.superview) {
            [arr addObject:view.superview];
            }
        }
        if (superViewArr.count) {
            __block CGFloat y = 0;
            __block CGFloat x = 0;
            [superViewArr enumerateObjectsUsingBlock:^(UIView *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                y += obj.frame.origin.y;
                x += obj.frame.origin.x;
            }];
            
            CGRect rect = self.tapRect;
            rect.origin.y += y;
            rect.origin.x += x;
            self.tapRect = rect;
        }
}
@end
