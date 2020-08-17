//
//  WMZDialog+Pay.m
//  WMZDialog
//
//  Created by wmz on 2019/6/6.
//  Copyright © 2019年 wmz. All rights reserved.
//

#import "WMZDialog+Pay.h"
static NSString *passViewKey = @"passView"; //passView的key
static NSString *selectPayViewKey = @"selectPayView"; //selectPayView的key
@interface WMZDialog ()<UITextFieldDelegate>
@property (nonatomic, retain) UIView *passView;
@property (nonatomic, retain) UIView *selectPayView;
@end
@implementation WMZDialog (Pay)
- (UIView *)payAction{


    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setTitle:@"X" forState:UIControlStateNormal];
    [closeBtn setTitleColor:self.wCancelColor forState:UIControlStateNormal];
    closeBtn.backgroundColor = self.wMainBackColor;
    closeBtn.frame = CGRectMake(self.wMainOffsetX, self.wMainOffsetY, self.wMainOffsetX*3, Dialog_GetWNum(50));
    [closeBtn addTarget:self action:@selector(closeBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.mainView addSubview:closeBtn];

    self.titleLabel.text = self.wTitle;
    [self.mainView addSubview:self.titleLabel];
    self.titleLabel.frame = CGRectMake(Dialog_GetWNum(80), self.wMainOffsetY, self.wWidth-Dialog_GetWNum(160), Dialog_GetWNum(50));



    [self.mainView addSubview:self.textLabel];
    self.textLabel.text = self.wMessage;
    self.textLabel.frame = CGRectMake(0, CGRectGetMaxY(self.titleLabel.frame)+self.wMainOffsetY, self.wWidth, Dialog_GetWNum(60));
    self.textLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:self.wMessageFont*2];
    
    
    UIView *downLine = [UIView new];
    [self.mainView addSubview:downLine];
    downLine.alpha = self.wLineAlpha;
    downLine.backgroundColor = self.wLineColor;
    downLine.frame = CGRectMake(self.wMainOffsetX, CGRectGetMaxY(self.textLabel.frame)+self.wMainOffsetY, self.wWidth-self.wMainOffsetX*2, DialogK1px);

    [self selectPayView:CGRectGetMaxY(downLine.frame)+self.wMainOffsetY/2 Height:Dialog_GetWNum(80)];
    [self.mainView addSubview:self.selectPayView];
    
    self.payField = [UITextField new];
    self.payField.frame = CGRectMake(self.wMainOffsetX, CGRectGetMaxY(self.selectPayView.frame)+self.wMainOffsetY/2, self.wWidth-self.wMainOffsetX*2, 0);
    self.payField.delegate = self;
    [self.mainView addSubview:self.payField];
    [self.mainView sendSubviewToBack:self.payField];
    self.payField.keyboardType = UIKeyboardTypeNumberPad;
    [self.payField addTarget:self action:@selector(textField1TextChange:) forControlEvents:UIControlEventEditingChanged];
    [self.payField becomeFirstResponder];
    
    self.passView = [UIView new];
    self.passView.backgroundColor = self.wMainBackColor;
    self.passView.frame = CGRectMake(self.wMainOffsetX, CGRectGetMaxY(self.selectPayView.frame)+self.wMainOffsetY/2, self.wWidth-self.wMainOffsetX*2, self.wMainBtnHeight);
    [self.mainView addSubview:self.passView];

    UILabel *tempLabel = nil;
    for (int i = 0; i<self.wPayNum; i++) {
        UILabel *password = [UILabel new];
        password.layer.masksToBounds = YES;
        password.layer.borderColor = self.wLineColor.CGColor;
        password.tag = 100+i;
        password.layer.borderWidth = DialogK1px;
        password.textColor = self.wMessageColor;
        password.textAlignment = NSTextAlignmentCenter;
        password.text = @"";
        [password setFont:[UIFont fontWithName:@"Helvetica-Bold" size:self.wTitleFont*2]];
        if (!tempLabel) {
            password.frame = CGRectMake(0, 0, self.passView.frame.size.height, self.passView.frame.size.height);
        }else{
            password.frame = CGRectMake(CGRectGetMaxX(tempLabel.frame), 0,self.passView.frame.size.height, self.passView.frame.size.height);
        }
        tempLabel = password;
        [self.passView addSubview:password];
        if (i==self.wPayNum-1) {
            CGRect rect = self.passView.frame;
            CGFloat maxWidth = CGRectGetMaxX(password.frame);
            if (maxWidth>(self.wWidth-self.wMainOffsetX*2)) {
                maxWidth = self.wWidth-self.wMainOffsetX*2;
            }
            rect.origin.x = (rect.size.width-maxWidth+self.wMainOffsetX*2)/2;
            rect.size.width = maxWidth;
            self.passView.frame = rect;
        }
    }
    
    [self reSetMainViewFrame:CGRectMake(0, 0, self.wWidth, CGRectGetMaxY(self.passView.frame)+self.wMainOffsetY)];
    return self.mainView;
}




- (void)selectPayView:(CGFloat)maxY Height:(CGFloat)height{
    self.selectPayView = [UIView new];
    self.selectPayView.frame = CGRectMake(self.wMainOffsetX, maxY , self.wWidth - self.wMainOffsetX*2, height);
    CGFloat maxWidth = self.selectPayView.frame.size.width;
    UILabel *la = [UILabel new];
    la.tag = 111;
    la.font = [UIFont systemFontOfSize:self.wTitleFont-2];
    la.frame = CGRectMake(0, 0, maxWidth/2, height);
    la.text = @"支付方式";
    [self.selectPayView addSubview:la];
    
    UIButton *selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    selectBtn.tag = 222;
    selectBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [selectBtn addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    [selectBtn setTitle:self.wDefaultSelectPayStr forState:UIControlStateNormal];
    selectBtn.titleLabel.font = [UIFont systemFontOfSize:self.wTitleFont-2];
    [selectBtn setTitleColor:self.wCancelColor forState:UIControlStateNormal];
    selectBtn.backgroundColor = self.wMainBackColor;
    selectBtn.frame = CGRectMake(maxWidth/2 ,0,  maxWidth/2- Dialog_GetWNum(30), height);
    [self.selectPayView addSubview:selectBtn];
    
    UIButton *goBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [goBtn addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    [goBtn setTitle:@">" forState:UIControlStateNormal];
    goBtn.titleLabel.font = [UIFont systemFontOfSize:self.wTitleFont-2];
    [goBtn setTitleColor:self.wCancelColor forState:UIControlStateNormal];
    goBtn.backgroundColor = self.wMainBackColor;
    goBtn.frame = CGRectMake(CGRectGetMaxX(selectBtn.frame), 0, Dialog_GetWNum(30), height);
    [self.selectPayView addSubview:goBtn];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([NSString stringWithFormat:@"%@%@",textField.text,string].length<=self.wPayNum) {
        return YES;
    }
    return NO;
}

-(void)textField1TextChange:(UITextField *)textField{
    DialogWeakSelf(self)
    for (int i = 0; i<[self.passView subviews].count; i++) {
        UILabel *la = [self.passView subviews][i];
        la.text = @"";
    }
    for (int i = 0; i<textField.text.length; i++) {
        UILabel *la = [self.passView viewWithTag:100+i];
        la.text = @"●";
    }
    if (textField.text.length==self.wPayNum) {
        [self.payField resignFirstResponder];
        [self closeView:^{
            if (weakObject.wEventFinish) {
                weakObject.wEventFinish(textField.text,nil,weakObject.wType);
            }
        }];
    }
}

- (void)selectAction:(UIButton*)sender{
    if (!self.wCanSelectPay) return;
    [self.payField resignFirstResponder];
    DialogWeakSelf(self)
    Dialog()
    .wEventFinishSet(^(id anyID,NSIndexPath *path,DialogType type) {
        DialogStrongSelf(weakObject)
        if (anyID) {
           UIButton *selectBtn = [strongObject.selectPayView viewWithTag:222];
           [selectBtn setTitle:anyID forState:UIControlStateNormal];
        }
        [weakObject.payField becomeFirstResponder];
    })
    .wMessageSet(@"")
    .wTitleSet(@"")
    .wDataSet(self.wSonData)
    .wTypeSet(DialogTypeSelect)
    .wStart();
}

- (void)closeBtnAction{
    [self closeView];
}

- (void)setPassView:(UIView *)passView{
     objc_setAssociatedObject(self, &passViewKey, passView, OBJC_ASSOCIATION_RETAIN);
}

- (UIView *)passView{
     return objc_getAssociatedObject(self, &passViewKey);
}


- (void)setSelectPayView:(UIView *)selectPayView{
    objc_setAssociatedObject(self, &selectPayViewKey, selectPayView, OBJC_ASSOCIATION_RETAIN);
}

- (UIView *)selectPayView{
    return objc_getAssociatedObject(self, &selectPayViewKey);
}

@end
