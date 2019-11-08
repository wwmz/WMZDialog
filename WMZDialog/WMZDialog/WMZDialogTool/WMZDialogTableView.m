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
        return YES;
    }
    return NO;
}
@end
