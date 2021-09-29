//
//  CustomView.m
//  WMZDialog
//
//  Created by wmz on 2021/4/12.
//  Copyright © 2021 wmz. All rights reserved.
//

#import "CustomView.h"
#import "WMZDialogMacro.h"
@implementation CustomView

- (instancetype)initWithFrame:(CGRect)frame superView:(UIView*)superView{
    if (self = [super initWithFrame:frame]) {
        [superView addSubview:self];
        UIImageView *image = [UIImageView new];
        image.image = [UIImage imageNamed:@"healthy"];
        [self addSubview:image];
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(80).priorityHigh();
            make.left.right.top.mas_equalTo(0);
        }];
              
        UILabel *la = [UILabel new];
        la.font = [UIFont systemFontOfSize:15.0f];
        la.text = @"为呵护未成年人健康成长,优酷特别推出青少年模式,该模式下部分功能无法正常使用,请监护人主动选择，并设置监护密码";
        la.numberOfLines = 0;
        [self addSubview:la];
        [la mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.top.equalTo(image.mas_bottom);
        }];
              
        UIButton *enter = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:enter];
        enter.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [enter setTitle:@"进入青少年模式 >" forState:UIControlStateNormal];
        [enter setTitleColor:DialogColor(0x108ee9) forState:UIControlStateNormal];
        [enter mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(44).priorityHigh();
            make.top.equalTo(la.mas_bottom);
        }];
              
          UIButton *know = [UIButton buttonWithType:UIButtonTypeCustom];
          [self addSubview:know];
          know.titleLabel.font = [UIFont systemFontOfSize:14.0f];
          [know setTitle:@"我知道了" forState:UIControlStateNormal];
          [know setTitleColor:DialogDarkColor(DialogColor(0x3333333), DialogColor(0xffffff)) forState:UIControlStateNormal];
          [know mas_makeConstraints:^(MASConstraintMaker *make) {
              make.left.right.mas_equalTo(0);
              make.height.mas_equalTo(44).priorityHigh();
              make.top.equalTo(enter.mas_bottom);
          }];
    }
    return self;
}

@end
