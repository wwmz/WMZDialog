//
//  WMZTags.m
//  WMZTags
//
//  Created by wmz on 2019/5/23.
//  Copyright © 2019年 wmz. All rights reserved.
//

#import "WMZTags.h"
@interface WMZTags(){
   float allWidth ;   //整体长度
}
//按钮数组
@property(nonatomic,strong)NSMutableArray *btnArr;

@end
@implementation WMZTags

- (instancetype)initConfigureWithModel:(WMZTagParam *)param withView:(UIView*)parentView{
    if (self = [super init]) {
        self.param = param;
        if (parentView) {
            [parentView addSubview:self];
            [self serUp];
        }
    }
    return self;
}



//更新
- (void)updateUI{
    for (WMZTagBtn *btn in self.btnArr) {
        [btn removeFromSuperview];
    }
    [self.btnArr removeAllObjects];
    [self createUI];
}

- (void)serUp{
    
    self.userInteractionEnabled = YES;
    self.param.wMasonry? [self mas_makeConstraints:self.param.wMasonry]:[self setFrame:self.param.wFrame];
    self.btnArr = [NSMutableArray new];
    if (self.param.wMasonry) {
        [self.superview layoutIfNeeded];
        
    }
    [self createUI];
    if (self.param.wBackGroundColor) self.backgroundColor = self.param.wBackGroundColor;
    
}

//布局
- (void)createUI{
    if (!self.param.wData) {
        return;
    }
    if (self.param.wInsertaBle) {
        NSMutableArray *arr = [NSMutableArray arrayWithArray:self.param.wData];
        if ([arr indexOfObject:self.param.wInsertPlaceholder]==NSNotFound) {
            [arr addObject:self.param.wInsertPlaceholder];
            if (self.btnArr.count>0) {
                 WMZTagBtn *btn = [self.btnArr lastObject];
                if (btn.type != BtnInsert) {
                    [self.btnArr addObject:[WMZTagBtn buttonWithType:UIButtonTypeCustom WithParam:self.param withTag:self.btnArr.count+100 withText:self.param.wInsertPlaceholder BtnType:BtnInsert]];
                }

            }
        }
        self.param.wData = [NSArray arrayWithArray:arr];
    }

    //没有数据
    if (!self.param.wData.count) {
        if (self.param.wMasonry) {
            [self mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(0).priorityHigh();
            }];
            
        }else{
            CGRect rect  = self.frame;
            rect.size.height = 0;
            self.frame = rect;
        }
    }
    
    //处理默认选中的逻辑
    if (self.param.wSelectIndexData&&self.param.selectBtnArr.count==0) {
        NSMutableArray *temp = [NSMutableArray new];
        for (id num in self.param.wSelectIndexData) {
            if ([num isKindOfClass:[NSNumber class]]||[num isKindOfClass:[NSString class]]) {
                [temp addObject:@([num integerValue]+100)];
            }
        }
        if (self.param.cancelSelectDefaultBtnArr.count) {
            for (id num in self.param.cancelSelectDefaultBtnArr) {
                if ([num isKindOfClass:[NSNumber class]]||[num isKindOfClass:[NSString class]]) {
                    if ([temp indexOfObject:@([num integerValue])]!=NSNotFound) {
                        [temp removeObject:@([num integerValue])];
                    };
                }
            }
        }
        self.param.selectBtnArr =  [NSMutableArray arrayWithArray:temp];
    }

    allWidth = 0;     //整体长度
    //减去的间距
    CGFloat margin = self.param.marginRight + self.param.marginLeft;
    //最大长度
    float maxWidth = self.frame.size.width- margin > TagWitdh ? TagWitdh-self.frame.origin.x-margin:self.frame.size.width- margin;
    WMZTagBtn *tempBtn = nil;
    if (!self.btnArr.count) {
        for (int i = 0; i<self.param.wData.count; i++) {
            
            BOOL insertType  = (i == self.param.wData.count-1 && self.param.wInsertaBle)?YES:NO;
            WMZTagBtn *btn = [WMZTagBtn buttonWithType:UIButtonTypeCustom WithParam:self.param withTag:i + 100  withText:self.param.wData[i] BtnType:insertType?BtnInsert:BtnNormal];
            [btn addTarget:self action:@selector(btnTagAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            [self setUpBtn:btn lastBtn:tempBtn  maxWidth:maxWidth  addBtnObj:YES isLast:i==self.param.wData.count-1];
            tempBtn = btn;
        }
    }else{
        
        for (int i = 0; i<self.btnArr.count; i++) {
            WMZTagBtn *btn = self.btnArr[i];
            [self setUpBtn:btn lastBtn:tempBtn  maxWidth:maxWidth  addBtnObj:NO isLast:i==self.btnArr.count-1];
            tempBtn = btn;
        }
    }

}


//单个button布局
- (void)setUpBtn:(WMZTagBtn*)btn lastBtn:(WMZTagBtn*)tempBtn maxWidth:(CGFloat)maxWidth addBtnObj:(BOOL)add isLast:(BOOL)last{
    if (add) {
        [btn setSize];
    }
    btn.maxWidth = maxWidth;
    CGFloat btnWidth  = btn.maxSize.width + self.param.btnLeft;
    btn.max = NO;
    if (btnWidth>maxWidth) {
        btnWidth = maxWidth;
        btn.max = YES;
        btn.maxSize = CGSizeMake(btnWidth, btn.maxSize.height);
    }
    CGFloat btnHeight = btn.maxSize.height + self.param.btnTop;
    if (add) {
        [btn setUI];
    }
    if (!tempBtn) {
         allWidth += (btnWidth + self.param.marginLeft) ;
        if (self.param.wMasonry) {
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                if (self.param.wTagAlign == TagAlignRight) {
                    make.right.mas_equalTo(-self.param.marginLeft);
                }else{
                    make.left.mas_equalTo(self.param.marginLeft);
                }
                make.top.mas_equalTo(self.param.marginTop);
                make.width.mas_equalTo(btnWidth);
                make.height.mas_equalTo(btnHeight);
            }];
        }else{
            btn.frame = CGRectMake(self.param.wTagAlign == TagAlignRight?(self.frame.size.width-self.param.marginLeft-btnWidth):self.param.marginLeft, self.param.marginTop, btnWidth, btnHeight);
        }
    }else{
        allWidth += (btnWidth + self.param.paddingLeft) ;
        if (allWidth > maxWidth) {
            if (self.param.wMasonry) {
                [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                    if (self.param.wTagAlign == TagAlignRight) {
                        make.right.mas_equalTo(-self.param.marginLeft);
                    }else{
                        make.left.mas_equalTo(self.param.marginLeft);
                    }
                    make.top.equalTo(tempBtn.mas_bottom).offset(self.param.paddingTop);
                    make.width.mas_equalTo(btnWidth);
                    make.height.mas_equalTo(btnHeight);
                }];
            }else{
                btn.frame = CGRectMake(self.param.wTagAlign == TagAlignRight?(self.frame.size.width-self.param.marginLeft-btnWidth):self.param.marginLeft, CGRectGetMaxY(tempBtn.frame)+ self.param.paddingTop, btnWidth, btnHeight);
            }
            allWidth = (btnWidth + self.param.marginLeft);
        }else{
            if (self.param.wMasonry) {
                [btn mas_remakeConstraints:^(MASConstraintMaker *make) {
                    if (self.param.wTagAlign == TagAlignRight) {
                        make.right.equalTo(tempBtn.mas_left).offset(-self.param.paddingLeft);
                    }else{
                        make.left.equalTo(tempBtn.mas_right).offset(self.param.paddingLeft);
                    }
                    make.top.equalTo(tempBtn.mas_top);
                    make.width.mas_equalTo(btnWidth);
                    make.height.mas_equalTo(btnHeight);
                }];
            }else{
                btn.frame = CGRectMake(self.param.wTagAlign == TagAlignRight?(CGRectGetMinX(tempBtn.frame) -self.param.paddingLeft-btnWidth):CGRectGetMaxX(tempBtn.frame) +self.param.paddingLeft, tempBtn.frame.origin.y, btnWidth, btnHeight);
            }
        }
    }
    //最后一个
    if (last) {
        if (self.param.wMasonry) {
            //最后一个距离底部的距离
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(-self.param.marginBottom).with.priorityHigh();
            }];
        }else{
            CGRect rect  = self.frame;
            rect.size.height = CGRectGetMaxY(btn.frame) + self.param.marginBottom;
            self.frame = rect;
        }
    }
    //是否添加进按钮数组
    if (add) {
        [self.btnArr addObject:btn];
    }
    
    if (self.param.selectBtnArr&&self.param.selectBtnArr.count) {
        if ([self.param.selectBtnArr indexOfObject:@(btn.tag)]!=NSNotFound) {
            btn.selected = YES;
            [btn setUpBtnStyle];
        }else{
            btn.selected = NO;
            [btn setUpBtnStyle];
        }
    }
    

}


//按钮点击
- (void)btnTagAction:(WMZTagBtn*)sender{
    NSInteger index = sender.tag - 100;
    
    //添加的方法
    if (self.param.wInsertaBle && sender.type == BtnInsert) {
        //外界自定义
        __weak __typeof(self)weakSelf = self;
        if (self.param.insertClick) {
            self.param.insertClick(index, self.param.wInsertPlaceholder, ^(NSString * _Nonnull text) {
                __strong typeof(self) strongself = weakSelf;
                [strongself addTag:text];
            });
        }else{
            UIAlertController *alerVC = [UIAlertController alertControllerWithTitle:@"增加标签" message:nil preferredStyle:UIAlertControllerStyleAlert];
            [alerVC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                textField.placeholder = sender.titleLabel.text;
                textField.text = [NSString stringWithFormat:@"%ld",self.param.wData.count];
            }];
            [alerVC addAction:[UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDestructive) handler:^(UIAlertAction * _Nonnull action) {
                __strong typeof(self) strongself = weakSelf;
                UITextField *textfield1 = alerVC.textFields[0];
                [strongself addTag:textfield1.text];
            }]];
            [[WMZTagsTool getCurrentVC] presentViewController:alerVC animated:YES completion:nil];
        }
        return;
    }
     //关闭的方法
    if (self.param.wClosable) {
        NSMutableArray *arr = [NSMutableArray arrayWithArray:self.param.wData];
        [arr removeObject:sender.titleLabel.text];
        [self.btnArr removeObject:sender];
        [sender removeFromSuperview];
        self.param.wData = [NSArray arrayWithArray:arr];
        [self createUI];
        if (self.param.closeClick) {
            self.param.closeClick(index, sender.titleLabel.text,arr);
        }
        return;
    }
    //单点
    if (self.param.wSelectOne) {
        self.param.selectBtnArr = [NSMutableArray new];
        for (WMZTagBtn *btn in self.btnArr) {
            if (btn == sender) {
                btn.selected = !btn.selected;
                [self dealDefaultSelect:btn];
            }else{
                btn.selected = NO;
            }
            [btn setUpBtnStyle];
        }
        
        if (self.param.tapClick) {
            self.param.tapClick(index, sender.titleLabel.text,sender.selected);
        }
        return;
    }
    //多点
    if (self.param.wSelectMore) {
        sender.selected = !sender.selected;
        if (self.param.tagMoreClick) {
            [self dealDefaultSelect:sender];
            NSMutableArray *indexArr = [NSMutableArray new];
            NSMutableArray *modelArr = [NSMutableArray new];
            self.param.selectBtnArr = nil;
            for (WMZTagBtn *btn in self.btnArr) {
                if (btn.selected == YES) {
                    [indexArr addObject:@(btn.tag-100)];
                    [modelArr addObject:btn.titleLabel.text];
                    [self.param.selectBtnArr addObject:@(btn.tag)];
                }
                [btn setUpBtnStyle];
            }
            self.param.tagMoreClick(indexArr,modelArr);
        }
        return;
    }

}

//添加标签
- (void)addTag:(NSString*)tagString{
    if (!tagString||tagString.length==0) {
        NSLog(@"请输入内容");
        return;
    }
    if ([tagString isEqualToString:self.param.wInsertPlaceholder]) {
        NSLog(@"请重新输入");
        return;
    }
    NSMutableArray *arr = [NSMutableArray arrayWithArray:self.param.wData];
    if (!(arr.count>0)) return;
    [arr insertObject:tagString atIndex:arr.count-1];
    WMZTagBtn *btn = [WMZTagBtn buttonWithType:UIButtonTypeCustom WithParam:self.param withTag:self.btnArr.count-1 withText:tagString BtnType:BtnNormal];
    [btn addTarget:self action:@selector(btnTagAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnArr insertObject:btn atIndex:self.btnArr.count-1];
    self.param.wData = [NSArray arrayWithArray:arr];
    [self addSubview:btn];
    [self bringSubviewToFront:self.btnArr[self.btnArr.count-1]];
    [self createUI];
    //添加的回调
    if (self.param.insertTextClick&&self.param.wInsertaBle) {
        self.param.insertTextClick(tagString,self.param.wData);
    }
}

//处理默认选中的逻辑
- (void)dealDefaultSelect:(WMZTagBtn*)sender{
    if (![sender isSelected]) {
        for (id num in self.param.wSelectIndexData) {
            if ([num isKindOfClass:[NSNumber class]]||[num isKindOfClass:[NSString class]]) {
                if ([self.param.cancelSelectDefaultBtnArr indexOfObject:@([num integerValue]+100)]==NSNotFound) {
                    [self.param.cancelSelectDefaultBtnArr addObject:@([num integerValue]+100)];
                };
            }
        }
    }else{
        [self.param.selectBtnArr addObject:@(sender.tag)];
        if (self.param.wSelectIndexData&& [self.param.cancelSelectDefaultBtnArr indexOfObject:@(sender.tag)]!=NSNotFound) {
            [self.param.cancelSelectDefaultBtnArr removeObject:@(sender.tag)];
        }
    }
}

- (NSMutableArray *)btnArr{
    if (!_btnArr) {
        _btnArr = [NSMutableArray new];
    }
    return _btnArr;
}


@end


