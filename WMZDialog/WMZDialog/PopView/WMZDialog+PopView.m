




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
    CGRect tapRect = self.wTapView.frame;
    //获取导航栏的真实frame
    if (self.wNavigationItem) {
         tapRect = [self.wParentVC.navigationController.view convertRect:self.wTapView.frame fromView:self.wTapView.superview];
    }
    if (tapRect.size.width == 0|| tapRect.size.height==0) {
        [self.wTapView.superview layoutIfNeeded];
        tapRect = self.wTapView.frame;
    }
    
    [self.mainView addSubview:self.titleLabel];
  
    self.tableView.frame = CGRectMake(0, 0, self.wWidth, self.wCellHeight*([self.wData count]>8?8:[self.wData count]));
    [self.mainView addSubview:self.tableView];
    
    CGRect rect = CGRectZero;
    rect.size.width = self.wWidth;
    rect.size.height = CGRectGetMaxY(self.tableView.frame);
    
    DiaDirection direction = self.wDirection;
    
    if (direction == directionDowm) {
         rect.origin.x = tapRect.origin.x*self.wPercentOrginX;
        //超出屏幕方向变为上面
        if (rect.size.height+self.wMainOffsetY+CGRectGetMaxY(tapRect)>Device_Dialog_Height) {
            direction = directionUp;
            rect.origin.y = CGRectGetMinY(tapRect) - self.wMainOffsetY - rect.size.height;
        }else{
            rect.origin.y = self.wMainOffsetY+CGRectGetMaxY(tapRect);
        }
    }
    if (direction == directionUp) {
        rect.origin.x = tapRect.origin.x*self.wPercentOrginX;
        //超出屏幕方向变为下面
        if (CGRectGetMinY(tapRect) -self.wMainOffsetY - rect.size.height < (isIphoneX?15:0)) {
            direction = directionDowm;
            rect.origin.y = self.wMainOffsetY+CGRectGetMaxY(tapRect);
        }else{
            rect.origin.y = CGRectGetMinY(tapRect) - self.wMainOffsetY - rect.size.height;
        }
    }
    
    if (direction == directionright) {
        rect.origin.y = tapRect.origin.y*self.wPercentOrginX;
        //超出屏幕方向变为左面
        if (rect.size.width+self.wMainOffsetY+CGRectGetMaxX(tapRect)>Device_Dialog_Width) {
            direction = directionLeft;
            rect.origin.x = CGRectGetMinX(tapRect) - self.wMainOffsetY - rect.size.width;
        }else{
            rect.origin.x = self.wMainOffsetY+CGRectGetMaxX(tapRect);
        }
    }
    
    if (direction == directionLeft) {
        rect.origin.y = tapRect.origin.y*self.wPercentOrginX;
        //超出屏幕方向变为下面
        if (CGRectGetMinX(tapRect) - self.wMainOffsetY - rect.size.width<0) {
            direction = directionright;
            rect.origin.x = self.wMainOffsetY+CGRectGetMaxX(tapRect);
        }else{
            rect.origin.x = CGRectGetMinX(tapRect) - self.wMainOffsetY - rect.size.width;
        }
    }

    self.mainView.frame = rect;
    
  
    if (!self.wNavigationItem) {
        if (direction == directionUp || direction == directionDowm) {
            self.mainView.center = CGPointMake(self.wTapView.center.x * self.wPercentOrginX, self.mainView.center.y);
        }else{
            self.mainView.center = CGPointMake(self.mainView.center.x,self.wTapView.center.y * self.wPercentOrginX);
        }
    }else{
        if (CGRectGetMaxX(self.mainView.frame)>Device_Dialog_Width) {
            CGRect myRect = self.mainView.frame;
            myRect.origin.x = CGRectGetMaxX(tapRect)-self.mainView.frame.size.width;
            self.mainView.frame = myRect;
        }
    }

    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    NSDictionary *dic = @{
                          @(directionDowm):@"getMyDownPath",
                          @(directionUp):@"getMyUpPath",
                          @(directionLeft):@"getMyLeftPath",
                          @(directionright):@"getMyRightPath",
                          };
    SEL sel = NSSelectorFromString(dic[@(direction)]);
    SuppressPerformSelectorLeakWarning(
                                       UIBezierPath *path =  [self performSelector:sel];
                                       maskLayer.path = path.CGPath;
                                       );
    maskLayer.frame = self.mainView.bounds;
    maskLayer.fillColor = self.wMainBackColor.CGColor;
    
//    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.mainView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(self.wMainRadius,self.wMainRadius)];
//    CAShapeLayer *cornerLayer = [[CAShapeLayer alloc]init];
//    cornerLayer.frame = self.mainView.bounds;
//    cornerLayer.path = maskPath.CGPath;
    [self.mainView.layer addSublayer:maskLayer];
    return self.mainView;
}

/**
 配置贝塞尔曲线
 */
- (UIBezierPath*)getMyDownPath{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(self.wWidth*self.wPercentAngle-self.wMainOffsetX,0)];
    [path addLineToPoint:CGPointMake(self.wWidth*self.wPercentAngle, -self.wMainOffsetX)];
    [path addLineToPoint:CGPointMake(self.wWidth*self.wPercentAngle+self.wMainOffsetX, 0) ];
    [path closePath];
    return path;
}


- (UIBezierPath*)getMyUpPath{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, self.mainView.frame.size.height)];
    [path addLineToPoint:CGPointMake(self.wWidth*self.wPercentAngle-self.wMainOffsetX,self.mainView.frame.size.height)];
    [path addLineToPoint:CGPointMake(self.wWidth*self.wPercentAngle, self.wMainOffsetX+self.mainView.frame.size.height)];
    [path addLineToPoint:CGPointMake(self.wWidth*self.wPercentAngle+self.wMainOffsetX,self.mainView.frame.size.height)];
    [path closePath];
    return path;
}

- (UIBezierPath*)getMyRightPath{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(0,self.mainView.frame.size.height*self.wPercentAngle-self.wMainOffsetX)];
    [path addLineToPoint:CGPointMake(-self.wMainOffsetX,self.mainView.frame.size.height*self.wPercentAngle)];
    [path addLineToPoint:CGPointMake(0,self.mainView.frame.size.height*self.wPercentAngle+self.wMainOffsetX)];
    [path closePath];
    return path;
}

- (UIBezierPath*)getMyLeftPath{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(self.wWidth, 0)];
    [path addLineToPoint:CGPointMake(self.wWidth,self.mainView.frame.size.height*self.wPercentAngle-self.wMainOffsetX)];
    [path addLineToPoint:CGPointMake(self.wWidth+self.wMainOffsetX, self.mainView.frame.size.height*self.wPercentAngle)];
    [path addLineToPoint:CGPointMake(self.wWidth,self.mainView.frame.size.height*self.wPercentAngle+self.wMainOffsetX)];
    [path closePath];
    return path;
}


@end
