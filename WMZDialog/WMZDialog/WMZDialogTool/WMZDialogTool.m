



//
//  WMZDialogTool.m
//  WMZDialog
//
//  Created by wmz on 2019/6/5.
//  Copyright © 2019年 wmz. All rights reserved.
//

#import "WMZDialogTool.h"

@implementation WMZDialogTool
//获取当前VC
+ (UIViewController *)getCurrentVC
{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    return currentVC;
}

+ (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC
{
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


//16进制颜色
+ (UIColor *)stringTOColor:(NSString *)str
{
    if (!str || [str isEqualToString:@""]) {
        return [UIColor blackColor];
    }
    if (![str hasPrefix:@"#"]) {
        str = [NSString stringWithFormat:@"#%@",str];
    }
    
    NSString *cString = [[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

//获取文本size
+ (CGSize)sizeForTextView:(CGSize)constraint text:(NSString *)text font:(CGFloat)font{
    if (!text||text.length==0) {
        return CGSizeZero;
    }
    CGRect rect = [text boundingRectWithSize:constraint
                                        options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                     attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:font]}
                                        context:nil];
    return rect.size;
}

//设置圆角 单边
+(void)setView:(UIView*)view radio:(CGSize)size roundingCorners:(UIRectCorner)rectCorner{
    //设置只有一半圆角
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:rectCorner cornerRadii:size];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
}

//传入 秒  得到 xx:xx:xx
+ (NSString *)getMMSSFromSS:(NSString *)totalTime{
    
    NSInteger seconds = [totalTime integerValue];
    
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",seconds/3600];
    
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(seconds%3600)/60];
    
    NSString *str_second = [NSString stringWithFormat:@"%02ld",seconds%60];
    
    NSString *format_time = [NSString stringWithFormat:@"%@ : %@ : %@",str_hour,str_minute,str_second];
    
    return format_time;
    
}
//判断颜色是否相等
+ (BOOL) isEqualToColor:(UIColor*)colorA anotherColor:(UIColor*)colorB
{
    if (CGColorEqualToColor(colorA.CGColor, colorB.CGColor)) {
        return YES;
   }else {
           return NO;
   }
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
            borderColor:(UIColor *)borderColor{
    
    [self removeWMZDialogPop];
    CGFloat normalCornerRadius = cornerRadius;
    //只有一个mask层
    CAShapeLayer *mask = [[CAShapeLayer alloc] init];
    mask.frame = self.bounds;
    mask.name = WMZDialogPopMaskName;
    self.layer.mask = mask;
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    
    CGFloat minX = 0, minY = 0, maxX = self.bounds.size.width, maxY = self.bounds.size.height;
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
        [path addLineToPoint:CGPointMake(offset, minY-height)];
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
        [path addLineToPoint:CGPointMake(maxX+height, offset)];
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
        [path addLineToPoint:CGPointMake(offset, maxY+height)];
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
        [path addLineToPoint:CGPointMake(minX-height, offset)];
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
