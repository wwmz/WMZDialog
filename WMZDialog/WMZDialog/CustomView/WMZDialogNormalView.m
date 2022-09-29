//
//  WMZDialogNormalView.m
//  WMZDialog
//
//  Created by wmz on 2021/7/17.
//  Copyright © 2021 wmz. All rights reserved.
//

#import "WMZDialogNormalView.h"
#import "WMZDialog.h"

@interface WMZDialogNormalView()
/// 进度条
@property (nonatomic, strong) UIProgressView *progressView;
/// 线条1
@property (nonatomic, strong) UIView *upLine;
/// 线条2
@property (nonatomic, strong) UIView *downLine;

@end

@implementation WMZDialogNormalView

- (void)mz_setupView{
    if (!self.param) return;
    switch (self.param.wType) {
            
#pragma -mark DialogTypeNornal
        case DialogTypeNornal:{
            CGFloat top = [self addTopTitleView];
            [self addBottomView: top + (top ? self.param.wMainOffsetY : 0)];
        }
            break;
            
#pragma -mark DialogTypeAuto
        case DialogTypeAuto:{
            if (self.param.wShowAnimation == AninatonShowNone)  self.param.wShowAnimation = AninatonShowScaleFade;
            CGFloat scale = 0.8;
            if (DialogStrIsNotEmpty(self.param.wImageName)) {
                self.iconIV.image = [UIImage imageNamed:self.param.wImageName];
                self.iconIV.frame = CGRectMake((self.param.wAutoMaxWidth - self.param.wImageSize.width * scale) / 2, self.param.wMainOffsetY, self.param.wImageSize.width * scale , self.param.wImageSize.height * scale);
                self.iconIV.layer.masksToBounds = YES;
                self.iconIV.layer.cornerRadius = self.param.wImageSize.width * scale / 2;
                [self addSubview:self.iconIV];
            }
            [self addSubview:self.textLabel];
            CGSize size = [WMZDialogUntils sizeForTextView:CGSizeMake(self.param.wAutoMaxWidth - self.param.wMainOffsetX * 2, CGFLOAT_MAX) text:self.param.wMessage font:self.textLabel.font];
            if (DialogStrIsNotEmpty(self.param.wImageName)) size.width = self.param.wAutoMaxWidth - self.param.wMainOffsetX * 2;
            self.textLabel.frame =  CGRectMake(self.param.wMainOffsetX,(DialogStrIsNotEmpty(self.param.wImageName)? CGRectGetMaxY(self.iconIV.frame):0) + (self.textLabel.text.length?self.param.wMainOffsetY : 0), size.width, size.height);
        }
            break;
            
#pragma -mark DialogTypeToast
        case DialogTypeToast:{
            self.textLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:self.textLabel];
            CGSize size = [WMZDialogUntils sizeForTextView:CGSizeMake(self.param.wWidth - 20, CGFLOAT_MAX) text:self.param.wMessage font:self.textLabel.font];
            self.textLabel.frame =  CGRectMake(10 , self.param.wMainOffsetY, self.param.wWidth - 20 , (self.param.wHeight != DialogRealW(400)) ? (self.param.wHeight - self.param.wMainOffsetY * 2) : (size.height + 10));
            CGRect rect = CGRectMake(0, 0, self.param.wWidth, (self.param.wHeight != DialogRealW(400))? self.param.wHeight:(CGRectGetMaxY(self.textLabel.frame) + self.param.wMainOffsetY));
            if (self.param.wToastPosition == DialogToastTop) {
                rect.origin.y = DialogStatusH;
            }else if (self.param.wToastPosition == DialogToastBottom) {
                rect.origin.y = DialogScreenH - CGRectGetMaxY(self.textLabel.frame) - self.param.wMainOffsetY * 2 - DialogSafeBottomHeight;
            }
            self.frame = rect;
        }
            break;
            
#pragma -mark DialogTypeLoading
        case DialogTypeLoading:{
            self.iconIV.frame = CGRectMake((self.param.wWidth - self.param.wLoadingSize.width) / 2,self.param.wMainOffsetY ,self.param.wLoadingSize.width,self.param.wLoadingSize.height);
            [self addSubview:self.iconIV];
            if (self.param.wLoadingType == LoadingStyleWait) {
                loadingAnimation(self.iconIV, self.param.wAnimationDurtion, self.param.wLoadingColor, 4);
            }else if (self.param.wLoadingType == LoadingStyleSystem) {
                UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
                [self addSubview:activity];
                activity.tag = 999;
                activity.frame = self.iconIV.frame;
                [activity startAnimating];
            }else{
                CGFloat imageWH = self.param.wLoadingSize.width ;
                UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, imageWH, imageWH) cornerRadius:imageWH/2];
                CGFloat addHeight = 3.0f;
                CAShapeLayer *lineLayer = [CAShapeLayer layer];
                if (self.param.wLoadingType == LoadingStyleError) {
                    [path moveToPoint:CGPointMake(imageWH / 2 - imageWH / 4, imageWH / 4)];
                    [path addLineToPoint:CGPointMake(imageWH / 2 + imageWH / 4, imageWH * 3/4)];
                    [path moveToPoint:CGPointMake(imageWH / 2 + imageWH / 4, imageWH / 4)];
                    [path addLineToPoint:CGPointMake(imageWH / 2 - imageWH / 4, imageWH * 3/4)];
                }else if (self.param.wLoadingType == LoadingStyleRight) {
                    CGFloat addHeight = 3;
                    [path moveToPoint:CGPointMake((imageWH-imageWH) / 2 + imageWH / 4,addHeight + imageWH / 2)];
                    [path addLineToPoint:CGPointMake(imageWH / 2, imageWH * 3/4)];
                    [path addLineToPoint:CGPointMake(imageWH / 2 + imageWH * 1/3, imageWH * 1/3)];
                }else if (self.param.wLoadingType == LoadingStyleInfo) {
                    [path moveToPoint:CGPointMake(imageWH / 2,imageWH / 4)];
                    [path addLineToPoint:CGPointMake(imageWH / 2,imageWH/4 + addHeight)];
                    [path moveToPoint:CGPointMake(imageWH / 2,imageWH / 4 + 6)];
                    [path addLineToPoint:CGPointMake(imageWH / 2, imageWH * 3/4 )];
                }
                lineLayer.frame = CGRectZero;
                lineLayer.fillColor = [UIColor clearColor].CGColor ;
                lineLayer.strokeColor = self.param.wLoadingColor.CGColor;
                lineLayer.lineWidth = self.param.wLoadingWidth;
                lineLayer.path = path. CGPath ;
                newLoadingAnimation(self.iconIV,lineLayer,self.param.wAnimationDurtion);
             }
            if (DialogStrIsNotEmpty(self.param.wTitle)){
               [self addSubview:self.titleLabel];
               self.titleLabel.frame = CGRectMake(self.param.wMainOffsetX, CGRectGetMaxY(self.iconIV.frame) + self.param.wMainOffsetY, self.param.wWidth-self.param.wMainOffsetX * 2, [WMZDialogUntils sizeForTextView:CGSizeMake(self.param.wWidth-self.param.wMainOffsetX * 2, CGFLOAT_MAX) text:self.param.wTitle font:self.titleLabel.font].height);

            }
            if (self.param.wShowClose) {
                [self addSubview:self.closeBtn];
                self.closeBtn.layer.borderWidth = 0;
                [self.closeBtn setTitle:@"" forState:UIControlStateNormal];
                [self.closeBtn setImage:[UIImage imageWithContentsOfFile:[[WMZDialogUntils getMainBundle] pathForResource:@"dialog_close1" ofType:@"png"]] forState:UIControlStateNormal];
                CGFloat width = DialogRealW(40);
                self.closeBtn.frame = CGRectMake(self.param.wWidth - width - 5 , 5, width, width);
                self.closeBtn.layer.cornerRadius = width/2;
                self.closeBtn.layer.backgroundColor = DialogColor(0x809199).CGColor;
            }
        }
            break;
            
#pragma -mark DialogTypeAdvertisement
        case DialogTypeAdvertisement:{
            self.iconIV.image = [UIImage imageNamed:self.param.wImageName];
            self.iconIV.frame = CGRectMake((self.param.wWidth-self.param.wImageSize.width) / 2, 0, self.param.wImageSize.width, self.param.wImageSize.height);
            self.iconIV.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(advertTapAction:)];
            [self.iconIV addGestureRecognizer:tap];
            [self addSubview:self.iconIV];
            self.closeBtn.frame = CGRectMake((self.param.wWidth-self.param.wMainBtnHeight) / 2, CGRectGetMaxY(self.iconIV.frame)+self.param.wMainOffsetY, self.param.wMainBtnHeight, self.param.wMainBtnHeight);
            [self.closeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.closeBtn.layer.cornerRadius = self.param.wMainBtnHeight / 2;
            [self addSubview:self.closeBtn];
        }
            break;
            
#pragma -mark DialogTypeDown
        case DialogTypeDown:{
            self.iconIV.image = [UIImage imageNamed:self.param.wImageName];
            self.iconIV.frame = CGRectMake((self.param.wWidth-self.param.wImageSize.width) / 2, self.param.wMainOffsetY, self.param.wImageSize.width , self.param.wImageSize.height);
            self.iconIV.layer.masksToBounds = YES;
            self.iconIV.layer.cornerRadius = self.param.wImageSize.width / 2;
            [self addSubview:self.iconIV];
            
            [self addSubview:self.titleLabel];
            self.titleLabel.frame = CGRectMake(self.param.wMainOffsetX, CGRectGetMaxY(self.iconIV.frame)+ (self.param.wTitle?self.param.wMainOffsetY : 0), self.param.wWidth - self.param.wMainOffsetX * 2, [WMZDialogUntils sizeForTextView:CGSizeMake(self.param.wWidth - self.param.wMainOffsetX * 2, CGFLOAT_MAX) text:self.param.wTitle font:self.titleLabel.font].height);
            
            [self addSubview:self.progressView];
            self.progressView.frame = CGRectMake(self.param.wMainOffsetX, CGRectGetMaxY(self.titleLabel.frame) + self.param.wMainOffsetY, self.param.wWidth*0.75, DialogRealW(20));
            [self addSubview:self.textLabel];
            
            self.textLabel.frame = CGRectMake(CGRectGetMaxX(self.progressView.frame)+ self.param.wMainOffsetX, 0, self.param.wWidth * 0.25 - self.param.wMainOffsetX * 3, DialogRealW(30));
            self.textLabel.center = CGPointMake(self.textLabel.center.x, self.progressView.center.y);
            if (self.param.wData) [self mz_changeValue:self.param.wData];
        }
            break;
            
#pragma -mark DialogTypeShare
        case DialogTypeShare:{
            NSArray *dataArr = (NSArray*)self.param.wData;
            if (!DialogIsArray(dataArr)) {
                NSLog(@"Please Input Array"); return;
            }
            
            [self addSubview:self.titleLabel];
            self.titleLabel.frame = CGRectMake(self.param.wMainOffsetX, self.param.wMainOffsetY, self.param.wWidth - self.param.wMainOffsetX * 2, [WMZDialogUntils sizeForTextView:CGSizeMake(self.param.wWidth-self.param.wMainOffsetX*2, CGFLOAT_MAX) text:self.param.wTitle font:self.titleLabel.font].height);
            
            [self addSubview:self.upLine];
            self.upLine.frame = CGRectMake(self.param.wMainOffsetX,  DialogStrIsNotEmpty(self.param.wTitle) ? (CGRectGetMaxY(self.titleLabel.frame) + self.param.wMainOffsetY) : 0, self.param.wWidth - self.param.wMainOffsetX * 2, DialogK1px);
            
            [self addSubview:self.shareView];
            CGFloat height = self.param.wHeight * 2;
            if (dataArr.count <= self.param.wColumnCount) height = self.param.wHeight;
            self.shareView.frame = CGRectMake(0, CGRectGetMaxY(self.upLine.frame)+self.param.wMainOffsetY, self.param.wWidth , height);
            
            @DialogWeakify(self)
            for (int i = 0; i< dataArr.count; i++) {
                NSDictionary *dic = dataArr[i];
                if (![dic isKindOfClass:[NSDictionary class]]) break;
                    WMZDialogShareView *iconView = [[WMZDialogShareView alloc] initWithText:dic[@"name"] image:dic[@"image"]  block:^(NSInteger index,id anyId) {
                       @DialogStrongify(self)
                    [self imageAction: index - 1000 withAny:anyId];
                } tag: i + 1000];
                iconView.titleLB.textColor = DialogDarkOpenColor(UIColor.blackColor, UIColor.whiteColor,self.param.wOpenDark);
                [self.shareView addSubview:iconView];
            }
            if(self.param.wCustomShareView) self.param.wCustomShareView(self.shareView);
            [self addSubview:self.cancelBtn];
            self.cancelBtn.frame = CGRectMake(0, CGRectGetMaxY(self.shareView.frame), self.param.wWidth, self.param.wMainBtnHeight);
            self.cancelBtn.backgroundColor = DialogDarkOpenColor(DialogColor(0xf7f7f7), WMZDialogManage.shareInstance.darkColorInfo[DialogDarkC3],self.param.wOpenDark);
            springShowAnimation(self.shareView, self.param.wAnimationDurtion , [self.shareView subviews], self.param.wColumnCount, self.param.wRowCount, 0, 0, 0, 0, YES,  ^{});
        }
            break;
            
#pragma -mark DialogTypeNaviMenu
        case DialogTypeNaviMenu:{
            NSArray *dataArr = (NSArray*)self.param.wData;
            if (!DialogIsArray(dataArr)) {
                NSLog(@"Please Input Array"); return;
            }
            
            self.closeBtn.layer.borderWidth = 0;
            [self addSubview:self.closeBtn];
            self.closeBtn.frame = CGRectMake(self.param.wWidth - 60, DialogStatusH, 60, self.param.wMainBtnHeight);
            [self addSubview:self.shareView];
            CGFloat height = self.param.wHeight * 2;
            if (dataArr.count <= self.param.wColumnCount) height = self.param.wHeight;
            self.shareView.frame = CGRectMake(0, CGRectGetMaxY(self.closeBtn.frame)+self.param.wMainOffsetY, self.param.wWidth , height);
            @DialogWeakify(self)
            for (int i = 0; i<[dataArr count]; i++) {
                NSDictionary *dic = dataArr[i];
                if (![dic isKindOfClass:[NSDictionary class]]) break;
                WMZDialogShareView *iconView = [[WMZDialogShareView alloc] initWithText:dic[@"name"] image:dic[@"image"]  block:^(NSInteger index,id anyId) {
                    @DialogStrongify(self)
                    [self imageAction:index - 1000 withAny:anyId];
                } tag: i + 1000];
                iconView.titleLB.textColor = DialogDarkOpenColor(UIColor.blackColor, UIColor.whiteColor,self.param.wOpenDark);
                [self.shareView addSubview:iconView];
            }
            if(self.param.wCustomShareView) self.param.wCustomShareView(self.shareView);
            springShowAnimation(self.shareView, self.param.wAnimationDurtion , [self.shareView subviews], self.param.wColumnCount, self.param.wRowCount, 0, 0, 0, 0, YES,  ^{});
            self.frame = CGRectMake(0, 0, self.param.wWidth, CGRectGetMaxY(self.shareView.frame));
        }
            break;
            
#pragma -mark DialogTypeTabbarMenu
        case DialogTypeTabbarMenu:{
            NSArray *dataArr = (NSArray*)self.param.wData;
            if (!DialogIsArray(dataArr)) {
                NSLog(@"Please Input Array"); return;
            }
            self.shareView.backgroundColor = UIColor.clearColor;
            self.backgroundColor = [UIColor clearColor];
            self.closeBtn.backgroundColor = [UIColor clearColor];
            [self addSubview:self.shareView];
            self.shareView.frame = CGRectMake(0, 10 , self.param.wWidth ,  self.param.wHeight);
            @DialogWeakify(self)
            for (int i = 0; i < [dataArr count]; i++) {
                NSDictionary *dic = dataArr[i];
                if (![dic isKindOfClass:[NSDictionary class]]) break;
                WMZDialogShareView *iconView = [[WMZDialogShareView alloc] initWithText:dic[@"name"] image:dic[@"image"]  block:^(NSInteger index,id anyId) {
                    @DialogStrongify(self)
                    [self imageAction:index - 1000 withAny:anyId];
                } tag:i + 1000];
                iconView.titleLB.textColor = DialogDarkOpenColor(UIColor.blackColor, UIColor.whiteColor,self.param.wOpenDark);
                [self.shareView addSubview:iconView];
            }
            if(self.param.wCustomShareView) self.param.wCustomShareView(self.shareView);
            self.closeBtn.layer.borderWidth = 0;
            [self addSubview:self.closeBtn];
            self.closeBtn.frame = CGRectMake((self.param.wWidth - 60) / 2, CGRectGetMaxY(self.shareView.frame) + 100, 60, self.param.wMainBtnHeight);
            springShowAnimation(self.shareView, self.param.wAnimationDurtion , [self.shareView subviews], self.param.wColumnCount, self.param.wRowCount, 0, 0, 0, 0, YES,  ^{});
        }
            break;
            
        default:
            break;
    }

}

- (CGRect)mz_setupRect{
    NSDictionary *rectInfo = @{
        @(DialogTypeNornal):[NSValue valueWithCGRect:CGRectMake(0, 0, self.param.wWidth, CGRectGetMaxY(self.bottomView.frame))],
        @(DialogTypeAuto):[NSValue valueWithCGRect: CGRectMake(0, 0,  (self.param.wImageName&&self.param.wImageName.length)?self.param.wWidth:(self.textLabel.frame.size.width+self.param.wMainOffsetX*2), CGRectGetMaxY(self.textLabel.frame)+self.param.wMainOffsetY)],
        @(DialogTypeLoading):[NSValue valueWithCGRect:CGRectMake(0,0,self.param.wWidth,CGRectGetMaxY(DialogStrIsNotEmpty(self.param.wTitle) ? self.titleLabel.frame : self.iconIV.frame) + self.param.wMainOffsetY)],
        @(DialogTypeAdvertisement):[NSValue valueWithCGRect:CGRectMake(0, 0, self.param.wWidth, CGRectGetMaxY(self.closeBtn.frame)+self.param.wMainOffsetY)],
        @(DialogTypeDown):[NSValue valueWithCGRect:CGRectMake(0, 0, self.param.wWidth, CGRectGetMaxY(self.textLabel.frame)+self.param.wMainOffsetY)],
        @(DialogTypeShare):[NSValue valueWithCGRect:CGRectMake(0,0,self.param.wWidth, CGRectGetMaxY(self.cancelBtn.frame))],
        @(DialogTypeTabbarMenu):[NSValue valueWithCGRect:CGRectMake(0,0,self.param.wWidth, CGRectGetMaxY(self.closeBtn.frame))],
    };
    NSValue *value = rectInfo[@(self.param.wType)];
    if (value) {
        self.frame = value.CGRectValue;
        return value.CGRectValue;
    }
    return CGRectZero;
}

- (CGFloat)mz_autoDisappeal{
    if (self.param.wType == DialogTypeAuto ||
        self.param.wType == DialogTypeToast ||
        self.param.wType == DialogTypeLoading) return self.param.wDisappelSecond;
    
    return -1;
}

- (BOOL)mz_changeValue:(id)value{
    if ([[WMZDialogManage.shareInstance currentDialog:self] isClose]) return NO;
    if (self.param.wType == DialogTypeDown) {
        CGFloat num = [value floatValue];
        self.progressView.progress = num;
        NSMutableString *string = [NSMutableString stringWithFormat:@"%@", [NSString stringWithFormat:@"%.0f",num*100]];
        [string appendString:@"%"];
        self.textLabel.text = string;
        if (num * 100 >= 100) {
            if (self.param.wEventFinish) self.param.wEventFinish(@"下载完成",value, self.param.wType);
        }
        return YES;
    }
    return NO;
}

- (UIRectCorner)mz_setupCorner{
    switch (self.param.wType) {
        case DialogTypeShare:
        case DialogTypeTabbarMenu:return UIRectCornerTopLeft |UIRectCornerTopRight;
        default:return UIRectCornerAllCorners;
    }
}

- (void)mz_changeFrame:(NSValue *)value{
    if (self.param.wType == DialogTypeToast) {
        self.center = CGPointMake(self.superview.center.x, self.center.y);
    }
}

/// 广告点击
- (void)advertTapAction:(UITapGestureRecognizer*)ta{
    if (self.param.wEventFinish) {
        self.param.wEventFinish(ta.view,nil, self.param.wType);
    }
}

/// 分页点击
- (void)imageAction:(NSInteger)tag withAny:(id)any{
    NSInteger section = tag / (self.param.wColumnCount * self.param.wRowCount) ;
    NSInteger row = tag%(self.param.wColumnCount * self.param.wRowCount) ;
    @DialogWeakify(self)
    [[WMZDialogManage.shareInstance currentDialog:self] closeView:^{
        @DialogStrongify(self)
        if (self.param.wEventFinish)
            self.param.wEventFinish(any,nil , self.param.wType);
        if (self.param.wEventMenuClick)
            self.param.wEventMenuClick(any, row, section);
    }];
}

/// lazy
- (UIProgressView *)progressView{
    if (!_progressView) {
        UIProgressView * progressView = UIProgressView.new;
        progressView.progressTintColor = self.param.wProgressTintColor;
        progressView.trackTintColor = self.param.wTrackTintColor;
        _progressView = progressView;
    }
    return _progressView;
}

- (UIView *)upLine{
    if (!_upLine) {
        UIView *upLine = [UIView new];
        upLine.alpha = self.param.wLineAlpha;
        upLine.backgroundColor = self.param.wLineColor;
        _upLine = upLine;
    }
    return _upLine;
}

- (UIView *)downLine{
    if (!_downLine) {
        UIView *upLine = [UIView new];
        upLine.alpha = self.param.wLineAlpha;
        upLine.backgroundColor = self.param.wLineColor;
        _downLine = upLine;
    }
    return _downLine;
}

@end
