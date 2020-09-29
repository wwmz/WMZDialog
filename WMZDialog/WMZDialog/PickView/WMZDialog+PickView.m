//
//  WMZDialog+PickView.m
//  WMZDialog
//
//  Created by wmz on 2019/6/20.
//  Copyright © 2019年 wmz. All rights reserved.
//

#import "WMZDialog+PickView.h"
@implementation WMZDialog (PickView)
- (UIView*)pickAction{
    
    self.diaLogHeadView = [self addTopView];
    [self.OKBtn addTarget:self action:@selector(PickOKAction:) forControlEvents:UIControlEventTouchUpInside];

    self.pickView.frame =  CGRectMake(0, CGRectGetMaxY(self.diaLogHeadView.frame), self.wWidth, self.wHeight);
    [self.mainView addSubview:self.pickView];
    
    [self reSetMainViewFrame:CGRectMake(0,0,self.wWidth, CGRectGetMaxY(self.pickView.frame))];
    //设置只有一半圆角
    [WMZDialogTool setView:self.mainView radio:CGSizeMake(self.wMainRadius,self.wMainRadius) roundingCorners:UIRectCornerTopLeft |UIRectCornerTopRight];
    
    if (self.wListDefaultValue) {
        if ([self.wData isKindOfClass:[NSArray class]]) {
            NSArray *arr = (NSArray*)self.wData;
            [arr enumerateObjectsUsingBlock:^(NSArray*  _Nonnull sonArr, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([sonArr isKindOfClass:[NSArray class]]) {
                    if (self.wListDefaultValue.count>idx) {
                        id son = self.wListDefaultValue[idx];
                        NSInteger index = NSNotFound;
                       if ([son isKindOfClass:[NSDictionary class]]) {
                           NSString *ID = son[@"id"];
                           if (ID&&[ID length]) {
                               index = [sonArr indexOfObject:ID];
                           }
                        }else if ([son isKindOfClass:[NSNumber class]]) {
                            NSInteger num = [son intValue];
                            if (sonArr.count>num) {
                                index = num;
                            }
                        }else{
                            index = [sonArr indexOfObject:son];
                            
                        }
                        if (index!=NSNotFound) {
                            [self.pickView selectRow:index inComponent:idx animated:YES];
                        }
                    }
                }
            }];
        }
    }
    return self.mainView;
}

//重设确定的方法
- (void)PickOKAction:(UIButton*)btn{
    DialogWeakSelf(self)
    [self closeView:^{
        DialogStrongSelf(weakObject)
        if (strongObject.wEventOKFinish) {
            if (strongObject.tree) {
                NSArray *arr = [strongObject getTreeSelectDataArr:YES];
                NSMutableArray *nameArr = [NSMutableArray new];
                for (WMZTree *tree in arr) {
                    [nameArr addObject:tree.name];
                }
                strongObject.wEventOKFinish(arr, nameArr);
            }else{
                NSMutableArray *mStr = [NSMutableArray new];
                for (int i = 0; i<[strongObject.wData count]; i++) {
                    NSArray *arr = strongObject.wData[i];
                    NSString *str = arr [strongObject.wPickRepeat?[strongObject.pickView selectedRowInComponent:i]%arr.count:[strongObject.pickView selectedRowInComponent:i]];
                    [mStr addObject:str];
                }
                strongObject.wEventOKFinish(mStr, nil);
            }
        }
    }];
}

- (void)action{
    if (self.wEventOKFinish) {
        if (self.tree) {
            NSArray *arr = [self getTreeSelectDataArr:YES];
            NSMutableArray *nameArr = [NSMutableArray new];
            for (WMZTree *tree in arr) {
                [nameArr addObject:tree.name];
            }
            self.wEventOKFinish(arr, nameArr);
        }else{
            NSMutableArray *mStr = [NSMutableArray new];
            for (int i = 0; i<[self.wData count]; i++) {
                NSArray *arr = self.wData[i];
                NSString *str = arr [self.wPickRepeat?[self.pickView selectedRowInComponent:i]%arr.count:[self.pickView selectedRowInComponent:i]];
                [mStr addObject:str];
            }
            self.wEventOKFinish(mStr, nil);
        }
    }
}


@end
