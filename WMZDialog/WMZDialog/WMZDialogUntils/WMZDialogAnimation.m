//
//  WMZDialogAnimation.m
//  WMZDialog
//
//  Created by wmz on 2019/9/11.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "WMZDialogAnimation.h"

@interface WMZDialogAnimation()<CAAnimationDelegate>

@end

@implementation WMZDialogAnimation

-(void)curverOnAnimationWithView:(UIView*)view duration:(NSTimeInterval)duration{
    CAGradientLayer *contentLayer = (CAGradientLayer *)view.layer;
    CABasicAnimation *showViewAnn = [CABasicAnimation animationWithKeyPath:@"opacity"];
    showViewAnn.fromValue = [NSNumber numberWithFloat:0.0];
    showViewAnn.toValue = [NSNumber numberWithFloat:1.0];
    showViewAnn.duration = duration;
    showViewAnn.fillMode = kCAFillModeForwards;
    showViewAnn.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    showViewAnn.removedOnCompletion = NO;
    showViewAnn.delegate = self;
    [contentLayer addAnimation:showViewAnn forKey:@"myShow"];
}

-(void)curverOffAnimationWithView:(UIView*)view duration:(NSTimeInterval)duration{
    CAGradientLayer *contentLayer = (CAGradientLayer *)view.layer;
    CABasicAnimation *showViewAnn = [CABasicAnimation animationWithKeyPath:@"opacity"];
    showViewAnn.fromValue = [NSNumber numberWithFloat:1.0];
    showViewAnn.toValue = [NSNumber numberWithFloat:0.0];
    showViewAnn.duration = duration;
    showViewAnn.fillMode = kCAFillModeForwards;
    showViewAnn.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    showViewAnn.removedOnCompletion = NO;
    showViewAnn.delegate = self;
    [contentLayer addAnimation:showViewAnn forKey:@"myShow"];
}

-(void)zoomInAnimationWithView:(UIView*)view duration:(NSTimeInterval)duration{
    CAGradientLayer *contentLayer = (CAGradientLayer *)view.layer;
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0, 0, 1)];
    scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)];
    scaleAnimation.duration = duration;
    scaleAnimation.delegate = self;
    scaleAnimation.cumulative = NO;
    scaleAnimation.repeatCount = 1;
    scaleAnimation.removedOnCompletion = NO;
    scaleAnimation.fillMode = kCAFillModeForwards;
    [scaleAnimation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    [contentLayer addAnimation: scaleAnimation forKey:@"myScale"];
    
}

-(void)zoomOutAnimationWithView:(UIView*)view duration:(NSTimeInterval)duration{
    CAGradientLayer *contentLayer = (CAGradientLayer *)view.layer;
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)];
    scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0, 0, 1)];
    scaleAnimation.duration = duration;
    scaleAnimation.repeatCount = 1;
    scaleAnimation.removedOnCompletion = NO;
    scaleAnimation.fillMode = kCAFillModeForwards;
    scaleAnimation.delegate = self;
    [scaleAnimation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    [contentLayer addAnimation: scaleAnimation forKey:@"myScale"];
}

-(void)zoomInBigToNormalAnimationWithView:(UIView*)view duration:(NSTimeInterval)duration{
     CAGradientLayer *contentLayer = (CAGradientLayer *)view.layer;
     CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
     scaleAnimation.fromValue = [NSNumber numberWithFloat:1.2];
     scaleAnimation.toValue = [NSNumber numberWithFloat:0.8];
     scaleAnimation.beginTime = 0;
     scaleAnimation.duration = duration/2;

     CABasicAnimation *showViewAnn = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
     showViewAnn.fromValue = [NSNumber numberWithFloat:0.8];
     showViewAnn.toValue = [NSNumber numberWithFloat:1.0];
     showViewAnn.beginTime = duration/2;
     showViewAnn.duration = duration/2;

     CAAnimationGroup *group = [CAAnimationGroup animation];
     group.repeatCount = 1;
     group.duration = duration;
     group.fillMode = kCAFillModeForwards;
     group.removedOnCompletion = YES;
     [group setAnimations:@[scaleAnimation,showViewAnn]];
     group.delegate = self;
     [contentLayer addAnimation:group forKey:@"groupAnimation"];
}

-(void)rotationClockwiseAnimationWithView:(UIView*)view duration:(NSTimeInterval)duration{
    CAGradientLayer *contentLayer = (CAGradientLayer *)view.layer;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue = [NSNumber numberWithFloat:M_PI];
    animation.toValue = [NSNumber numberWithFloat: M_PI*2]; // 终止角度
    
    CABasicAnimation *showViewAnn = [CABasicAnimation animationWithKeyPath:@"opacity"];
    showViewAnn.fromValue = [NSNumber numberWithFloat:0];
    showViewAnn.toValue = [NSNumber numberWithFloat:1];

    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = duration;
    group.repeatCount = 1;
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    [group setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    [group setAnimations:@[animation,showViewAnn]];
    group.delegate = self;
    [contentLayer addAnimation:group forKey:@"groupAnimation"];
}

-(void)rotationDisappealClockwiseAnimationWithView:(UIView*)view duration:(NSTimeInterval)duration{
    CAGradientLayer *contentLayer = (CAGradientLayer *)view.layer;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue = [NSNumber numberWithFloat:M_PI];
    animation.toValue = [NSNumber numberWithFloat: M_PI*2]; // 终止角度
    
    CABasicAnimation *showViewAnn = [CABasicAnimation animationWithKeyPath:@"opacity"];
    showViewAnn.fromValue = [NSNumber numberWithFloat:1];
    showViewAnn.toValue = [NSNumber numberWithFloat:0];

    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = duration;
    group.repeatCount = 1;
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    [group setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    [group setAnimations:@[animation,showViewAnn]];
    group.delegate = self;
    [contentLayer addAnimation:group forKey:@"groupAnimation"];
}

-(void)rotationCounterclockwiseAnimationWithView:(UIView*)view duration:(NSTimeInterval)duration{
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
    group.delegate = self;
    [contentLayer addAnimation:group forKey:@"groupAnimation"];
}

-(void)combineShowOneAnimationWithView:(UIView*)view duration:(NSTimeInterval)duration{
    CABasicAnimation *positionAnima = [CABasicAnimation animationWithKeyPath:@"position.y"];
    positionAnima.duration = duration/2;
    positionAnima.fromValue = @(view.center.y);
    positionAnima.toValue =  @(view.center.y - 100);
    positionAnima.timingFunction = [CAMediaTimingFunction
                                    functionWithName:kCAMediaTimingFunctionLinear];
    positionAnima.repeatCount = 1;
    positionAnima.removedOnCompletion = NO;
    positionAnima.fillMode = kCAFillModeForwards;
    positionAnima.autoreverses = YES; // 执行逆动画
    [view.layer addAnimation:positionAnima forKey:@"AnimationMoveY"];
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration = duration;
    animation.repeatCount = 1;
    animation.autoreverses = YES;
    animation.fromValue = [NSNumber numberWithFloat:1];
    animation.toValue = [NSNumber numberWithFloat:0.8];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    [view.layer addAnimation:animation forKey:@"scale-layer"];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[animation,positionAnima];
    group.delegate = self;
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    [view.layer addAnimation:group forKey:nil];
}

-(void)combineShowTwoAnimationWithView:(UIView*)view duration:(NSTimeInterval)duration{
    CABasicAnimation *rotate = [CABasicAnimation animation];
    rotate.keyPath = @"transform.rotation";
    rotate.fromValue = [NSNumber numberWithFloat:M_PI];
    rotate.toValue = [NSNumber numberWithFloat: M_PI*2];
    
    CABasicAnimation *scale = [CABasicAnimation animation];
    scale.keyPath = @"transform.scale";
    scale.fromValue = @(0.0);
    scale.toValue = @(1.0);
    
    CABasicAnimation *move = [CABasicAnimation animation];
    move.keyPath = @"transform.translation";
    move.fromValue = [NSValue valueWithCGPoint:CGPointMake(100, 100)];
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[rotate, scale, move];
    group.duration = duration;
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    group.delegate = self;
    [view.layer addAnimation:group forKey:nil];
    
}

-(void)combineHideOneAnimationWithView:(UIView*)view duration:(NSTimeInterval)duration{
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
    group.delegate = self;
    [view.layer addAnimation:group forKey:nil];
}

- (void)scaleShowAninationWithView:(UIView*)view duration:(NSTimeInterval)duration{
    CABasicAnimation *scale = [CABasicAnimation animation];
    scale.keyPath = @"transform.scale";
    scale.fromValue = [NSNumber numberWithFloat:1.25];
    scale.toValue = [NSNumber numberWithFloat:1.0];

    CABasicAnimation *showViewAnn = [CABasicAnimation animationWithKeyPath:@"opacity"];
    showViewAnn.fromValue = [NSNumber numberWithFloat:0.5];
    showViewAnn.toValue = [NSNumber numberWithFloat:1];

    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[scale, showViewAnn];
    group.duration = duration/2;
    group.delegate = self;
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    [view.layer addAnimation:group forKey:nil];
}

- (void)scaleHideAninationWithView:(UIView*)view duration:(NSTimeInterval)duration{
     CABasicAnimation *scale = [CABasicAnimation animation];
     scale.keyPath = @"transform.scale";
     scale.fromValue = [NSNumber numberWithFloat:1];
     scale.toValue = [NSNumber numberWithFloat:1.25];

     CABasicAnimation *showViewAnn = [CABasicAnimation animationWithKeyPath:@"opacity"];
     showViewAnn.fromValue = [NSNumber numberWithFloat:1];
     showViewAnn.toValue = [NSNumber numberWithFloat:0];

     CAAnimationGroup *group = [CAAnimationGroup animation];
     group.animations = @[scale, showViewAnn];
     group.duration = duration/2;
     group.delegate = self;
     group.removedOnCompletion = NO;
     group.fillMode = kCAFillModeForwards;
     [view.layer addAnimation:group forKey:nil];
}

void springShowAnimation(UIScrollView *scrollView,NSTimeInterval duration,NSArray *subView,NSInteger kColumnCount,NSInteger kSectionCount,CGFloat vMarginY,CGFloat vSpacingY,CGFloat vMarginX,CGFloat vSpacingX,bool hideFirstPageView,AnimalBlock block){
    
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

void springHideAnimation(UIScrollView *scrollView,NSTimeInterval duration,NSArray *subView,AnimalBlock block){
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

void loadingAnimation(UIView* view,NSTimeInterval duration,UIColor *color,CGFloat width){
    CAShapeLayer *asmLayer = [CAShapeLayer layer];
    asmLayer.frame = view.bounds;
    
    UIBezierPath * path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetMidX(view.bounds), CGRectGetMidY(view.bounds)) radius:view.frame.size.width/2- width/2.0f startAngle:0 endAngle:2*M_PI clockwise:YES];
     path.lineCapStyle = kCGLineCapRound;
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

void newLoadingAnimation(UIView* view,CAShapeLayer *lineLayer,NSTimeInterval duration){
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath: @"strokeEnd"];
    animation.fromValue = @0 ;
    animation.toValue = @1 ;
    animation.duration = duration ;
    [lineLayer addAnimation:animation forKey :@"strokeEnd"];
    [view.layer addSublayer:lineLayer];
}

- (void)verticalMoveShowAnimationWithView:(UIView*)view duration:(NSTimeInterval)duration top:(BOOL)top{
    CGRect rect = view.frame;
    view.frame = CGRectMake(rect.origin.x, top?[UIScreen mainScreen].bounds.size.height:(-rect.size.height) , rect.size.width, rect.size.height);
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        view.frame = rect;
    } completion:^(BOOL finished) {
        if (self.block) self.block();
    }];
}

- (void)verticalMoveHideAnimationWithView:(UIView*)view duration:(NSTimeInterval)duration top:(BOOL)top{
    CGRect rect = view.frame;
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        view.frame = CGRectMake(rect.origin.x, top?[UIScreen mainScreen].bounds.size.height:(-rect.size.height) , rect.size.width, rect.size.height);
    } completion:^(BOOL finished) {
        if (self.block) self.block();
    }];
}

- (void)landscapeMoveShowAnimationWithView:(UIView*)view duration:(NSTimeInterval)duration right:(BOOL)right{
    CGRect rect = view.frame;
    view.frame = CGRectMake( right?[UIScreen mainScreen].bounds.size.width:-(rect.size.width),rect.origin.y , rect.size.width, rect.size.height);
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        view.frame = rect;
    } completion:^(BOOL finished) {
        if (self.block) self.block();
    }];
}

- (void)landscapeMoveHideAnimationWithView:(UIView*)view duration:(NSTimeInterval)duration right:(BOOL)right{
    CGRect rect = view.frame;
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        view.frame = CGRectMake(right?[UIScreen mainScreen].bounds.size.width:-(rect.size.width), rect.origin.y , rect.size.width, rect.size.height);
    } completion:^(BOOL finished) {
        if (self.block) self.block();
    }];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if (self.block) self.block();
}

@end
