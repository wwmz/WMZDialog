//
//  WMZDialogUntils.m
//  WMZDialog
//
//  Created by wmz on 2019/6/5.
//  Copyright © 2019年 wmz. All rights reserved.
//

#import "WMZDialogUntils.h"

@implementation WMZDialogUntils

+ (UIViewController *)getCurrentVC{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    return currentVC;
}

+ (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC{
    UIViewController *currentVC;
    if ([rootVC presentedViewController]) {
        rootVC = [rootVC presentedViewController];
    }
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
        
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
        
    } else {
        currentVC = rootVC;
    }
    return currentVC;
}

+ (CGSize)sizeForTextView:(CGSize)constraint
                     text:(NSString *)text
                     font:(UIFont*)font{
    if (!text||
        ![text isKindOfClass:NSString.class]||
        !text.length) return CGSizeZero;
    CGRect rect = [text boundingRectWithSize:constraint
                    options:(NSStringDrawingUsesLineFragmentOrigin|
                             NSStringDrawingUsesFontLeading)
                        attributes:@{NSFontAttributeName: font}
                                        context:nil];
    return rect.size;
}

+ (void)setCornerView:(UIView *)view
                radio:(CGSize)radio
           rectCorner:(UIRectCorner)rectCorner{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:rectCorner cornerRadii:radio];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
}

+ (NSBundle*)getMainBundle{
    NSBundle* bundle = [NSBundle bundleWithPath:[[NSBundle bundleForClass:[WMZDialogUntils class]] pathForResource:@"WMZDialog" ofType:@"bundle"]];
    return bundle;
}

@end

static NSString *WMZDialogPopLayerKey = @"WMZDialogPopLayerKey";
static NSString *WMZDialogPopMaskName = @"WMZDialogPopMaskName";
@implementation UIView(DialogPop)
-(void)addArrowBorderAt:(DiaDirection)direction
                 offset:(CGFloat)offset
             rectCorner:(DialogRectCorner)corner
                  width:(CGFloat)width
                 height:(CGFloat)height
           cornerRadius:(CGFloat)cornerRadius
            borderWidth:(CGFloat)borderWidth
            borderColor:(UIColor *)borderColor
             angleRadio:(CGFloat)angleRadio{
    [self removeWMZDialogPop];
    CGFloat normalCornerRadius = cornerRadius;
    //只有一个mask层
    CAShapeLayer *mask = [[CAShapeLayer alloc] init];
    mask.name = WMZDialogPopMaskName;
    mask.frame = self.bounds;
    self.layer.mask = mask;
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    CGFloat minX = 0, minY = 0, maxX = self.frame.size.width, maxY = self.frame.size.height;
    CGFloat bgWith = angleRadio*2.5;
    if (direction == directionUp) {
        minY = height;
    }else if (direction == directionright){
        maxX -= height;
    }else if (direction == directionLeft){
        minX += height;
    }else if (direction == directionDowm){
        maxY -= height;
    }
    //上边
    [path moveToPoint:CGPointMake(minX+cornerRadius, minY)];
    if (direction == directionUp) {
        [path addLineToPoint:CGPointMake(offset-width/2, minY)];
        if (angleRadio) {
            [path addArcWithCenter:CGPointMake(offset, minY - bgWith) radius:angleRadio startAngle:M_PI_4 * 5 endAngle:M_PI_4*7 clockwise:YES];
        }else{
            [path addLineToPoint:CGPointMake(offset, 2)];
        }
        [path addLineToPoint:CGPointMake(offset+width/2, minY)];
    }
    [path addLineToPoint:CGPointMake(maxX-cornerRadius, minY)];
    //右上角
    if (cornerRadius>0) {
        if (!(corner&DialogRectCornerTopRight)) {
            cornerRadius = 0;
        }
         [path addArcWithCenter:CGPointMake(maxX-cornerRadius, minY+cornerRadius) radius:cornerRadius startAngle:-M_PI_2 endAngle:0 clockwise:YES];
    }
    cornerRadius =  normalCornerRadius;
    //右边
    if (direction == directionright) {
        [path addLineToPoint:CGPointMake(maxX, offset-width/2)];
        if (angleRadio) {
            [path addArcWithCenter:CGPointMake(maxX + height, offset) radius:angleRadio startAngle:M_PI_4*3 endAngle:M_PI_4*5 clockwise:YES];
        }else{
            [path addLineToPoint:CGPointMake(maxX+height, offset)];
        }
        [path addLineToPoint:CGPointMake(maxX, offset+width/2)];
    }
    [path addLineToPoint:CGPointMake(maxX, maxY-cornerRadius)];
    //右下角
    if (cornerRadius>0) {
        if (!(corner&DialogRectCornerBottomRight)) {
            cornerRadius = 0;
        }
        [path addArcWithCenter:CGPointMake(maxX-cornerRadius, maxY-cornerRadius) radius:cornerRadius startAngle:0 endAngle:M_PI_2 clockwise:YES];
    }
    cornerRadius =  normalCornerRadius;
    //下边
    if (direction == directionDowm) {
        [path addLineToPoint:CGPointMake(offset-width/2, maxY)];
        if (angleRadio) {
            [path addArcWithCenter:CGPointMake(offset, maxY + bgWith) radius:angleRadio startAngle:M_PI_4*3 endAngle:M_PI_4 clockwise:NO];
        }else{
            [path addLineToPoint:CGPointMake(offset, maxY+height)];
        }
        [path addLineToPoint:CGPointMake(offset+width/2, maxY)];
    }
    [path addLineToPoint:CGPointMake(minX+cornerRadius, maxY)];
    //左下角
    if (cornerRadius>0) {
        if (!(corner&DialogRectCornerBottomLeft)) {
            cornerRadius = 0;
        }
        [path addArcWithCenter:CGPointMake(minX+cornerRadius, maxY-cornerRadius) radius:cornerRadius startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
    }
    cornerRadius =  normalCornerRadius;
    //右边
    if (direction == directionLeft) {
        [path addLineToPoint:CGPointMake(minX, offset-width/2)];
        if (angleRadio) {
            [path addArcWithCenter:CGPointMake(minX - height, offset) radius:angleRadio startAngle:M_PI_4*3 endAngle:M_PI_4*5 clockwise:YES];
        }else{
            [path addLineToPoint:CGPointMake(minX-height, offset)];
        }
        [path addLineToPoint:CGPointMake(minX, offset+width/2)];
    }
    [path addLineToPoint:CGPointMake(minX, minY+cornerRadius)];
    //右下角
    if (cornerRadius>0) {
        if (!(corner&DialogRectCornerTopLeft)) {
            cornerRadius = 0;
        }
        [path addArcWithCenter:CGPointMake(minX+cornerRadius, minY+cornerRadius) radius:cornerRadius startAngle:M_PI endAngle:M_PI_2*3 clockwise:YES];
    }
    cornerRadius =  normalCornerRadius;
    mask.path = [path CGPath];
    if (borderWidth>0) {
        CAShapeLayer *border = [[CAShapeLayer alloc] init];
        border.path = [path CGPath];
        border.strokeColor = borderColor.CGColor;
        border.lineWidth = borderWidth*2;
        border.fillColor = [UIColor clearColor].CGColor;
        [self.layer addSublayer:border];
        
        [self markWMZDialogPop:border];
    }
    
}

-(void)markWMZDialogPop:(CALayer *)layer{
    objc_setAssociatedObject(self, &WMZDialogPopLayerKey, layer, OBJC_ASSOCIATION_RETAIN);
}
 
-(void)removeWMZDialogPop{
    if ([self.layer.mask.name isEqualToString:WMZDialogPopMaskName]) {
        self.layer.mask = nil;
    }
    CAShapeLayer *oldLayer = objc_getAssociatedObject(self, &WMZDialogPopLayerKey);
    if (oldLayer) [oldLayer removeFromSuperlayer];
}

@end

@implementation WMZDialogTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self = [super initWithFrame:frame style:style]) {
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.estimatedRowHeight = 100;
        if (@available(iOS 11.0, *)) {
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            self.estimatedSectionFooterHeight = 0.01;
            self.estimatedSectionHeaderHeight = 0.01;
        }
        if (@available(iOS 15.0, *)) {
            self.sectionHeaderTopPadding = 0;
        }
        self.scrollsToTop = NO;
    }
    return self;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    
    if (self.wOpenScrollClose&&
        self.contentOffset.y <= 0 &&
        [otherGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        if (self.wCardPresent) {
            UIPanGestureRecognizer *pan = (UIPanGestureRecognizer*)otherGestureRecognizer;
            CGPoint translation = [pan translationInView:pan.view];
            CGFloat absX = fabs(translation.x);
            CGFloat absY = fabs(translation.y);
            if (MAX(absX, absY) >= 1){  /// 设置滑动有效距离
                if (absY > absX) return !(translation.y < 0);
            }
        }
        return YES;
    }
    return NO;
}

@end

@implementation WMZDialogButton

- (void)setHighlighted:(BOOL)highlighted{}

@end

@implementation WMZDialogShareView

- (instancetype)initWithText:(NSString*)text
                       image:(NSString*)image
                       block:(ShareViewSelect)block
                         tag:(NSInteger)tag{
    if (self = [super init]) {
        self.block = block;
        self.backgroundColor = UIColor.clearColor;
        self.layer.masksToBounds = YES;
        self.userInteractionEnabled = YES;
        self.tag = tag;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageAction:)];
        [self addGestureRecognizer:tap];
        
        [self addSubview:self.imageIV];
        self.imageIV.image = [UIImage imageNamed:image];
        
        [self addSubview:self.titleLB];
        self.titleLB.text = text;
    }
    return self;
}

- (UIImageView *)imageIV{
    if (!_imageIV) {
        _imageIV = [UIImageView new];
        _imageIV.contentMode = UIViewContentModeScaleAspectFill;
        _imageIV.layer.masksToBounds = YES;
    }
    return _imageIV;
}

- (UILabel *)titleLB{
    if (!_titleLB) {
        _titleLB = [UILabel new];
        _titleLB.textAlignment = NSTextAlignmentCenter;
        _titleLB.font = [UIFont systemFontOfSize:13.0f];
        _titleLB.userInteractionEnabled = NO;
    }
    return _titleLB;
}

- (void)imageAction:(UITapGestureRecognizer*)tap{
    if (self.block) self.block(self.tag,self.model?:self.titleLB.text);
}

- (void)layoutSubviews{
    [super layoutSubviews];
    if (!self.changeFrame) {
        CGFloat percentImage = 0.5;
        self.imageIV.frame = CGRectMake((self.frame.size.width - self.frame.size.height * percentImage) / 2,5, self.frame.size.height * percentImage, self.frame.size.height * percentImage);
        self.imageIV.layer.cornerRadius = (self.frame.size.height * 0.5) / 2;
        self.titleLB.frame = CGRectMake(10 * 0.5, CGRectGetMaxY(self.imageIV.frame) + 5, self.frame.size.width - 10, self.frame.size.height * (1 - percentImage) - 10 * 2);
    }
}

@end
