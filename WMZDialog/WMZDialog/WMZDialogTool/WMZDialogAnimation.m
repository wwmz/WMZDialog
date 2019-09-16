//
//  WMZDialogAnimation.m
//  WMZDialog
//
//  Created by wmz on 2019/9/11.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "WMZDialogAnimation.h"

@implementation WMZDialogAnimation

//抖动
void shakerAnimation (UIView *view ,NSTimeInterval duration,float height){
    
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.y"];
    CGFloat currentTx = view.transform.ty;
    animation.duration = duration;
    animation.values = @[@(currentTx), @(currentTx + height), @(currentTx-height/3*2), @(currentTx + height/3*2), @(currentTx -height/3), @(currentTx + height/3), @(currentTx)];
    animation.keyTimes = @[ @(0), @(0.225), @(0.425), @(0.6), @(0.75), @(0.875), @(1) ];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.removedOnCompletion = NO;
    [view.layer addAnimation:animation forKey:@"kViewShakerAnimationKey"];
}

//淡入
void curverOnAnimation (UIView *view ,NSTimeInterval duration )
{
    CAGradientLayer *contentLayer = (CAGradientLayer *)view.layer;
    CABasicAnimation *showViewAnn = [CABasicAnimation animationWithKeyPath:@"opacity"];
    showViewAnn.fromValue = [NSNumber numberWithFloat:0.0];
    showViewAnn.toValue = [NSNumber numberWithFloat:1.0];
    showViewAnn.duration = duration;
    showViewAnn.fillMode = kCAFillModeForwards;
    showViewAnn.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    showViewAnn.removedOnCompletion = NO;
    [contentLayer addAnimation:showViewAnn forKey:@"myShow"];
}


//淡出
void curverOffAnimation (UIView *view ,NSTimeInterval duration)
{
    CAGradientLayer *contentLayer = (CAGradientLayer *)view.layer;
    CABasicAnimation *showViewAnn = [CABasicAnimation animationWithKeyPath:@"opacity"];
    showViewAnn.fromValue = [NSNumber numberWithFloat:1.0];
    showViewAnn.toValue = [NSNumber numberWithFloat:0.0];
    showViewAnn.duration = duration;
    showViewAnn.fillMode = kCAFillModeForwards;
    showViewAnn.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    showViewAnn.removedOnCompletion = NO;
    [contentLayer addAnimation:showViewAnn forKey:@"myShow"];
}


//由小变大
void zoomInAnimation (UIView *view ,NSTimeInterval duration){
    CAGradientLayer *contentLayer = (CAGradientLayer *)view.layer;
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0, 0, 1)];
    scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)];
    
    scaleAnimation.duration = duration;
    scaleAnimation.cumulative = NO;
    scaleAnimation.repeatCount = 1;
    scaleAnimation.removedOnCompletion = NO;
    [scaleAnimation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    [contentLayer addAnimation: scaleAnimation forKey:@"myScale"];
    
}

//由大变小
void zoomOutAnimation (UIView *view ,NSTimeInterval duration)
{
    CAGradientLayer *contentLayer = (CAGradientLayer *)view.layer;
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)];
    scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0, 0, 1)];
    scaleAnimation.duration = duration;
    scaleAnimation.repeatCount = 1;
    scaleAnimation.removedOnCompletion = NO;
    scaleAnimation.fillMode = kCAFillModeForwards;
    [scaleAnimation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    [contentLayer addAnimation: scaleAnimation forKey:@"myScale"];
}


//逆时针
void rotationClockwiseAnimation(UIView* view,NSTimeInterval duration){
    CAGradientLayer *contentLayer = (CAGradientLayer *)view.layer;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue = [NSNumber numberWithFloat:M_PI];
    animation.toValue = [NSNumber numberWithFloat: M_PI*2]; // 终止角度
    
    CABasicAnimation *showViewAnn = [CABasicAnimation animationWithKeyPath:@"opacity"];
    showViewAnn.fromValue = [NSNumber numberWithFloat:0.0];
    showViewAnn.toValue = [NSNumber numberWithFloat:1.0];

    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = duration;
    group.repeatCount = 1;
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    [group setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    [group setAnimations:@[animation,showViewAnn]];
    
    [contentLayer addAnimation:group forKey:@"groupAnimation"];
}


//顺时针
void rotationCounterclockwiseAnimation(UIView* view,NSTimeInterval duration){
    CAGradientLayer *contentLayer = (CAGradientLayer *)view.layer;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.duration = duration; // 持续时间
    animation.repeatCount = 1; // 重复次数
    animation.fromValue = [NSNumber numberWithFloat:M_PI]; // 起始角度
    animation.toValue = [NSNumber numberWithFloat: 0.0]; // 终止角度
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)];
    scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0, 0, 1)];
    scaleAnimation.duration = duration;
    scaleAnimation.repeatCount = 1;
    scaleAnimation.removedOnCompletion = NO;
    scaleAnimation.fillMode = kCAFillModeForwards;
    [scaleAnimation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    [contentLayer addAnimation: scaleAnimation forKey:@"myScale"];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = duration;
    group.removedOnCompletion = NO;
    group.repeatCount = 1;
    group.fillMode = kCAFillModeForwards;
    [group setAnimations:@[animation,scaleAnimation]];
    
    [contentLayer addAnimation:group forKey:@"groupAnimation"];
}


//出现组合动画 样式1
void combineShowOneAnimation(UIView* view,NSTimeInterval duration){
    // 动画组合
    CABasicAnimation *positionAnima = [CABasicAnimation animationWithKeyPath:@"position.y"];
    positionAnima.duration = duration/2;
    positionAnima.fromValue = @(view.center.y);
    positionAnima.toValue =  @(view.center.y - 100);
    positionAnima.timingFunction = [CAMediaTimingFunction
                                    functionWithName:kCAMediaTimingFunctionLinear];
    positionAnima.repeatCount = 1;
    //    positionAnima.repeatDuration = 2;
    positionAnima.removedOnCompletion = NO;
    positionAnima.fillMode = kCAFillModeForwards;
    positionAnima.autoreverses = YES; // 执行逆动画
    [view.layer addAnimation:positionAnima forKey:@"AnimationMoveY"];
    /* 放大缩小 */
    // 设定为缩放
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    // 动画选项设定
    animation.duration = duration; // 动画持续时间
    animation.repeatCount = 1; // 重复次数
    animation.autoreverses = YES; // 动画结束时执行逆动画
    // 缩放倍数
    animation.fromValue = [NSNumber numberWithFloat:1]; // 开始时的倍率
    animation.toValue = [NSNumber numberWithFloat:0.8]; // 结束时的倍率
    // 添加动画
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    [view.layer addAnimation:animation forKey:@"scale-layer"];
    
    
}

//出现组合动画 样式2
void combineShowTwoAnimation(UIView* view,NSTimeInterval duration){
    // 1.创建旋转动画对象
    CABasicAnimation *rotate = [CABasicAnimation animation];
    rotate.keyPath = @"transform.rotation";
    rotate.fromValue = [NSNumber numberWithFloat:M_PI];
    rotate.toValue = [NSNumber numberWithFloat: M_PI*2]; // 终止角度
    
    CABasicAnimation *scale = [CABasicAnimation animation];
    scale.keyPath = @"transform.scale";
    scale.fromValue = @(0.0);
    scale.toValue = @(1.0);
    
    CABasicAnimation *move = [CABasicAnimation animation];
    move.keyPath = @"transform.translation";
    //    move.fromValue = [NSValue valueWithCGPoint:CGPointMake(view.frame.origin.x-100, view.frame.origin.y-100)];
    move.fromValue = [NSValue valueWithCGPoint:CGPointMake(100, 100)];
    //    move.toValue = [NSValue valueWithCGPoint:CGPointMake(100, 100)];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[rotate, scale, move];
    group.duration = duration;
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    
    [view.layer addAnimation:group forKey:nil];
    
}

//消失组合动画 样式1
void combineHideOneAnimation(UIView* view,NSTimeInterval duration){
    CABasicAnimation *rotate = [CABasicAnimation animation];
    rotate.keyPath = @"transform.rotation";
    rotate.toValue = @(M_PI);
    
    CABasicAnimation *scale = [CABasicAnimation animation];
    scale.keyPath = @"transform.scale";
    scale.toValue = @(0.0);
    
    CABasicAnimation *move = [CABasicAnimation animation];
    move.keyPath = @"transform.translation";
    move.toValue = [NSValue valueWithCGPoint:CGPointMake(100, 100)];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[rotate, scale, move];
    group.duration = duration;
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    
    [view.layer addAnimation:group forKey:nil];
}

/*
 *阻尼动画 出现的弹簧运动
 @prarm subView 带有子视图的数组
 @prarm kColumnCount 列
 @prarm kSectionCount 行
 @prarm vMarginY 上下间距
 @prarm vSpacingY item之间的Y轴间距
 @prarm vMarginX 左右间距
 @prarm vSpacingX item之间的X轴间距
 @prarm hideFirstPageView 是否做弹簧动画
 @prarm block 动画完成回调
 */
void springShowAnimation(UIScrollView *scrollView,NSTimeInterval duration,NSArray *subView,NSInteger kColumnCount,NSInteger kSectionCount,CGFloat vMarginY,CGFloat vSpacingY,CGFloat vMarginX,CGFloat vSpacingX,bool hideFirstPageView,animalBlock block){
    
    CGFloat height = scrollView.frame.size.height;          //高度
    CGFloat width = scrollView.frame.size.width;
    NSInteger count = subView.count;          //数量
    NSInteger pages = (count - 1) / (kColumnCount * kSectionCount) + 1;
    scrollView.contentSize = CGSizeMake(width * pages, 0);
    CGFloat itemWidth =  (width - 2 * vMarginX -  (kColumnCount-1)*vSpacingX ) / kColumnCount;
    CGFloat itemHeight = (height - 2 * vMarginY -  (kSectionCount-1)*vSpacingY) /kSectionCount;
    NSInteger row = 0;
    NSInteger loc = 0;
    CGFloat x = 0;
    CGFloat y = 0;
    for (NSInteger i = 0; i < subView.count; i ++) {
        row = i / kColumnCount % kSectionCount;
        loc = i % kColumnCount ;
        x = (itemWidth + vSpacingX) * loc + (i / (kColumnCount * kSectionCount)) * width + vMarginX;
        
        if (i / (kColumnCount * kSectionCount) > 0) {
            y = vMarginY + (itemHeight + vSpacingY) * row;
        } else {
            y = vMarginY +  (itemHeight + vSpacingY) * row;
            if (hideFirstPageView) {
                y += scrollView.frame.size.height;
            }
        }
        
        UIView *iconView = subView[i];
        iconView.frame = CGRectMake(x, y, itemWidth, itemHeight);
        if (kSectionCount == 1&& i== ([subView count]-1)) {
            scrollView.contentSize = CGSizeMake(CGRectGetMaxX(iconView.frame), 0);
        }
        if (i < kColumnCount * kSectionCount && hideFirstPageView) {
            iconView.alpha = 0.0;
            [UIView animateWithDuration:duration
                                  delay:i * 0.05
                 usingSpringWithDamping:0.7
                  initialSpringVelocity:0.04
                                options:UIViewAnimationOptionAllowUserInteraction animations:^{
                                    iconView.alpha = 1.0;
                                    CGRect rect = iconView.frame;
                                    rect.origin.y -= scrollView.frame.size.height;
                                    iconView.frame = rect;
                                } completion:^(BOOL finished) {
                                    if (block && i== ([subView count]-1)) {
                                        block();
                                    }
                                }];
        }
    }
    
}

void springHideAnimation(UIScrollView *scrollView,NSTimeInterval duration,NSArray *subView,animalBlock block){
    
    for (int i = 0; i<[subView count]; i++) {
        UIView *iconView = subView[i];
        if (![iconView isKindOfClass:[UIView class]]) continue;
        iconView.alpha = 1.0;
        [UIView animateWithDuration:duration
                              delay:0.05 * [subView count] - i * 0.03
             usingSpringWithDamping:0.7
              initialSpringVelocity:0.04
                            options:UIViewAnimationOptionCurveEaseInOut animations:^{
                                iconView.alpha = 0.0;
                                CGRect rect = iconView.frame;
                                rect.origin.y += scrollView.frame.size.height;
                                iconView.frame = rect;
                            } completion:^(BOOL finished) {
                                if (block && i== ([subView count]-1)) {
                                    [scrollView removeFromSuperview];
                                    block();
                                }
                            }];
    }
}

//画圆动画
void waitAnimation(UIView* view,NSTimeInterval duration,UIColor *color,CGFloat width) {
    //显示图层
    CAShapeLayer *circleLayer = [CAShapeLayer layer];
    circleLayer.frame = view.bounds;
    [view.layer addSublayer:circleLayer];
    circleLayer.fillColor = [[UIColor clearColor] CGColor];
    circleLayer.strokeColor = color.CGColor;
    circleLayer.lineWidth = width;
    circleLayer.lineCap = kCALineCapRound;
    
    CGFloat lineWidth = 5.0f;
    CGFloat radius = view.bounds.size.width/2.0f - lineWidth/2.0f;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:circleLayer.position radius:radius startAngle:-M_PI/2 endAngle:M_PI*3/2 clockwise:true];
    circleLayer.path = path.CGPath;
    
    CABasicAnimation *checkAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    checkAnimation.duration = duration;
    checkAnimation.fromValue = @(0.0f);
    checkAnimation.toValue = @(1.0f);
    [checkAnimation setValue:@"checkAnimation" forKey:@"animationName"];
    [circleLayer addAnimation:checkAnimation forKey:nil];
}



//正确动画
void rightAnimation(UIView* view,NSTimeInterval duration,UIColor *color,CGFloat width){
    
    //外切圆的边长
    CGFloat a = view.bounds.size.width;

    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(a*2.7/10,a*5.4/10)];
    [path addLineToPoint:CGPointMake(a*4.5/10,a*7/10)];
    [path addLineToPoint:CGPointMake(a*7.8/10,a*3.8/10)];
    

    CAShapeLayer *checkLayer = [CAShapeLayer layer];
    checkLayer.path = path.CGPath;
    checkLayer.fillColor = [UIColor clearColor].CGColor;
    checkLayer.strokeColor = color.CGColor;
    checkLayer.lineWidth = width;
    checkLayer.lineCap = kCALineCapRound;
    checkLayer.lineJoin = kCALineJoinRound;
    [view.layer addSublayer:checkLayer];
    

    CABasicAnimation *checkAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    checkAnimation.duration = duration;
    checkAnimation.fromValue = @(0.0f);
    checkAnimation.toValue = @(1.0f);
    [checkAnimation setValue:@"checkAnimation" forKey:@"animationName"];
    [checkLayer addAnimation:checkAnimation forKey:nil];
}


//错误动画
void errorAnimation(UIView* view,NSTimeInterval duration,UIColor *color,CGFloat width){
    
    //外切圆的边长
    CGFloat a = view.bounds.size.width;
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat x = 3;
    CGFloat y = 7;
    [path moveToPoint:CGPointMake(a*x/10,a*x/10)];
    [path addLineToPoint:CGPointMake(a*y/10,a*y/10)];
    [path moveToPoint:CGPointMake(a*y/10,a*x/10)];
    [path addLineToPoint:CGPointMake(a*x/10,a*y/10)];
    

    CAShapeLayer *checkLayer = [CAShapeLayer layer];
    checkLayer.path = path.CGPath;
    checkLayer.fillColor = [UIColor clearColor].CGColor;
    checkLayer.strokeColor = color.CGColor;
    checkLayer.lineWidth = width;
    checkLayer.lineCap = kCALineCapRound;
    checkLayer.lineJoin = kCALineJoinRound;
    [view.layer addSublayer:checkLayer];
    

    CABasicAnimation *checkAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    checkAnimation.duration = duration;
    checkAnimation.fromValue = @(0.0f);
    checkAnimation.toValue = @(1.0f);
    [checkAnimation setValue:@"checkAnimation" forKey:@"animationName"];
    [checkLayer addAnimation:checkAnimation forKey:nil];
}


void loadingAnimation(UIView* view,NSTimeInterval duration,UIColor *color,CGFloat width){
    
    CAShapeLayer *asmLayer = [CAShapeLayer layer];
    asmLayer.frame = view.bounds;
    
    UIBezierPath * path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetMidX(view.bounds), CGRectGetMidY(view.bounds)) radius:view.frame.size.width/2- width/2.0f startAngle:0 endAngle:2*M_PI clockwise:YES];
     path.lineCapStyle = kCGLineCapRound;
    //路径
    asmLayer.path = path.CGPath;
    asmLayer.fillColor = [UIColor clearColor].CGColor;
    asmLayer.strokeColor = color.CGColor;
    asmLayer.lineWidth = width;
    [view.layer addSublayer:asmLayer];
    
    
    CABasicAnimation * anima = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    anima.fromValue = [NSNumber numberWithFloat:0.f];
    anima.toValue = [NSNumber numberWithFloat:1.f];
    anima.duration = 2.0f;
    anima.repeatCount = MAXFLOAT;
    anima.autoreverses = YES;
    anima.removedOnCompletion = NO;
    asmLayer.strokeColor = color.CGColor;
    [asmLayer addAnimation:anima forKey:@"strokeEndAniamtion"];
    
    CABasicAnimation *anima3 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    anima3.toValue = [NSNumber numberWithFloat:-M_PI*2];
    anima3.duration = 1.0f;
    anima3.repeatCount = MAXFLOAT;
    [view.layer addAnimation:anima3 forKey:@"rotaionAniamtion"];
}

@end
