//
//  WMZDialog+DatePicker.m
//  WMZDialog
//
//  Created by wmz on 2019/8/14.
//  Copyright © 2019年 wmz. All rights reserved.
//

#import "WMZDialog+DatePicker.h"

@implementation WMZDialog (DatePicker)

- (UIView*)datePickerAction{

    self.wData = [NSMutableArray new];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSCalendarUnitDay | NSCalendarUnitMonth |  NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *components = [calendar components:unitFlags fromDate:[NSDate date]];
    
    NSDictionary *dic = @{
                          @"yyyy":@"timeYear:",
                          @"MM":@"timeMonth:",
                          @"dd":@"timeDayWithArr:withName:",
                          @"HH":@"timeHour:",
                          @"mm":@"timeMin:",
                          @"ss":@"timeSecond:",
                          };
    
    NSDictionary *dateDic = @{
                          @"yyyy":[NSString stringWithFormat:@"%ld",[components year]],
                          @"MM":[components month]<10?[NSString stringWithFormat:@"0%ld",[components month]]:[NSString stringWithFormat:@"%ld",[components month]],
                          @"dd":[components day]<10?[NSString stringWithFormat:@"0%ld",[components day]]:[NSString stringWithFormat:@"%ld",[components day]],
                          @"HH":[components hour]<10?[NSString stringWithFormat:@"0%ld",[components hour]]:[NSString stringWithFormat:@"%ld",[components hour]],
                          @"mm":[components minute]<10?[NSString stringWithFormat:@"0%ld",[components minute]]:[NSString stringWithFormat:@"%ld",[components minute]],
                          @"ss":[components second]<10?[NSString stringWithFormat:@"0%ld",[components second]]:[NSString stringWithFormat:@"%ld",[components second]],
                          };
    
    NSDictionary *formatDic = @{
                              @"yyyy":@"年",
                              @"MM":@"月",
                              @"dd":@"日",
                              @"HH":@"时",
                              @"mm":@"分",
                              @"ss":@"秒",
                              };
    
    NSArray *arr = @[@"yyyy",@"MM",@"dd",@"HH",@"mm",@"ss"];
    self.selectArr = [NSMutableArray new];
    for (NSString *obj in arr) {
        NSString *str = dateDic[obj];
        
        if ([self.wDateTimeType containsString:obj]) {
            BOOL append = false;
            if ([self.wDateTimeType containsString:formatDic[obj]]) {
                append = YES;
                str = [NSString stringWithFormat:@"%@%@",dateDic[obj],formatDic[obj]];
            }
            NSArray *data = nil;
            if([obj isEqualToString:@"dd"]){
                NSArray *arr = @[[NSString stringWithFormat:@"%ld",[components year]],[NSString stringWithFormat:@"%ld",[components month]]];
                SuppressPerformSelectorLeakWarning(
                                                   data = [self performSelector:NSSelectorFromString(dic[obj]) withObject:arr withObject:append?formatDic[obj]:@""];
                                                   );
            }else{
                SuppressPerformSelectorLeakWarning(
                                                   data =  [self performSelector:NSSelectorFromString(dic[obj]) withObject:append?formatDic[obj]:@""];
                );
            }
            
            if(data){
                [self.wData addObject:data];
                [self.selectArr addObject:str];
            }
        }
    }
    
    UIView *headView = [UIView new];
    headView.backgroundColor = self.wMainBackColor;
    headView.frame = CGRectMake(0, 0, self.wWidth, self.wMainBtnHeight);
    [self.mainView addSubview:headView];
    
    [self.mainView addSubview:self.cancelBtn];
    self.cancelBtn.frame = CGRectMake(self.wMainOffsetX, 0, self.wWidth/2-self.wMainOffsetX, self.wMainBtnHeight);
    self.cancelBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    [self.mainView addSubview:self.OKBtn];
    [self.OKBtn removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
    [self.OKBtn addTarget:self action:@selector(PickDateOKAction:) forControlEvents:UIControlEventTouchUpInside];
    self.OKBtn.frame = CGRectMake(self.wWidth/2, 0,self.wWidth/2-self.wMainOffsetX, self.wMainBtnHeight);
    self.OKBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    
    
    self.pickView.frame =  CGRectMake(0, CGRectGetMaxY(headView.frame), self.wWidth, self.wHeight);
    [self.mainView addSubview:self.pickView];
    
    
    for (int i = 0; i<self.selectArr.count; i++) {
        NSArray *arr = self.wData[i];
        NSString *value = self.selectArr[i];
        NSInteger index = [arr indexOfObject:value];
        if (index<arr.count) {
            [self.pickView selectRow:index+(self.wPickRepeat?(pickViewCount/2*arr.count):0) inComponent:i animated:YES];
        }
    }
    
    
    [self reSetMainViewFrame:CGRectMake(0,0,self.wWidth, CGRectGetMaxY(self.pickView.frame))];
    //设置只有一半圆角
    [WMZDialogTool setView:self.mainView Radii:CGSizeMake(self.wMainRadius,self.wMainRadius) RoundingCorners:UIRectCornerTopLeft |UIRectCornerTopRight];
   
    return self.mainView;
}

- (NSArray*)timeYear:(NSString*)name{
    NSMutableArray *year = [NSMutableArray new];
    for (int i = 1; i< 3000; i++) {
        [year addObject:[NSString stringWithFormat:@"%d%@",i,name]];
    }
    return [NSArray arrayWithArray:year];
}

- (NSArray*)timeMonth:(NSString*)name{
    NSMutableArray *month = [NSMutableArray new];
    for (int i = 1; i< 13;i++ ) {
        [month addObject:i<10?[NSString stringWithFormat:@"0%d%@",i,name]:[NSString stringWithFormat:@"%d%@",i,name]];
    }
    return [NSArray arrayWithArray:month];
}



- (NSArray*)timeHour:(NSString*)name{
    NSMutableArray *hour = [NSMutableArray new];
    for (int i = 0; i< 24; i++) {
        [hour addObject:i<10?[NSString stringWithFormat:@"0%d%@",i,name]:[NSString stringWithFormat:@"%d%@",i,name]];
    }
    return [NSArray arrayWithArray:hour];
}

- (NSArray*)timeMin:(NSString*)name{
    NSMutableArray *min = [NSMutableArray new];
    for (int i = 0; i< 60;i++ ) {
        [min addObject:i<10?[NSString stringWithFormat:@"0%d%@",i,name]:[NSString stringWithFormat:@"%d%@",i,name]];
    }
    return [NSArray arrayWithArray:min];
}

- (NSArray*)timeSecond:(NSString*)name{
    NSMutableArray *second = [NSMutableArray new];
    for (int i = 0; i< 60; i++) {
        [second addObject:i<10?[NSString stringWithFormat:@"0%d%@",i,name]:[NSString stringWithFormat:@"%d%@",i,name]];
    }
    return [NSArray arrayWithArray:second];
}

- (void)PickDateOKAction:(UIButton*)btn{
    [self closeView];
    if (self.wEventOKFinish) {
       NSMutableArray *mArr = [NSMutableArray new];
       NSMutableArray *orginArr = [NSMutableArray new];
       for (int i = 0; i<[self.wData count]; i++) {
       NSArray *arr = self.wData[i];
       NSString *str = arr [self.wPickRepeat?[self.pickView selectedRowInComponent:i]%arr.count:[self.pickView selectedRowInComponent:i]];
       [orginArr addObject:str];
       NSCharacterSet* nonDigits =[[NSCharacterSet decimalDigitCharacterSet] invertedSet];
       NSString * remainSecond = [str stringByTrimmingCharactersInSet:nonDigits];
       [mArr addObject:remainSecond];
       }
       self.wEventOKFinish(mArr, orginArr);
    }
}

@end
