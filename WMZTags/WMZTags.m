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
//判断是不是tableviewCell
@property(nonatomic,assign)BOOL tabelViewCell;
@end
@implementation WMZTags

- (instancetype)initConfigureWithModel:(WMZTagParam *)param{
    if (self = [super init]) {
        self.param = param;
        [self serUp];
    }
    return self;
}



//更新
- (void)updateUI{

    if (self.tabelViewCell&&(self.param.wClosable||self.param.wInsertaBle)) {
        for (WMZTagBtn *btn in self.btnArr) {
            [btn removeFromSuperview];
        }
        [self.btnArr removeAllObjects];
    }
    [self createUI];
}

- (void)serUp{
    
    if (!self.param.wParentView) return;
    self.userInteractionEnabled = YES;
    [self.param.wParentView addSubview:self];
    self.param.wMasonry? [self mas_makeConstraints:self.param.wMasonry]:[self setFrame:self.param.wFrame];
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
    if (!self.param.wData.count&&![self.param.wParentView isKindOfClass:[UITableViewCell class]]) {
        if (self.param.wMasonry) {
            [self mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(0);
            }];
            
        }else{
            CGRect rect  = self.frame;
            rect.size.height = 0;
            self.frame = rect;
        }
    }


    if (self.param.wMasonry) {
        [self.param.wParentView layoutIfNeeded];
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
            btn.selected = btn.selected;
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
    if (!self.param.wLineaBle) {
        btnHeight = btn.oneLineHeight + self.param.btnTop;
    }else{
        if (self.param.wLineNum!=0) {
            if (btn.lineCount>1) {
                 btnHeight = btn.oneLineHeight * self.param.wLineNum + self.param.btnTop;
            }
        }
    }
    if (add) {
        [btn setUI];
    }
    if (!tempBtn) {
         allWidth += (btnWidth + self.param.marginLeft) ;
        if (self.param.wMasonry) {
            
            if (add) {
                [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(self.param.marginLeft);
                    make.top.mas_equalTo(self.param.marginTop);
                    make.width.mas_equalTo(btnWidth);
                    make.height.mas_equalTo(btnHeight);
                }];
            }else{
                [btn mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(self.param.marginLeft);
                    make.top.mas_equalTo(self.param.marginTop);
                    make.width.mas_equalTo(btnWidth);
                    make.height.mas_equalTo(btnHeight);
                }];
            }
        }else{
            btn.frame = CGRectMake(self.param.marginLeft, self.param.marginTop, btnWidth, btnHeight);
        }
    }else{
        allWidth += (btnWidth + self.param.paddingLeft) ;
        if (allWidth > maxWidth) {
            if (self.param.wMasonry) {
                if (add) {
                    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.mas_equalTo(self.param.marginLeft);
                        make.top.equalTo(tempBtn.mas_bottom).offset(self.param.paddingTop);
                        make.width.mas_equalTo(btnWidth);
                        make.height.mas_equalTo(btnHeight);
                    }];
                }else{
                    [btn mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.left.mas_equalTo(self.param.marginLeft);
                        make.top.equalTo(tempBtn.mas_bottom).offset(self.param.paddingTop);
                        make.width.mas_equalTo(btnWidth);
                        make.height.mas_equalTo(btnHeight);
                    }];
                }
                
            }else{
                btn.frame = CGRectMake(self.param.marginLeft, CGRectGetMaxY(tempBtn.frame)+ self.param.paddingTop, btnWidth, btnHeight);
            }
            allWidth = (btnWidth + self.param.marginLeft);
        }else{
            if (self.param.wMasonry) {
                [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(tempBtn.mas_right).offset(self.param.paddingLeft);
                    make.top.equalTo(tempBtn.mas_top);
                    make.width.mas_equalTo(btnWidth);
                    make.height.mas_equalTo(btnHeight);
                }];
                
                if (add) {
                    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(tempBtn.mas_right).offset(self.param.paddingLeft);
                        make.top.equalTo(tempBtn.mas_top);
                        make.width.mas_equalTo(btnWidth);
                        make.height.mas_equalTo(btnHeight);
                    }];
                }else{
                    [btn mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(tempBtn.mas_right).offset(self.param.paddingLeft);
                        make.top.equalTo(tempBtn.mas_top);
                        make.width.mas_equalTo(btnWidth);
                        make.height.mas_equalTo(btnHeight);
                    }];
                }
            }else{
                btn.frame = CGRectMake(CGRectGetMaxX(tempBtn.frame) +self.param.paddingLeft, tempBtn.frame.origin.y, btnWidth, btnHeight);
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
}


//按钮点击
- (void)btnTagAction:(WMZTagBtn*)sender{
    NSInteger index = sender.tag - 100;
    
    //添加的方法
    if (self.param.wInsertaBle && sender.type == BtnInsert) {
        //外界自定义
        if (self.param.insertClick) {
            self.param.insertClick(index, self.param.wInsertPlaceholder, ^(NSString * _Nonnull text) {
                [self addTag:text];
            });
        }else{
            UIAlertController *alerVC = [UIAlertController alertControllerWithTitle:@"增加标签" message:nil preferredStyle:UIAlertControllerStyleAlert];
            [alerVC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                textField.placeholder = sender.titleLabel.text;
                textField.text = [NSString stringWithFormat:@"%ld",self.param.wData.count];
            }];
            [alerVC addAction:[UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDestructive) handler:^(UIAlertAction * _Nonnull action) {
                UITextField *textfield1 = alerVC.textFields[0];
                [self addTag:textfield1.text];
            }]];
            [[WMZTool getCurrentVC] presentViewController:alerVC animated:YES completion:nil];
        }
        return;
    }
     //关闭的方法
    if (self.param.wClosable) {
        NSMutableArray *arr = [NSMutableArray arrayWithArray:self.param.wData];
        [arr removeObject:sender.titleLabel.text];
        [self.btnArr removeObject:sender];
        [sender removeFromSuperview];
        NSLog(@"删除后%@",self.btnArr);
        self.param.wData = [NSArray arrayWithArray:arr];
        [self createUI];
        if (self.param.closeClick) {
            self.param.closeClick(index, sender.titleLabel.text,arr);
        }
        return;
    }
    //单点
    if (self.param.wSelectOne) {
        for (WMZTagBtn *btn in self.btnArr) {
            if (btn == sender) {
                btn.selected = !btn.selected;
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
        [sender setUpBtnStyle];
        if (self.param.tagMoreClick) {
            NSMutableArray *indexArr = [NSMutableArray new];
            NSMutableArray *modelArr = [NSMutableArray new];
            for (WMZTagBtn *btn in self.btnArr) {
                if (btn.selected == YES) {
                    [indexArr addObject:@(btn.tag - 100)];
                    [modelArr addObject:btn.titleLabel.text];
                }
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

- (BOOL)tabelViewCell{
     _tabelViewCell = NO;
    if ([NSStringFromClass([self.param.wParentView class]) isEqualToString:@"UITableViewCellContentView"]||[self.param.wParentView isKindOfClass:[UITableViewCell class]]) {
        _tabelViewCell = YES;
    }
    return _tabelViewCell;
}

- (NSMutableArray *)btnArr{
    if (!_btnArr) {
        _btnArr = [NSMutableArray new];
    }
    return _btnArr;
}


@end

