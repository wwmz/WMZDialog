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

    self.pickView.frame =  CGRectMake(0, self.diaLogHeadView?CGRectGetMaxY(self.diaLogHeadView.frame):0, self.wWidth, self.wHeight);
    [self.mainView addSubview:self.pickView];
    
    [self reSetMainViewFrame:CGRectMake(0,0,self.wWidth, CGRectGetMaxY(self.pickView.frame))];
    //设置只有一半圆角
    [WMZDialogTool setView:self.mainView radio:CGSizeMake(self.wMainRadius,self.wMainRadius) roundingCorners:UIRectCornerTopLeft |UIRectCornerTopRight];
    
    if (self.wListDefaultValue) {
        if ([self.wData isKindOfClass:[NSArray class]]) {
            NSArray *arr = (NSArray*)self.wData;
            if (self.nest) {
                [self setDefaultWithRow:(NSArray*)self.wData defaultIndex:0];
            }else{
                [arr enumerateObjectsUsingBlock:^(NSArray*  _Nonnull sonArr, NSUInteger idx, BOOL * _Nonnull stop) {
                    if ([sonArr isKindOfClass:[NSArray class]]) {
                        [self setDefaultWithRow:sonArr defaultIndex:idx];
                    }
                }];
            }
        }
    }
    return self.mainView;
}

- (void)setDefaultWithRow:(NSArray*)arr defaultIndex:(NSInteger)compom{
    if (arr&&
        [arr isKindOfClass:[NSArray class]]&&
        arr.count) {
        id defaultValue = nil;
        if ([self.wListDefaultValue isKindOfClass:[NSArray class]] &&
            self.wListDefaultValue.count > compom) {
            defaultValue = self.wListDefaultValue[compom];
        }
        if (defaultValue) {
            NSInteger index = NSNotFound;
            if ([defaultValue isKindOfClass:[NSNumber class]]) {
                NSInteger num = [defaultValue intValue];
                if (arr.count>num) {
                    index = num;
                }
            }else if ([defaultValue isKindOfClass:[NSString class]]){
                int i = 0;
                for (id sonData in arr) {
                    i++;
                    if ([sonData isKindOfClass:[NSString class]]) {
                        if ([sonData isEqualToString:defaultValue]) {
                            index = [arr indexOfObject:sonData];break;
                        }
                    }else if ([sonData isKindOfClass:[NSDictionary class]]){
                        NSString *name = sonData[@"name"];
                        if (name && [name isKindOfClass:[NSString class]]) {
                            if ([name isEqualToString:defaultValue]) {
                                index = [arr indexOfObject:sonData];break;
                            }
                        }
                    }
                }
            }else{
                index = [arr indexOfObject:defaultValue];
            }
            
            if (index!=NSNotFound) {
                [self.pickView selectRow:index inComponent:compom animated:NO];
            }
        }
    }
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
                if (!self.nest) {
                    for (int i = 0; i<[(NSArray*)strongObject.wData count]; i++) {
                        NSArray *arr = [(NSArray*)strongObject.wData objectAtIndex:i];
                        NSString *str = arr [strongObject.wPickRepeat?[strongObject.pickView selectedRowInComponent:i]%arr.count:[strongObject.pickView selectedRowInComponent:i]];
                        [mStr addObject:str];
                    }
                    strongObject.wEventOKFinish(mStr, nil);
                }else{
                    NSInteger index = strongObject.wPickRepeat?[strongObject.pickView selectedRowInComponent:0]%[(NSArray*)self.wData count]:[strongObject.pickView selectedRowInComponent:0];
                    NSString *str = [(NSArray*)self.wData objectAtIndex:index];
                    strongObject.wEventOKFinish(str, nil);
                }
            }
        }
    }];
}
@end
