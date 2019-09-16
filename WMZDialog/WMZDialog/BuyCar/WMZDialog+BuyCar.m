//
//  WMZDialog+BuyCar.m
//  WMZDialog
//
//  Created by wmz on 2019/7/8.
//  Copyright © 2019年 wmz. All rights reserved.
//

#import "WMZDialog+BuyCar.h"

@implementation WMZDialog (BuyCar)
-(UIView*)bugCarAction{
    
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(buyCarNotificationAction:) name:@"buyCar" object:nil];
    
    UIImageView *image = [UIImageView new];
    image.image = [UIImage imageNamed:self.wImageName];
    image.frame = CGRectMake(self.wMainOffsetX, -self.wWidth/5/4, self.wWidth/5, self.wWidth/5);
    image.layer.cornerRadius = 10;
    image.layer.masksToBounds = YES;
    image.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTapAction)];
    [image addGestureRecognizer:tap];
    [self.mainView addSubview:image];
    
    [self.mainView addSubview:self.textLabel];
    self.textLabel.textAlignment = NSTextAlignmentLeft;
    self.textLabel.frame =  CGRectMake(CGRectGetMaxX(image.frame)+self.wMainOffsetX,  self.wTitle.length?self.wMainOffsetY:0, self.wWidth-self.wMainOffsetX*2-CGRectGetMaxX(image.frame)-self.wMainBtnHeight, [WMZDialogTool heightForTextView:CGSizeMake(self.wWidth-self.wMainOffsetX*2-CGRectGetMaxX(image.frame)-self.wMainBtnHeight, CGFLOAT_MAX) WithText:self.textLabel.text WithFont:self.textLabel.font.pointSize]);
   
    
    [self.mainView addSubview:self.titleLabel];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.titleLabel.frame = CGRectMake(CGRectGetMaxX(image.frame)+self.wMainOffsetX, CGRectGetMaxY(self.textLabel.frame)+self.wMainOffsetX,self.wWidth-self.wMainOffsetX*2-CGRectGetMaxX(image.frame)-self.wMainBtnHeight, [WMZDialogTool heightForTextView:CGSizeMake(self.wWidth-self.wMainOffsetX*2-CGRectGetMaxX(image.frame)-self.wMainBtnHeight, CGFLOAT_MAX) WithText:self.titleLabel.text WithFont:self.titleLabel.font.pointSize]);

    
    
    UIView *downLine = [UIView new];
    [self.mainView addSubview:downLine];
    downLine.alpha = self.wLineAlpha;
    downLine.backgroundColor = self.wLineColor;
    downLine.frame = CGRectMake(self.wMainOffsetX, CGRectGetMaxY(self.titleLabel.frame)+self.wMainOffsetY, self.wWidth-self.wMainOffsetX*2, DialogK1px);
    
    self.wCloseBtn.frame = CGRectMake(self.wWidth-self.wMainOffsetX-self.wMainBtnHeight, (CGRectGetMinY(downLine.frame)-self.wMainBtnHeight/2)/2, self.wMainBtnHeight, self.wMainBtnHeight/2);
    self.wCloseBtn.layer.borderWidth = 0;
    [self.mainView addSubview:self.wCloseBtn];
    
    self.tableView.frame = CGRectMake(0, CGRectGetMaxY(downLine.frame), self.wWidth,400);
    self.tableView.backgroundColor = self.wMainBackColor;
    [self.mainView addSubview:self.tableView];
    
    
    [self.mainView addSubview:self.OKBtn];
    self.OKBtn.backgroundColor = [UIColor redColor];
    [self.OKBtn removeTarget:self action:NSSelectorFromString(@"OKAction:") forControlEvents:UIControlEventTouchUpInside];
    [self.OKBtn addTarget:self action:@selector(buyCarOKAction) forControlEvents:UIControlEventTouchUpInside];
    self.OKBtn.frame = CGRectMake(0, CGRectGetMaxY(self.tableView.frame), self.wWidth, self.wMainBtnHeight);
    
    self.OKBtn.userInteractionEnabled = NO;
    self.OKBtn.backgroundColor = [UIColor lightGrayColor];
    [self.OKBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self reSetMainViewFrame:CGRectMake(0, 0, self.wWidth, CGRectGetMaxY(self.OKBtn.frame))];
    return self.mainView;
}

- (void)imageTapAction{
    
}

/*
 *购物车通知
 */
- (void)buyCarNotificationAction:(NSNotification*)no{
    NSDictionary *dic = [no userInfo];
    if (self.selectArr.count!=[self.wData count]) {
        for (int i = 0; i<[self.wData count]; i++) {
            [self.selectArr addObject:@""];
        }
    }
    if (dic[@"amount"]) {
        [self.selectArr replaceObjectAtIndex:self.selectArr.count-1 withObject:[dic[@"amount"] integerValue] >0?dic[@"amount"]:@""];
    }else{
        NSInteger index = [dic[@"index"] integerValue];
        NSString *name = dic[@"data"];
        BOOL isSelect = [dic[@"isSelected"] boolValue];
        if (self.selectArr.count>index) {
            [self.selectArr replaceObjectAtIndex:index withObject:isSelect?name:@""];
        }
        
        int isValue = 0;
        for (int i = 0; i<self.selectArr.count; i++) {
            if (i!=self.selectArr.count-1&&[self.selectArr[i] length]) {
                isValue+=1;
            }
        }
        if (isValue) {
            self.titleLabel.text = @"已选择: ";
        }else{
            self.titleLabel.text = @"请选择";

        }

        NSMutableString *mStr = [NSMutableString stringWithString:self.titleLabel.text];
        
        for (int i = 0; i<self.selectArr.count; i++) {
            NSString *showText = self.selectArr[i];
            if (i!=self.selectArr.count-1&&showText.length>0) {
                [mStr appendString: [NSString stringWithFormat:@" %@",showText]];
            }
        }
        self.titleLabel.text = mStr;
    }
   
    int canConfirm = 0;
    for (NSString *str in self.selectArr) {
        if ([str isKindOfClass:[NSString class]]&&[str length]) {
            canConfirm+=1;
        }
    }
    if (canConfirm == self.selectArr.count) {
        self.OKBtn.userInteractionEnabled = YES;
        self.OKBtn.backgroundColor = [UIColor redColor];
        [self.OKBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else{
        self.OKBtn.userInteractionEnabled = NO;
        self.OKBtn.backgroundColor = [UIColor lightGrayColor];
        [self.OKBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
}

- (void)buyCarOKAction{
    if (self.wEventFinish) {
        NSMutableArray *returnArr  = [NSMutableArray new];
        for (NSString *str in self.selectArr) {
            if ([str isKindOfClass:[NSString class]]&&[str length]) {
                [returnArr addObject:str];
            }
        }
        self.wEventFinish(returnArr, nil, self.wType);
    }
    [self closeView];
}
@end
