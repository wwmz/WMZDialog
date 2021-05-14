




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
    self.tableView.frame = CGRectMake(0, 0, self.wWidth, self.wCellHeight*([(NSArray*)self.wData count]>self.wListScrollCount?self.wListScrollCount:[(NSArray*)self.wData count]));
    CGRect tableViewRect = self.tableView.frame;
    if (self.tableView.frame.size.height == 0 &&[(NSArray*)self.wData count]) {
        tableViewRect.size.height = self.wHeight;
    }
    [self.mainView addSubview:self.tableView];
    CGFloat offsetY =  self.wAngleSize.height;
    DiaDirection direction = self.wDirection;
    CGRect rect = CGRectZero;
    //箭头位置
    DiaDirection headType = 0;
    CGFloat offset = 0;
    switch (direction) {
        case directionDowm:{
            rect.size.width = tableViewRect.size.width;
            tableViewRect.origin.y = offsetY;
            rect.size.height = offsetY + tableViewRect.size.height;
            if (self.wNavigationItem||
            self.wTapViewType == DiaPopInViewNavi) {
                rect.origin.x = self.tapRect.origin.x*self.wPercentOrginX;
            }else{
                rect.origin.x = (self.tapRect.origin.x-(rect.size.width-self.tapRect.size.width)/2)*self.wPercentOrginX;
            }
            if (rect.size.height + self.wMainOffsetY +CGRectGetMaxY(self.tapRect)>Device_Dialog_Height) {
                direction = directionUp;
                tableViewRect.origin.y = 0;
                rect.size.height = tableViewRect.size.height + offsetY;
                rect.origin.y = CGRectGetMinY(self.tapRect) - self.wMainOffsetY - rect.size.height;
                headType = directionDowm;
            }else{
                rect.origin.y = self.wMainOffsetY + CGRectGetMaxY(self.tapRect);
                headType = directionUp;
            }
            
            offset = rect.size.width * self.wPercentAngle;
        }
            break;
        case directionUp:{
            rect.size.width = tableViewRect.size.width;
            tableViewRect.origin.y = 0;
            rect.size.height = offsetY + tableViewRect.size.height ;
            
            rect.origin.x = (self.tapRect.origin.x-(rect.size.width-self.tapRect.size.width)/2)*self.wPercentOrginX;
            if (CGRectGetMinY(self.tapRect) - self.wMainOffsetY - rect.size.height < (DialogIsIphoneX?15:0)) {
                direction = directionDowm;
                tableViewRect.origin.y = offsetY;
                rect.size.height = offsetY + tableViewRect.size.height;
                rect.origin.y = self.wMainOffsetY + CGRectGetMaxY(self.tapRect);
                headType = directionUp;
            }else{
                rect.origin.y = CGRectGetMinY(self.tapRect) - self.wMainOffsetY - rect.size.height;
                headType = directionDowm;
            }

            offset = rect.size.width * self.wPercentAngle;
        }
                
            break;
        case directionright:{
            rect.size.height = tableViewRect.size.height;
            tableViewRect.origin.x = offsetY;
            rect.size.width = tableViewRect.size.width + offsetY;
            rect.origin.y = (self.tapRect.origin.y - (rect.size.height-self.tapRect.size.height)/2)*self.wPercentOrginX;
            if (rect.size.width + self.wMainOffsetY + CGRectGetMaxX(self.tapRect)>Device_Dialog_Width) {
                direction = directionLeft;
                tableViewRect.origin.x = 0;
                rect.size.width = tableViewRect.size.width + offsetY;
                rect.origin.x = CGRectGetMinX(self.tapRect) - self.wMainOffsetY - rect.size.width;
                headType = directionright;
            }else{
                rect.origin.x = CGRectGetMaxX(self.tapRect) + self.wMainOffsetY;
                headType = directionLeft;
            }
            offset = rect.size.height*self.wPercentAngle;
        }
                    
            break;
        case directionLeft:{
            rect.size.height = tableViewRect.size.height;
            tableViewRect.origin.x = 0;
            rect.size.width = tableViewRect.size.width + offsetY;
            rect.origin.y = (self.tapRect.origin.y - (rect.size.height-self.tapRect.size.height)/2) *self.wPercentOrginX;
            if (CGRectGetMinX(self.tapRect) - self.wMainOffsetY - rect.size.width<0) {
                direction = directionright;
                tableViewRect.origin.x = offsetY;
                rect.size.width = tableViewRect.size.width + offsetY;
                rect.origin.x = self.wMainOffsetY + CGRectGetMaxX(self.tapRect);
                headType = directionLeft;
            }else{
                rect.origin.x = CGRectGetMinX(self.tapRect) - self.wMainOffsetY - rect.size.width;
                headType = directionright;
            }
            offset = rect.size.height*self.wPercentAngle;
        }
                
            break;
        default:
            break;
    }
    if (self.wNavigationItem||
        self.wTapViewType == DiaPopInViewNavi) {
        if (CGRectGetMaxX(rect)>Device_Dialog_Width) {
            rect.origin.x = CGRectGetMaxX(self.tapRect)- rect.size.width;
        }
        if (CGRectGetMinX(rect)<0) {
            rect.origin.x = 0;
        }
    }else{
        if (CGRectGetMaxX(rect)>Device_Dialog_Width) {
            rect.origin.x = Device_Dialog_Width - rect.size.width;
        }
        if (CGRectGetMinX(rect)<0) {
            rect.origin.x = 0;
        }
        if (CGRectGetMaxY(rect)> (DialogIsIphoneX ? (Device_Dialog_Height - 20):Device_Dialog_Height)) {
            rect.origin.y = (DialogIsIphoneX ? (Device_Dialog_Height - 20):Device_Dialog_Height)-rect.size.height;
        }
        if (CGRectGetMinY(rect)< DialogIsIphoneX? StatusBar_Dialog_Height : 0) {
            rect.origin.y = DialogIsIphoneX? StatusBar_Dialog_Height : 0;
        }
    }
    
    self.mainView.frame = rect;
    self.tableView.frame = tableViewRect;
    [self.mainView addArrowBorderAt:headType offset:offset rectCorner:self.wPopViewRectCorner width:self.wAngleSize.width height:self.wAngleSize.height cornerRadius:self.wMainRadius borderWidth:self.wPopViewBorderWidth borderColor:self.wPopViewBorderColor angleRadio:self.wAngleRadio];
    if (self.wCustomMainView) {
        self.wCustomMainView(self.mainView);
    }
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
