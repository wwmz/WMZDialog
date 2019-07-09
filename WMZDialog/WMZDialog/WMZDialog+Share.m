
//
//  WMZDialog+Share.m
//  WMZDialog
//
//  Created by wmz on 2019/6/10.
//  Copyright © 2019年 wmz. All rights reserved.
//

#import "WMZDialog+Share.h"
#define percentImage 0.5
@implementation WMZDialog (Share)
- (UIView*)shareAction{

    [self.mainView addSubview:self.titleLabel];
    self.titleLabel.frame = CGRectMake(self.wMainOffsetX, self.wMainOffsetY, self.wWidth-self.wMainOffsetX*2, [WMZDialogTool heightForTextView:CGSizeMake(self.wWidth-self.wMainOffsetX*2, CGFLOAT_MAX) WithText:self.titleLabel.text WithFont:self.titleLabel.font.pointSize]);

    
    UIView *upLine = [UIView new];
    [self.mainView addSubview:upLine];
    upLine.alpha = self.wLineAlpha;
    upLine.backgroundColor = self.wLineColor;
    upLine.frame = CGRectMake(self.wMainOffsetX, CGRectGetMaxY(self.titleLabel.frame)+self.wMainOffsetY, self.wWidth-self.wMainOffsetX*2, DialogK1px);
    

    UIScrollView *shareView = [UIScrollView new];
    shareView.showsVerticalScrollIndicator = NO;
    shareView.showsHorizontalScrollIndicator = NO;

    [self.mainView addSubview:shareView];
    CGFloat height =  self.wHeight;
    shareView.frame = CGRectMake(0, CGRectGetMaxY(upLine.frame)+self.wMainOffsetY, self.wWidth , height);

    if (self.wData&&([self.wData isKindOfClass:[NSArray class]]||[self.wData isKindOfClass:[NSMutableArray class]])) {
        CGFloat sonWidth = self.wWidth/[self.wData count];
        if ([self.wData count]>5) {
            sonWidth = self.wWidth/5;
        }
        UIView *tempView = nil;
        for (int i = 0; i<[self.wData count]; i++) {
            NSDictionary *dic = self.wData[i];
            if (![dic isKindOfClass:[NSDictionary class]]) break;
            
            UIView *iconView = nil;
            if (!tempView) {
                iconView =  [self shareListIconWithText:dic[@"name"] WithImage:dic[@"image"] withFrame:CGRectMake(0, 0, sonWidth, height) withTag:i+1000];
            }else{
                iconView =  [self shareListIconWithText:dic[@"name"] WithImage:dic[@"image"] withFrame:CGRectMake(CGRectGetMaxX(tempView.frame), 0, sonWidth, height) withTag:i+1000];
            }
            tempView = iconView;
            [shareView addSubview:iconView];
        }
        shareView.contentSize = CGSizeMake(CGRectGetMaxX(tempView.frame), shareView.frame.size.height);
        
    }
    
    UIView *downLine = [UIView new];
    [self.mainView addSubview:downLine];
    downLine.alpha = self.wLineAlpha;
    downLine.backgroundColor = DialogColor(0xeeeeee);
    downLine.frame = CGRectMake(0, CGRectGetMaxY(shareView.frame)+self.wMainOffsetY, self.wWidth, self.wMainOffsetY*0.8);
    
    [self.mainView addSubview:self.cancelBtn];
    self.cancelBtn.frame = CGRectMake(0, CGRectGetMaxY(downLine.frame), self.wWidth, self.wMainBtnHeight*1.5);
    
    
    [self reSetMainViewFrame:CGRectMake(0,0,self.wWidth, CGRectGetMaxY(self.cancelBtn.frame))];
    //设置只有一半圆角
    [WMZDialogTool setView:self.mainView Radii:CGSizeMake(self.wMainRadius,self.wMainRadius) RoundingCorners:UIRectCornerTopLeft |UIRectCornerTopRight];
    return self.mainView;
}


//分享子视图
- (UIView*)shareListIconWithText:(NSString*)text WithImage:(NSString*)image withFrame:(CGRect)frame withTag:(NSInteger)tag{
    UIView *backView = [UIView new];
    backView.frame = frame;
    backView.userInteractionEnabled = YES;
    backView.tag = tag;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageAction:)];
    [backView addGestureRecognizer:tap];

    UIImageView *imageView = [UIImageView new];
    imageView.frame = CGRectMake((frame.size.width-frame.size.height*percentImage)/2,self.wMainOffsetX, frame.size.height*percentImage, frame.size.height*percentImage);
    imageView.image = [UIImage imageNamed:image];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.layer.masksToBounds = YES;
    imageView.layer.cornerRadius = (frame.size.height*0.5)/2;
    [backView addSubview:imageView];

    UILabel *la = [UILabel new];
    la.tag = 111;
    la.textAlignment = NSTextAlignmentCenter;
    la.font = [UIFont systemFontOfSize:self.wMessageFont];
    la.frame = CGRectMake(self.wMainOffsetX*0.5, CGRectGetMaxY(imageView.frame)+self.wMainOffsetX, frame.size.width-self.wMainOffsetX, frame.size.height*(1-percentImage)-self.wMainOffsetX*2);
    la.text = text;
    [backView addSubview:la];
    
    return backView;
}

- (void)imageAction:(UITapGestureRecognizer*)sender{
    [self closeView];
    if (self.wEventFinish) {
        UIView *view = (UIView*)sender.view;
        UILabel *la = [view viewWithTag:111];
        self.wEventFinish(la.text,nil,self.wType);
    }
    
}
@end
