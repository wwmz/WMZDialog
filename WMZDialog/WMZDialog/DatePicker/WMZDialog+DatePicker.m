//
//  WMZDialog+DatePicker.m
//  WMZDialog
//
//  Created by wmz on 2019/8/14.
//  Copyright © 2019年 wmz. All rights reserved.
//

#import "WMZDialog+DatePicker.h"
#define DateCongigMarr @[@"yyyy",@"MM",@"dd",@"HH",@"mm",@"ss"]
#define DateConigDic @{ \
                    @"yyyy":@"timeYearData:",\
                    @"MM":@"timeMonthData:", \
                    @"dd":@"timeDayWithArr:Data:",\
                    @"HH":@"timeHourData:",@"mm": \
                    @"timeMinData:",@"ss":@"timeSecondData:",}
@implementation WMZDialog (DatePicker)

- (UIView*)datePickerAction{

    self.wData = [NSMutableArray new];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSCalendarUnitDay | NSCalendarUnitMonth |  NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *components = [calendar components:unitFlags fromDate:self.wDefaultDate];
    //最小值
    NSDateComponents *minComponents = nil;
    //最大值
    NSDateComponents *maxComponents = nil;
    
    if (self.wMinDate) {
        minComponents = [calendar components:unitFlags fromDate:self.wMinDate];
        self.minDate = [NSMutableDictionary new];
        [self.minDate setObject:@([minComponents year]) forKey:@"yyyy"];
        [self.minDate setObject:@([minComponents month]) forKey:@"MM"];
        [self.minDate setObject:@([minComponents day]) forKey:@"dd"];
        [self.minDate setObject:@([minComponents hour]) forKey:@"HH"];
        [self.minDate setObject:@([minComponents minute]) forKey:@"mm"];
        [self.minDate setObject:@([minComponents second]) forKey:@"ss"];
    }
    if (self.wMaxDate) {
        maxComponents = [calendar components:unitFlags fromDate:self.wMaxDate];
        self.maxDate = [NSMutableDictionary new];
        [self.maxDate setObject:@([maxComponents year]) forKey:@"yyyy"];
        [self.maxDate setObject:@([maxComponents month]) forKey:@"MM"];
        [self.maxDate setObject:@([maxComponents day]) forKey:@"dd"];
        [self.maxDate setObject:@([maxComponents hour]) forKey:@"HH"];
        [self.maxDate setObject:@([maxComponents minute]) forKey:@"mm"];
        [self.maxDate setObject:@([maxComponents second]) forKey:@"ss"];
    }
    
    NSDictionary *dic = DateConigDic;
    
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
        
        if ([self.wDateTimeType rangeOfString:obj].location !=NSNotFound) {
            BOOL append = false;
            if ([self.wDateTimeType rangeOfString:formatDic[obj]].location !=NSNotFound) {
                append = YES;
                str = [NSString stringWithFormat:@"%@%@",dateDic[obj],formatDic[obj]];
            }
            NSArray *data = nil;
            NSMutableDictionary *mdic = [NSMutableDictionary new];
            if ([obj isEqualToString:@"yyyy"]) {
                if (self.minDate&&self.minDate[@"yyyy"]) {
                    [mdic setObject:self.minDate[@"yyyy"] forKey:@"min"];
                }
                if (self.maxDate&&self.maxDate[@"yyyy"]) {
                    [mdic setObject:self.maxDate[@"yyyy"] forKey:@"max"];
                }
            }
            
            if([obj isEqualToString:@"dd"]){
                NSArray *arr = @[[NSString stringWithFormat:@"%ld",[components year]],[NSString stringWithFormat:@"%ld",[components month]]];
                SuppressPerformSelectorLeakWarning(
                                                   data = [self performSelector:NSSelectorFromString(dic[obj]) withObject:arr withObject:@{}];);
            }else{
                SuppressPerformSelectorLeakWarning(
                                                   data =  [self performSelector:NSSelectorFromString(dic[obj]) withObject:mdic];
                );
            }

            if(data){
              [self.wData addObject:data];
              [self.selectArr addObject:str];
            }
        }
    }
    
    [self updateTime:nil component:@(0)];
    for (int i = 0; i<self.selectArr.count; i++) {
        NSArray *arr =  self.wData[i];
        NSString *value = self.selectArr[i];
        NSInteger index = [arr indexOfObject:value];
        if (index<arr.count) {
            [self.pickView selectRow:index+(self.wPickRepeat?(pickViewCount/2*arr.count):0) inComponent:i animated:YES];
            if ((self.wMinDate||self.wMaxDate)&&i!=self.selectArr.count-1) {
                [self updateTime:@(index) component:@(i)];
            }
        }
    }
    
    self.diaLogHeadView = [self addTopView];
    [self.OKBtn addTarget:self action:@selector(PickDateOKAction:) forControlEvents:UIControlEventTouchUpInside];

    self.pickView.frame =  CGRectMake(0, CGRectGetMaxY(self.diaLogHeadView.frame), self.wWidth, self.wHeight);
    [self.mainView addSubview:self.pickView];
        
    [self reSetMainViewFrame:CGRectMake(0,0,self.wWidth, CGRectGetMaxY(self.pickView.frame))];
    //设置只有一半圆角
    [WMZDialogTool setView:self.mainView radio:CGSizeMake(self.wMainRadius,self.wMainRadius) roundingCorners:UIRectCornerTopLeft |UIRectCornerTopRight];
   

    return self.mainView;
}

- (NSArray*)timeYearData:(NSDictionary*)limitDic{
    NSString *name = [self.wDateTimeType containsString:@"年"]?@"年":@"";
    int min = 1;
    int max = 3000;
    if (limitDic&&limitDic[@"min"]) {
        min = [limitDic[@"min"] intValue];
    }
    if (limitDic&&limitDic[@"max"]) {
        max = [limitDic[@"max"] intValue];
    }
    NSMutableArray *year = [NSMutableArray new];
    for (int i = min; i<= max; i++) {
        [year addObject:[NSString stringWithFormat:@"%d%@",i,name]];
    }
    return [NSArray arrayWithArray:year];
}

- (NSArray*)timeMonthData:(NSDictionary*)limitDic{
    NSString *name = [self.wDateTimeType containsString:@"月"]?@"月":@"";
    int min = 1;
    int max = 12;
    if (limitDic&&limitDic[@"min"]) {
        min = [limitDic[@"min"] intValue];
    }
    if (limitDic&&limitDic[@"max"]) {
        max = [limitDic[@"max"] intValue];
    }
    
    NSMutableArray *month = [NSMutableArray new];
    for (int i = min; i<= max;i++ ) {
        [month addObject:i<10?[NSString stringWithFormat:@"0%d%@",i,name]:[NSString stringWithFormat:@"%d%@",i,name]];
    }
    return [NSArray arrayWithArray:month];
}



- (NSArray*)timeHourData:(NSDictionary*)limitDic{
    NSString *name = [self.wDateTimeType containsString:@"时"]?@"时":@"";
    int min = 0;
    int max = 23;
    if (limitDic&&limitDic[@"min"]) {
        min = [limitDic[@"min"] intValue];
    }
    if (limitDic&&limitDic[@"max"]) {
        max = [limitDic[@"max"] intValue];
    }
    NSMutableArray *hour = [NSMutableArray new];
    for (int i = min; i<= max; i++) {
        [hour addObject:i<10?[NSString stringWithFormat:@"0%d%@",i,name]:[NSString stringWithFormat:@"%d%@",i,name]];
    }
    return [NSArray arrayWithArray:hour];
}

- (NSArray*)timeMinData:(NSDictionary*)limitDic{
     NSString *name = [self.wDateTimeType containsString:@"分"]?@"分":@"";
     int min = 0;
     int max = 59;
     if (limitDic&&limitDic[@"min"]) {
         min = [limitDic[@"min"] intValue];
     }
     if (limitDic&&limitDic[@"max"]) {
         max = [limitDic[@"max"] intValue];
     }
    NSMutableArray *minArr = [NSMutableArray new];
    for (int i = min; i<= max ;i++ ) {
        [minArr addObject:i<10?[NSString stringWithFormat:@"0%d%@",i,name]:[NSString stringWithFormat:@"%d%@",i,name]];
    }
    return [NSArray arrayWithArray:minArr];
}

- (NSArray*)timeSecondData:(NSDictionary*)limitDic{
    NSString *name = [self.wDateTimeType containsString:@"秒"]?@"秒":@"";
    int min = 0;
    int max = 59;
    if (limitDic&&limitDic[@"min"]) {
        min = [limitDic[@"min"] intValue];
    }
    if (limitDic&&limitDic[@"max"]) {
        max = [limitDic[@"max"] intValue];
    }
    NSMutableArray *second = [NSMutableArray new];
    for (int i = min; i<= max; i++) {
        [second addObject:i<10?[NSString stringWithFormat:@"0%d%@",i,name]:[NSString stringWithFormat:@"%d%@",i,name]];
    }
    return [NSArray arrayWithArray:second];
}


- (NSArray*)timeDayWithArr:(NSArray*)arr Data:(NSDictionary*)limitDic{
    NSString *name = [self.wDateTimeType containsString:@"日"]?@"日":@"";
    int day = 0 ;
    NSMutableArray *dayArr = [NSMutableArray new];
    if (!arr||arr.count<1) {
        //数据不规范的当做30天处理
        day = 30;
    }else{
        NSString *year = arr[0];
        NSString *month = arr[1];
        BOOL isLeapYear = false;
        NSInteger yearInfo = year.integerValue;
        if((yearInfo % 400 == 0) || ((yearInfo % 4 == 0) && (yearInfo % 100 != 0))){
            isLeapYear = true ;
        }
        
        NSArray *dayCountArr = @[@"31",isLeapYear?@"29":@"28",@"31",@"30",@"31",@"30",@"31",@"31",@"30",@"31",@"30",@"31"];
        day = [dayCountArr[month.integerValue-1] intValue];
        
    }
    
    int min = 1;
    int max = day;
    if (limitDic&&limitDic[@"min"]) {
        min = [limitDic[@"min"] intValue];
    }
    if (limitDic&&limitDic[@"max"]) {
        max = [limitDic[@"max"] intValue];
    }
    
    for (int i = min; i<= max;i++ ) {
        [dayArr addObject: i<10? [NSString stringWithFormat:@"0%d%@",i,name]:[NSString stringWithFormat:@"%d%@",i,name]];
    }
    
    return [NSArray arrayWithArray:dayArr];
}


/*
 *更新时间
 */
- (void)updateTime:(NSNumber*)rowNum component:(NSNumber*)componentNum{
    
    if (self.maxDate||self.minDate) {
        NSInteger component = [componentNum integerValue];
        //包含正确参数
        BOOL trueCongig = YES;
        //防止越界
        if (component+1 >= [self.wData count]) {
            trueCongig = NO;
        }
        //判断date的typeConfig时候全面
        if (trueCongig) {
            for (int i = 0; i<=(component+1); i++) {
                NSString *type = DateCongigMarr[i];
                if ([self.wDateTimeType rangeOfString:type].location == NSNotFound ) {
                    trueCongig = NO;break;
                }
            }
        }
        
        if (trueCongig) {
            //更新后面的所有列
            for (NSInteger k = component+1; k<[self.wData count]; k++) {
                NSString *nextType = DateCongigMarr[k];
                BOOL minLimit = YES;
                BOOL maxLimit = YES;
                NSMutableDictionary *mdic = [NSMutableDictionary new];
                NSCharacterSet* nonDigits =[[NSCharacterSet decimalDigitCharacterSet] invertedSet];
                //需要比较的时间
                NSMutableArray *compareDateArr = [NSMutableArray new];
                NSMutableArray *dateTypeArr = [NSMutableArray new];
                for (int i = 0; i<=k-1; i++) {
                    int tmpDateConfig = 0;
                    NSArray *tmpDateConfigArr = self.wData[i];
                    NSInteger yearIndex = [self.pickView selectedRowInComponent:i];
                    
                    NSInteger index = MIN((self.wPickRepeat?yearIndex%tmpDateConfigArr.count:yearIndex), (self.wPickRepeat?(tmpDateConfigArr.count-1)%tmpDateConfigArr.count:(tmpDateConfigArr.count-1)));
                    
                    tmpDateConfig =[[tmpDateConfigArr[index] stringByTrimmingCharactersInSet:nonDigits] intValue];
                    
                    [compareDateArr addObject:@(tmpDateConfig)];
                    [dateTypeArr addObject:DateCongigMarr[i]];
                    
                }
                
                NSMutableArray *yearMontharr = [NSMutableArray new];
                for (int i = 0; i<compareDateArr.count; i++) {
                    int dateConfig = [compareDateArr[i] intValue];
                    NSString *dateType = dateTypeArr[i];
                    
                    if (self.minDate&&self.minDate[dateType]) {
                        if (dateConfig >[self.minDate[dateType] intValue]) {
                            minLimit = NO;
                        }
                    }
                    if (self.maxDate&&self.maxDate[dateType]) {
                        if (dateConfig <[self.maxDate[dateType] intValue]) {
                            maxLimit = NO;
                        }
                    }
                    if ([dateType isEqualToString:@"yyyy"]||[dateType isEqualToString:@"MM"]) {
                        [yearMontharr addObject:compareDateArr[i]];
                    }
                }
                
                if (self.minDate&&self.minDate[nextType]&&minLimit) {
                    [mdic setObject:self.minDate[nextType] forKey:@"min"];
                }
                if (self.maxDate&&self.maxDate[nextType]&&maxLimit) {
                    [mdic setObject:self.maxDate[nextType] forKey:@"max"];
                }
                
                if(k == 2){
                    
                    SuppressPerformSelectorLeakWarning(
                        self.wData[k] = [self performSelector:NSSelectorFromString(DateConigDic[nextType])  withObject:[NSArray arrayWithArray:yearMontharr] withObject:[NSDictionary dictionaryWithDictionary:mdic]];
                    );
                    
                }else{
                    SuppressPerformSelectorLeakWarning(
                    self.wData[k] = [self performSelector:NSSelectorFromString(DateConigDic[nextType])  withObject:[NSDictionary dictionaryWithDictionary:mdic]];
                    );
                }
                [self.pickView reloadComponent:k];
            }
        }
    }
}

/*
 *确定事件
 */
- (void)PickDateOKAction:(UIButton*)btn{
    DialogWeakSelf(self)
    [self closeView:^{
        if (weakObject.wEventOKFinish) {
           NSMutableArray *mArr = [NSMutableArray new];
           NSMutableArray *orginArr = [NSMutableArray new];
           NSMutableString *dateStr = [NSMutableString stringWithString:weakObject.wDateTimeType];
           for (int i = 0; i<[weakObject.wData count]; i++) {
           NSArray *arr = weakObject.wData[i];
           NSString *str = arr [weakObject.wPickRepeat?[weakObject.pickView selectedRowInComponent:i]%arr.count:[weakObject.pickView selectedRowInComponent:i]];
           [orginArr addObject:str];
           NSCharacterSet* nonDigits =[[NSCharacterSet decimalDigitCharacterSet] invertedSet];
           NSString * remainSecond = [str stringByTrimmingCharactersInSet:nonDigits];
           [mArr addObject:remainSecond];
           }
            
           NSMutableArray *containArr = [NSMutableArray new];
            for (NSString *str in DateCongigMarr) {
                if ([weakObject.wDateTimeType rangeOfString:str].location!=NSNotFound) {
                    [containArr addObject:str];
                }
            }
            for (int i = 0; i<containArr.count; i++) {
                NSString *containStr = containArr[i];
                NSString *value = mArr[i];
                [dateStr replaceCharactersInRange:[dateStr rangeOfString:containStr] withString:value];
            }
         
           weakObject.wEventOKFinish(mArr, dateStr);
        }
    }];
}

@end
