//
//  DemoTwoView.m
//  WMZDialog
//
//  Created by wmz on 2021/9/28.
//  Copyright © 2021 wmz. All rights reserved.
//

#import "DemoTwoView.h"
#import "Masonry.h"
@interface DemoTwoView()
@property (nonatomic, strong) UITextField *textField;
@end
@implementation DemoTwoView

/// 常规布局
- (void)mz_setupView{
    if (!self.param) return;
    [self addSubview:self.titleLabel];
    
    self.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    self.textField.layer.backgroundColor = DialogDarkColor( DialogColor(0xeeeeee), DialogColor(0x363536)) .CGColor;
    self.textField.layer.cornerRadius = 3;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.centerX.mas_equalTo(0);
    }];
    
    [self addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(20);
        make.centerX.mas_equalTo(0);
        make.width.equalTo(self).multipliedBy(0.85);
        make.height.mas_equalTo(32);
    }];
    
    [self addSubview:self.textLabel];
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textField.mas_bottom).offset(15);
        make.centerX.equalTo(self.titleLabel);
    }];
    
    [self.textField setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    
    [self layoutIfNeeded];
    [self.textField layoutIfNeeded];
    [self addBottomView:CGRectGetMaxY(self.textLabel.frame) + 15];
    [self.textField becomeFirstResponder];
}

- (CGRect)mz_setupRect{
    return CGRectMake(0, 0, self.param.wWidth, CGRectGetMaxY(self.bottomView.frame));
}

- (UITextField *)textField{
    if (!_textField) {
        _textField = UITextField.new;
        _textField.keyboardType = UIKeyboardTypeNumberPad;
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _textField;
}

@end
