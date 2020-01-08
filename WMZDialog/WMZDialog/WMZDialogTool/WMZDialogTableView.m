//
//  WMZDialogTableView.m
//  WMZDialog
//
//  Created by wmz on 2019/11/6.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "WMZDialogTableView.h"

@implementation WMZDialogTableView

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    if (self.wOpenScrollClose&&self.contentOffset.y<=0&& [otherGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        if (self.wCardPresent) {
            UIPanGestureRecognizer *pan = (UIPanGestureRecognizer*)otherGestureRecognizer;
            CGPoint translation = [pan translationInView:pan.view];
            CGFloat absX = fabs(translation.x);
            CGFloat absY = fabs(translation.y);
            // 设置滑动有效距离
            if (MAX(absX, absY) >= 1){
                if (absY > absX) {
                    if (translation.y<0) {
                        return NO;
                    }else{
                        return YES;
                    }
                }
             }
        }
        return YES;
    }
    return NO;
}
@end
