

//
//  WMZCustomEditView.m
//  WMZDialog
//
//  Created by wmz on 2021/7/26.
//  Copyright © 2021 wmz. All rights reserved.
//

#import "WMZDialogEditView.h"
#import "WMZDialog.h"

@interface WMZDialogEditView()<UITextFieldDelegate,UITextViewDelegate>
/// 输入框
@property (nonatomic, strong) UITextView *writeView;
/// 密码视图
@property (nonatomic, strong) UIView *passView;
/// 选择支付方式视图
@property (nonatomic, strong) UIView *selectPayView;
/// 输入密码
@property (nonatomic, strong) UITextField *textField;
/// 能否继续输入
@property (nonatomic, assign, getter = isCanInput) BOOL canInput;

@end

@implementation WMZDialogEditView

- (void)mz_setupView{
    if (!self.param) return;
    if (self.param.wType == DialogTypePay) {
        self.closeBtn.layer.borderWidth = 0;
        self.closeBtn.frame = CGRectMake(self.param.wMainOffsetX, self.param.wMainOffsetY, self.param.wMainOffsetX*3, DialogRealW(50));
        [self addSubview:self.closeBtn];

        [self addSubview:self.titleLabel];
        self.titleLabel.frame = CGRectMake(DialogRealW(80), self.param.wMainOffsetY, self.param.wWidth-DialogRealW(160), DialogRealW(50));

        [self addSubview:self.textLabel];
        self.textLabel.frame = CGRectMake(0, CGRectGetMaxY(self.titleLabel.frame)+self.param.wMainOffsetY, self.param.wWidth, DialogRealW(60));
        self.textLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:self.param.wMessageFont*2];
        
        UIView *downLine = [UIView new];
        [self addSubview:downLine];
        downLine.alpha = self.param.wLineAlpha;
        downLine.backgroundColor = self.param.wLineColor;
        downLine.frame = CGRectMake(self.param.wMainOffsetX, CGRectGetMaxY(self.textLabel.frame)+self.param.wMainOffsetY, self.param.wWidth-self.param.wMainOffsetX*2, DialogK1px);

        [self selectPayView:CGRectGetMaxY(downLine.frame)+self.param.wMainOffsetY/2 Height:DialogRealW(80)];
        self.selectPayView.userInteractionEnabled = YES;
        [self addSubview:self.selectPayView];
        
        self.textField.frame = CGRectMake(self.param.wMainOffsetX, CGRectGetMaxY(self.selectPayView.frame)+self.param.wMainOffsetY/2, self.param.wWidth-self.param.wMainOffsetX*2, 0);
        [self addSubview:self.textField];
        [self sendSubviewToBack:self.textField];
        [self.textField becomeFirstResponder];
        
        self.passView.backgroundColor = self.param.wMainBackColor;
        self.passView.frame = CGRectMake(self.param.wMainOffsetX, CGRectGetMaxY(self.selectPayView.frame)+self.param.wMainOffsetY/2, self.param.wWidth-self.param.wMainOffsetX*2, self.param.wMainBtnHeight);
        [self addSubview:self.passView];

        UILabel *tempLabel = nil;
        for (int i = 0; i<self.param.wPayNum; i++) {
            UILabel *password = [UILabel new];
            password.tag = 100+i;
            password.textColor = self.param.wMessageColor;
            password.textAlignment = NSTextAlignmentCenter;
            password.text = @"";
            UIColor *color = DialogDarkOpenColor(DialogColor(0xededed),WMZDialogManage.shareInstance.darkColorInfo[DialogDarkC2],self.param.wOpenDark);
            password.layer.backgroundColor = color.CGColor;
            password.layer.cornerRadius = 5;
            [password setFont:[UIFont fontWithName:@"Helvetica-Bold" size:self.param.wTitleFont*1.5]];
            if (!tempLabel) {
                password.frame = CGRectMake(0, 0, self.passView.frame.size.height, self.passView.frame.size.height);
            }else{
                password.frame = CGRectMake(CGRectGetMaxX(tempLabel.frame) + 5, 0,self.passView.frame.size.height, self.passView.frame.size.height);
            }
            tempLabel = password;
            [self.passView addSubview:password];
            if (i == self.param.wPayNum - 1) {
                CGRect rect = self.passView.frame;
                CGFloat maxWidth = CGRectGetMaxX(password.frame);
                if (maxWidth>(self.param.wWidth-self.param.wMainOffsetX*2)) {
                    maxWidth = self.param.wWidth-self.param.wMainOffsetX*2;
                }
                rect.origin.x = (rect.size.width-maxWidth+self.param.wMainOffsetX*2)/2;
                rect.size.width = maxWidth;
                self.passView.frame = rect;
            }
        }
    }else if (self.param.wType == DialogTypeWrite){
        self.canInput = YES;
        if (!self.param.wBottomLineColor) self.param.wBottomLineColor = self.param.wLineColor;
        if (self.param.wWirteTextMaxLine <= 0) self.param.wWirteTextMaxLine = 7;
        CGFloat top = [self addTopTitleView];
        
        UIView *lastView = nil;
        if (self.param.wWirteTextMaxLine == 1) {
            self.textField = UITextField.new;
            lastView = self.textField;
            [self addSubview:self.textField];
            self.textField.placeholder = self.param.wPlaceholder;
            NSMutableAttributedString *mstr = [[NSMutableAttributedString alloc]initWithString:self.param.wPlaceholder];
            [mstr addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:[mstr.string rangeOfString:mstr.string]];
            [mstr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:self.param.wMessageFont] range:[mstr.string rangeOfString:mstr.string]];
            self.textField.attributedPlaceholder = mstr;
            self.textField.delegate = self;
            self.textField.layer.borderWidth = 1.0f;
            self.textField.layer.cornerRadius = 5;
            self.textField.textColor = self.param.wInputTextColor;
            self.textField.leftViewMode = UITextFieldViewModeAlways ;
            self.textField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, 5)];
            self.textField.returnKeyType = UIReturnKeyDone;
            self.textField.layer.backgroundColor = UIColor.whiteColor.CGColor;
            [self.textField becomeFirstResponder];
            self.textField.font = [UIFont systemFontOfSize:self.param.wMessageFont];
            self.textField.layer.borderColor = self.param.wBottomLineColor.CGColor;;
            self.textField.keyboardType = self.param.wWirteKeyBoardType;
            self.textField.frame = CGRectMake(self.param.wMainOffsetX,top + self.param.wMainOffsetY, self.param.wWidth - self.param.wMainOffsetX * 2, self.textField.font.lineHeight + 20);
            self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
            if (self.param.wWriteDefaultText) self.textField.text = self.param.wWriteDefaultText;
        }else{
            if (!self.param.wInputAreaHeight) self.param.wInputAreaHeight = self.writeView.font.lineHeight + 20;
            lastView = self.writeView;
            [self addSubview:self.writeView];
            self.writeView.frame = CGRectMake(self.param.wMainOffsetX, top + self.param.wMainOffsetY, self.param.wWidth - self.param.wMainOffsetX * 2, self.param.wInputAreaHeight);
            if (self.param.wWriteDefaultText) self.writeView.text = self.param.wWriteDefaultText;
            
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(3, 4, self.param.wWidth - self.param.wMainOffsetX * 2 - 6, [WMZDialogUntils sizeForTextView:CGSizeMake(self.param.wWidth - self.param.wMainOffsetX * 2, CGFLOAT_MAX) text:@"占位" font:self.writeView.font].height + 10)];
            label.enabled = NO;
            label.tag = 999;
            label.text = self.param.wPlaceholder;
            label.font =  [UIFont systemFontOfSize:self.param.wMessageFont];
            label.textColor = [UIColor lightGrayColor];
            [self.writeView addSubview:label];
            label.hidden = !DialogStrIsNotEmpty(self.param.wPlaceholder);
            if (DialogStrIsNotEmpty(self.param.wWriteDefaultText)) {
                label.hidden = YES;
            }
        }
        lastView.backgroundColor = self.param.wInputBackGroundColor;
        [self addBottomView:CGRectGetMaxY(lastView.frame) + self.param.wMainOffsetY];
        [self.OKBtn removeTarget:self action:NSSelectorFromString(@"confirmAction:") forControlEvents:UIControlEventTouchUpInside];
        [self.OKBtn addTarget:self action:@selector(writeOKAction:) forControlEvents:UIControlEventTouchUpInside];
        if (self.param.wCustomTextView) self.param.wCustomTextView(self.writeView);
    }
}

- (void)selectPayView:(CGFloat)maxY Height:(CGFloat)height{
    self.selectPayView.frame = CGRectMake(self.param.wMainOffsetX, maxY , self.param.wWidth - self.param.wMainOffsetX*2, height);
    CGFloat maxWidth = self.selectPayView.frame.size.width;
    UILabel *la = [UILabel new];
    la.tag = 111;
    la.font = [UIFont systemFontOfSize:self.param.wTitleFont - 2];
    la.frame = CGRectMake(0, 0, maxWidth/2, height);
    la.text = @"支付方式";
    [self.selectPayView addSubview:la];
    
    UIButton *selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    selectBtn.tag = 222;
    selectBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [selectBtn addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    [selectBtn setTitle:self.param.wDefaultSelectPayStr forState:UIControlStateNormal];
    selectBtn.titleLabel.font = [UIFont systemFontOfSize:self.param.wTitleFont-2];
    [selectBtn setTitleColor:self.param.wCancelColor forState:UIControlStateNormal];
    selectBtn.backgroundColor = self.param.wMainBackColor;
    selectBtn.frame = CGRectMake(maxWidth/2 ,0,  maxWidth/2- DialogRealW(30), height);
    [self.selectPayView addSubview:selectBtn];

    UIButton *goBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [goBtn addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    [goBtn setTitle:@">" forState:UIControlStateNormal];
    goBtn.titleLabel.font = [UIFont systemFontOfSize:self.param.wTitleFont-2];
    [goBtn setTitleColor:self.param.wCancelColor forState:UIControlStateNormal];
    goBtn.backgroundColor = self.param.wMainBackColor;
    goBtn.frame = CGRectMake(CGRectGetMaxX(selectBtn.frame), 0, DialogRealW(30), height);
    [self.selectPayView addSubview:goBtn];
}

- (CGRect)mz_setupRect{
    CGRect rect = CGRectZero;
    if (self.param.wType == DialogTypePay) {
        rect =  CGRectMake(0, 0, self.param.wWidth, CGRectGetMaxY(self.passView.frame) + self.param.wMainOffsetY);
    }else if (self.param.wType == DialogTypeWrite){
        rect =  CGRectMake(0, 0, self.param.wWidth, CGRectGetMaxY(self.bottomView.frame));
    }
    self.frame = rect;
    return rect;
}

- (void)textViewDidChange:(UITextView *)textView{
    [[textView viewWithTag:999] setHidden:[textView.text length] != 0];
    CGRect frame = textView.frame;
    if (self.param.wWirteTextMaxNum != - 1 &&
        textView.text.length > self.param.wWirteTextMaxNum){
        textView.text = [textView.text substringToIndex:textView.text.length - 1];
        self.canInput = NO;
    }
    NSUInteger numLines = (textView.contentSize.height - 20)/textView.font.lineHeight;
    frame.size.height = textView.contentSize.height;
    CGFloat changeHeight = frame.size.height;
    CGFloat maxHeight = DialogScreenH - [[WMZDialogManage.shareInstance currentDialog:self] keyBoardHeight] - self.param.wKeyBoardMarginY - self.bottomView.frame.size.height - self.param.wMainOffsetY * 2 - DialogStatusH ;
    
    if (self.param.wWirteTextMaxLine && numLines > self.param.wWirteTextMaxLine)
        changeHeight = self.writeView.font.lineHeight * self.param.wWirteTextMaxLine + 20;
    
    frame.size.height = MIN(MAX(self.param.wInputAreaHeight, changeHeight), maxHeight);
    [UIView animateWithDuration:0.3 animations:^{
        textView.frame = frame;
        CGRect bottomRect = self.bottomView.frame;
        bottomRect.origin.y = CGRectGetMaxY(textView.frame) + self.param.wMainOffsetY;
        self.bottomView.frame = bottomRect;
        CGRect rect = self.frame;
        rect.size.height = CGRectGetMaxY(self.bottomView.frame);
        rect.origin.y = DialogScreenH - ([[WMZDialogManage.shareInstance currentDialog:self] keyBoardHeight] + rect.size.height + 0.5 + self.param.wKeyBoardMarginY);
        self.frame = rect;
    } completion:nil];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@""])  self.canInput = YES;
    if (!self.isCanInput) {
        if (self.param.wRegular &&
            [self.param.wRegular isKindOfClass:NSDictionary.class] &&
            self.param.wRegular[DialogRegularMaxTip]) {
            NSString *maxNumTip = self.param.wRegular[DialogRegularMaxTip];
            AlertAuto(maxNumTip)
        }
    }
    return self.isCanInput;
}

/// 确定的点击事件
- (void)writeOKAction:(UIButton*)btn{
    NSString *text = (self.param.wWirteTextMaxLine == 1) ? self.textField.text : self.writeView.text;
    if (self.param.wRegular && [self.param.wRegular isKindOfClass:NSDictionary.class]) {
        NSString *regular = self.param.wRegular[DialogRegulars];
        NSString *regulerTip = self.param.wRegular[DialogRegularTip];
        if (regular) {
            NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regular];
            BOOL isMatch = [pred evaluateWithObject:text];
            if (!isMatch) {
                AlertAuto(regulerTip?:@"输入格式有误")
                return;
            }
        }
    }
    (self.param.wWirteTextMaxLine == 1) ? [self.textField resignFirstResponder] : [self.writeView resignFirstResponder];
    @DialogWeakify(self)
    [[WMZDialogManage.shareInstance currentDialog:self] closeView:^{
        @DialogStrongify(self)
        if (self.param.wEventOKFinish)
            self.param.wEventOKFinish(text, btn);
    }];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (self.param.wType == DialogTypeWrite){
        if ((self.param.wWirteTextMaxNum != - 1)) {
            BOOL result = ([NSString stringWithFormat:@"%@%@",textField.text,string].length <= self.param.wWirteTextMaxNum);
            if (!result) {
                if (self.param.wRegular &&
                    [self.param.wRegular isKindOfClass:NSDictionary.class] &&
                    self.param.wRegular[DialogRegularMaxTip]) {
                    NSString *maxNumTip = self.param.wRegular[DialogRegularMaxTip];
                    AlertAuto(maxNumTip)
                }
            }
            return  result;
        }
        return YES;
    }
    return ([NSString stringWithFormat:@"%@%@",textField.text,string].length <= self.param.wPayNum);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (self.param.wType == DialogTypeWrite) [self writeOKAction:self.OKBtn];
    return YES;
}

- (void)textField1TextChange:(UITextField *)textField{
    @DialogWeakify(self)
    for (int i = 0; i < [self.passView subviews].count; i++) {
        UILabel *la = [self.passView subviews][i];
        la.text = @"";
    }
    for (int i = 0; i < textField.text.length; i++) {
        UILabel *la = [self.passView viewWithTag:100+i];
        la.text = @"●";
    }
    if (textField.text.length == self.param.wPayNum) {
        [self.textField resignFirstResponder];
        [[WMZDialogManage.shareInstance currentDialog:self]  closeView:^{
            @DialogStrongify(self)
            if (self.param.wEventFinish) {
                self.param.wEventFinish(textField.text,nil,self.param.wType);
            }
        }];
    }
}

- (void)selectAction:(UIButton*)sender{
    if (!self.param.wCanSelectPay) return;
    [self.textField resignFirstResponder];
    @DialogWeakify(self)
    Dialog()
    .wEventFinishSet(^(id anyID,NSIndexPath *path,DialogType type) {
        @DialogStrongify(self)
        if (anyID) {
           UIButton *selectBtn = [self.selectPayView viewWithTag:222];
           [selectBtn setTitle:anyID forState:UIControlStateNormal];
        }
        [self.textField becomeFirstResponder];
    })
    .wLevelSet(DialogLevelHigh)
    .wDataSet(self.param.wSonData)
    .wTypeSet(DialogTypeSelect)
    .wStart();
}

- (UITextField *)textField{
    if (!_textField) {
        _textField = UITextField.new;
        _textField.keyboardType = UIKeyboardTypeNumberPad;
        [_textField addTarget:self action:@selector(textField1TextChange:) forControlEvents:UIControlEventEditingChanged];
        _textField.delegate = self;
    }
    return _textField;
}

- (UIView *)passView{
    if (!_passView) {
        _passView = UIView.new;
    }
    return _passView;
}

- (UIView *)selectPayView{
    if (!_selectPayView) {
        _selectPayView = UIView.new;
    }
    return _selectPayView;
}

- (UITextView *)writeView{
    if (!_writeView) {
        _writeView = UITextView.new;
        _writeView.delegate = self;
        _writeView.layer.borderWidth = 1.0f;
        _writeView.layer.cornerRadius = 5;
        _writeView.textColor = self.param.wInputTextColor;
        _writeView.keyboardType = self.param.wWirteKeyBoardType;
        _writeView.returnKeyType = UIReturnKeyDefault;
        _writeView.layer.masksToBounds = YES;
        [_writeView becomeFirstResponder];
        _writeView.font = [UIFont systemFontOfSize:self.param.wMessageFont];
        _writeView.layer.borderColor = self.param.wBottomLineColor.CGColor;;
        _writeView.textContainerInset = UIEdgeInsetsMake(10,0, 10, 0);
    }
    return _writeView;
}

@end
