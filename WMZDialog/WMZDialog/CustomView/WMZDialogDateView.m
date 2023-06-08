//
//  WMZDialogDateView.m
//  WMZDialog
//
//  Created by wmz on 2021/7/28.
//  Copyright © 2021 wmz. All rights reserved.
//
#define NumberMounthes 3
#define allCount 42
#import "WMZDialogDateView.h"
#import "WMZDialog.h"

@interface WMZDialogDateView()<UICollectionViewDelegate,UICollectionViewDataSource>
/// 最小时间
@property (nonatomic, strong) NSMutableDictionary <NSString*,NSNumber*>*minDate;
/// 最大时间
@property (nonatomic, strong) NSMutableDictionary <NSString*,NSNumber*>*maxDate;
/// 时间配置数组
@property (nonatomic, strong) NSArray <NSString*>*dateConfigArr;
/// 时间配置字典
@property (nonatomic, strong) NSDictionary <NSString*,NSString*>*dateConfigInfo;

@property (nonatomic, assign) NSInteger currentYear;

@property (nonatomic, assign) NSInteger currentMonth;

@property (nonatomic, assign) NSInteger currentDay;

@property (nonatomic,   copy) NSString *today;

@property (nonatomic, strong) WMZCalanderModel *selecctWMZCalanderModel;

@property (nonatomic, assign) NSInteger currentIndex;
/// layout
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
/// eollectionView
@property (nonatomic, strong) UICollectionView *collectionView;
/// 数据数组
@property (nonatomic, strong) NSMutableArray *dataArr;
/// 数据数组
@property (nonatomic, strong) NSMutableArray <NSString*>*selectTimeArr;
///
@property (nonatomic, assign) BOOL selectDate;
@end

@implementation WMZDialogDateView


- (void)mz_setupView{
    if (!self.param) return;
    if (self.param.wType == DialogTypeDatePicker) {
        self.param.wData = [NSMutableArray new];
        NSCalendar *calendar = [NSCalendar currentCalendar];
        unsigned unitFlags = NSCalendarUnitDay | NSCalendarUnitMonth |  NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
        NSDateComponents *components = [calendar components:unitFlags fromDate:self.param.wDefaultDate];
        /// 最小值
        NSDateComponents *minComponents = nil;
        /// 最大值
        NSDateComponents *maxComponents = nil;
          
        if (self.param.wMinDate) {
            minComponents = [calendar components:unitFlags fromDate:self.param.wMinDate];
            self.minDate = [NSMutableDictionary new];
            [self.minDate setObject:@([minComponents year]) forKey:@"yyyy"];
            [self.minDate setObject:@([minComponents month]) forKey:@"MM"];
            [self.minDate setObject:@([minComponents day]) forKey:@"dd"];
            [self.minDate setObject:@([minComponents hour]) forKey:@"HH"];
            [self.minDate setObject:@([minComponents minute]) forKey:@"mm"];
            [self.minDate setObject:@([minComponents second]) forKey:@"ss"];
        }
        if (self.param.wMaxDate) {
            maxComponents = [calendar components:unitFlags fromDate:self.param.wMaxDate];
            self.maxDate = [NSMutableDictionary new];
            [self.maxDate setObject:@([maxComponents year]) forKey:@"yyyy"];
            [self.maxDate setObject:@([maxComponents month]) forKey:@"MM"];
            [self.maxDate setObject:@([maxComponents day]) forKey:@"dd"];
            [self.maxDate setObject:@([maxComponents hour]) forKey:@"HH"];
            [self.maxDate setObject:@([maxComponents minute]) forKey:@"mm"];
            [self.maxDate setObject:@([maxComponents second]) forKey:@"ss"];
        }
          
        NSDictionary *dateDic = @{
            @"yyyy":[NSString stringWithFormat:@"%ld",(long)[components year]],
                                @"MM":[components month]<10?[NSString stringWithFormat:@"0%ld",(long)[components month]]:[NSString stringWithFormat:@"%ld",(long)[components month]],
                                @"dd":[components day]<10?[NSString stringWithFormat:@"0%ld",(long)[components day]]:[NSString stringWithFormat:@"%ld",(long)[components day]],
                                @"HH":[components hour]<10?[NSString stringWithFormat:@"0%ld",(long)[components hour]]:[NSString stringWithFormat:@"%ld",(long)[components hour]],
                                @"mm":[components minute]<10?[NSString stringWithFormat:@"0%ld",(long)[components minute]]:[NSString stringWithFormat:@"%ld",(long)[components minute]],
                                @"ss":[components second]<10?[NSString stringWithFormat:@"0%ld",(long)[components second]]:[NSString stringWithFormat:@"%ld",(long)[components second]],
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
            if ([self.param.wDateTimeType rangeOfString:obj].location !=NSNotFound) {
                BOOL append = false;
                if ([self.param.wDateTimeType rangeOfString:formatDic[obj]].location !=NSNotFound) {
                    append = YES;
                    str = [NSString stringWithFormat:@"%@%@",dateDic[obj],formatDic[obj]];
                }
                NSArray *data = nil;
                NSMutableDictionary *mdic = [NSMutableDictionary new];
                if ([obj isEqualToString:@"yyyy"]) {
                    if (self.minDate && self.minDate[@"yyyy"]) {
                        [mdic setObject:self.minDate[@"yyyy"] forKey:@"min"];
                    }
                    if (self.maxDate && self.maxDate[@"yyyy"]) {
                        [mdic setObject:self.maxDate[@"yyyy"] forKey:@"max"];
                    }
                }
                  
                if([obj isEqualToString:@"dd"]){
                    NSArray *arr = @[[NSString stringWithFormat:@"%ld",(long)[components year]],[NSString stringWithFormat:@"%ld",(long)[components month]]];
                    SuppressPerformSelectorLeakWarning(
                        data = [self performSelector:NSSelectorFromString(self.dateConfigInfo[obj]) withObject:arr withObject:@{}];);
                }else{
                    SuppressPerformSelectorLeakWarning(
                        data =  [self performSelector:NSSelectorFromString(self.dateConfigInfo[obj]) withObject:mdic];
                      );
                  }
                if(data){
                   [self.param.wData addObject:data];
                   [self.selectArr addObject:str];
                }
            }
          }
          
        [self updateTime:nil component:@(0)];
        for (int i = 0; i<self.selectArr.count; i++) {
            NSArray *arr =  self.param.wData[i];
            NSString *value = self.selectArr[i];
            NSInteger index = [arr indexOfObject:value];
            if (index<arr.count) {
                [self.pickView selectRow:index+(self.param.wPickRepeat?(pickViewCount/2*arr.count):0) inComponent:i animated:YES];
                if ((self.param.wMinDate||self.param.wMaxDate)&&i!=self.selectArr.count-1) {
                    [self updateTime:@(index) component:@(i)];
                }
            }
        }
        [self addTopView];
        self.pickView.frame =  CGRectMake(0, self.headView?CGRectGetMaxY(self.headView.frame):0, self.param.wWidth, self.param.wHeight);
        [self addSubview:self.pickView];
    }else if (self.param.wType == DialogTypeCalander){
        if (self.param.wWidth == DialogRealW(500)) self.param.wWidth = DialogScreenW;
        if (CGSizeEqualToSize(self.param.wCalanderCellSize, CGSizeZero)){
            CGFloat size = floor((self.param.wWidth) / (self.param.wCalanderWeekTitleArr.count * 1.0));
            self.param.wCalanderCellSize = CGSizeMake(size, size);
        }else{
            CGFloat sizeW = floor(self.param.wCalanderCellSize.width);
            CGFloat sizeH = floor(self.param.wCalanderCellSize.height);
            self.param.wCalanderCellSize = CGSizeMake(sizeW, sizeH);
            self.param.wWidth = self.param.wCalanderCellSize.width * 7;
        }
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
          
        NSDate *currentDate = self.param.wDefaultDate;
        self.currentYear = [NSDate year:currentDate];
        self.currentMonth = [NSDate month:currentDate];
        self.currentDay = [NSDate day:currentDate];
        self.today = [NSString stringWithFormat:@"%ld-%ld-%ld",(long)self.currentYear,(long)self.currentMonth,(long)self.currentDay];
          
        //默认带圆点的日期
        if (self.param.wDateShowCircle) {
              NSMutableArray *arr = [NSMutableArray new];
              for (id data in self.param.wDateShowCircle) {
                  if ([data isKindOfClass:[NSDictionary class]]) {
                      NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:data];
                      if ([dic[@"date"] isKindOfClass:[NSDate class]]) {
                          NSDate *date = dic[@"date"];
                          NSString *strDate = [dateFormatter stringFromDate:date];
                          [dic setObject:strDate forKey:@"date"];
                          [self.tempArr addObject:strDate];
                      }
                      [arr addObject:dic];
                  }else if ([data isKindOfClass:[NSDate class]]){
                       NSString *strDate = [dateFormatter stringFromDate:data];
                      [arr addObject:@{@"date":strDate}];
                      [self.tempArr addObject:strDate];
                  }
              }
              self.param.wDateShowCircle = [NSArray arrayWithArray:arr];
          }
          

          self.headView = [self addTopView];

          UIView *headView = [UIView new];
          
          UIView *titleView = [UIView new];
          [titleView addSubview:self.textLabel];
          self.textLabel.frame = CGRectMake((self.param.wWidth-100)/2 , 0, 100, 40);
          self.textLabel.textAlignment = NSTextAlignmentCenter;
          UITapGestureRecognizer *textTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(textAction)];
          self.textLabel.userInteractionEnabled = YES;
          [self.textLabel addGestureRecognizer:textTap];
          titleView.frame = CGRectMake(0, 0, self.param.wWidth, self.param.wMessage ? self.textLabel.frame.size.height:40);
          
          NSString *left = [[WMZDialogUntils getMainBundle] pathForResource:@"dia_right" ofType:@"png"];
          NSString *right = [[WMZDialogUntils getMainBundle] pathForResource:@"dia_left" ofType:@"png"];
          UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
          leftBtn.frame = CGRectMake(CGRectGetMinX(self.textLabel.frame)-self.param.wMainOffsetX*2 - 40, 0, 40, titleView.frame.size.height);
          [leftBtn setImage:[[UIImage imageWithContentsOfFile:left] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
          [leftBtn addTarget:self action:@selector(lastValue) forControlEvents:UIControlEventTouchUpInside];
          
          UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
          [rightBtn addTarget:self action:@selector(nextValue) forControlEvents:UIControlEventTouchUpInside];
          [rightBtn setImage:[[UIImage imageWithContentsOfFile:right] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
          rightBtn.frame = CGRectMake(CGRectGetMaxX(self.textLabel.frame)+self.param.wMainOffsetX*2, 0, 40, titleView.frame.size.height);
          leftBtn.imageView.tintColor =  rightBtn.imageView.tintColor = self.param.wThemeColor;
          
          [titleView addSubview:leftBtn];
          [titleView addSubview:rightBtn];;
          [headView addSubview:titleView];
          leftBtn.hidden = self.param.wHideCalanderBtn;
          rightBtn.hidden = self.param.wHideCalanderBtn;
          
          for (int i = 0; i < self.param.wCalanderWeekTitleArr.count; i++) {
              UILabel *weekTitleLable = [[UILabel alloc]initWithFrame:CGRectMake(i * ((self.param.wWidth/(self.param.wCalanderWeekTitleArr.count))), CGRectGetMaxY(titleView.frame), self.param.wWidth/(self.param.wCalanderWeekTitleArr.count), 40)];
              if (i == 0 || i == 6) {
                  weekTitleLable.textColor = self.param.wThemeColor;
              }
              weekTitleLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:15.0];
              weekTitleLable.text = [self.param.wCalanderWeekTitleArr objectAtIndex:i];
              weekTitleLable.textAlignment = NSTextAlignmentCenter;
              [headView addSubview:weekTitleLable];
          }
          headView.frame = CGRectMake(0, self.headView?CGRectGetMaxY(self.headView.frame):0, self.param.wWidth, 40+titleView.frame.size.height);
          [self addSubview:headView];
          
          self.layout = [[UICollectionViewFlowLayout alloc]init];
          self.layout.minimumLineSpacing = 0;
          self.layout.minimumInteritemSpacing = 0;
          self.layout.scrollDirection = self.param.wDirectionVertical ? UICollectionViewScrollDirectionVertical : UICollectionViewScrollDirectionHorizontal;
          self.layout.itemSize = self.param.wCalanderCellSize;
          CGFloat marginL = MAX(0, (self.param.wWidth - self.layout.itemSize.width * 7) / 2.0);
          self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(marginL ,CGRectGetMaxY(headView.frame) + self.param.wMainOffsetY, self.layout.itemSize.width * 7, self.layout.itemSize.height * 6) collectionViewLayout:self.layout];
          self.collectionView.backgroundColor = DialogDarkOpenColor(DialogColor(0xffffff), WMZDialogManage.shareInstance.darkColorInfo[DialogDarkMainColor],self.param.wOpenDark);
          [self.collectionView registerClass:[WMZDialogCollectionCell class] forCellWithReuseIdentifier:@"WMZDialogCollectionCell"];
          [self.collectionView registerClass:[WMZDialogCalanderCell class] forCellWithReuseIdentifier:@"WMZDialogCalanderCell"];
          if (self.param.wReginerCollectionCell) {
              [self.collectionView registerClass:[NSClassFromString(self.param.wReginerCollectionCell) class] forCellWithReuseIdentifier:self.param.wReginerCollectionCell];
          }
          self.collectionView.delegate = self;
          self.collectionView.showsHorizontalScrollIndicator = NO;
          self.collectionView.showsVerticalScrollIndicator = NO;
          self.collectionView.dataSource = self;
          self.collectionView.bounces = self.param.wBounces;
          self.collectionView.pagingEnabled = YES;
          self.collectionView.scrollEnabled = self.param.wCalanderCanScroll;
          [self addSubview:self.collectionView];
          if (@available(iOS 11.0, *)) {
              self.collectionView.contentInsetAdjustmentBehavior = NO;
          }
        [self setUpDays:NO];
          self.selectDate = YES;
    }
}

- (UIRectCorner)mz_setupCorner{
    return UIRectCornerTopLeft |UIRectCornerTopRight;
}

- (CGRect)mz_setupRect{
    CGRect rect = CGRectZero;
    if (self.param.wType == DialogTypeDatePicker) {
        rect =  CGRectMake(0, 0, self.param.wWidth, CGRectGetMaxY(self.pickView.frame));
    }else if (self.param.wType == DialogTypeCalander){
        rect = CGRectMake(0,0,self.param.wWidth, CGRectGetMaxY(self.collectionView.frame));
    }
    self.frame = rect;
    return rect;
}

#pragma -mark 日期
- (NSArray*)timeYearData:(NSDictionary*)limitDic{
    NSString *name = [self.param.wDateTimeType containsString:@"年"]?@"年":@"";
    int min = 1;
    int max = 3000;
    if (limitDic && limitDic[@"min"]) {
        min = [limitDic[@"min"] intValue];
    }
    if (limitDic && limitDic[@"max"]) {
        max = [limitDic[@"max"] intValue];
    }
    NSMutableArray *year = [NSMutableArray new];
    for (int i = min; i<= max; i++) {
        [year addObject:[NSString stringWithFormat:@"%d%@",i,name]];
    }
    return [NSArray arrayWithArray:year];
}

- (NSArray*)timeMonthData:(NSDictionary*)limitDic{
    NSString *name = [self.param.wDateTimeType containsString:@"月"]?@"月":@"";
    int min = 1;
    int max = 12;
    if (limitDic && limitDic[@"min"]) {
        min = [limitDic[@"min"] intValue];
    }
    if (limitDic && limitDic[@"max"]) {
        max = [limitDic[@"max"] intValue];
    }
    
    NSMutableArray *month = [NSMutableArray new];
    for (int i = min; i<= max;i++ ) {
        [month addObject:[NSString stringWithFormat:@"%02d%@",i,name]];
    }
    return [NSArray arrayWithArray:month];
}

- (NSArray*)timeHourData:(NSDictionary*)limitDic{
    NSString *name = [self.param.wDateTimeType containsString:@"时"]?@"时":@"";
    int min = 0;
    int max = 23;
    if (limitDic && limitDic[@"min"]) {
        min = [limitDic[@"min"] intValue];
    }
    if (limitDic && limitDic[@"max"]) {
        max = [limitDic[@"max"] intValue];
    }
    NSMutableArray *hour = [NSMutableArray new];
    for (int i = min; i<= max; i++) {
        [hour addObject:i<10?[NSString stringWithFormat:@"0%d%@",i,name]:[NSString stringWithFormat:@"%d%@",i,name]];
    }
    return [NSArray arrayWithArray:hour];
}

- (NSArray*)timeMinData:(NSDictionary*)limitDic{
     NSString *name = [self.param.wDateTimeType containsString:@"分"]?@"分":@"";
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
        [minArr addObject:[NSString stringWithFormat:@"%02d%@",i,name]];
    }
    return [NSArray arrayWithArray:minArr];
}

- (NSArray*)timeSecondData:(NSDictionary*)limitDic{
    NSString *name = [self.param.wDateTimeType containsString:@"秒"]?@"秒":@"";
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
        [second addObject:[NSString stringWithFormat:@"%02d%@",i,name]];
    }
    return [NSArray arrayWithArray:second];
}

- (NSArray*)timeDayWithArr:(NSArray*)arr Data:(NSDictionary*)limitDic{
    NSString *name = [self.param.wDateTimeType containsString:@"日"]?@"日":@"";
    int day = 0 ;
    NSMutableArray *dayArr = [NSMutableArray new];
    if (!arr || arr.count<1) {
        ///数据不规范的当做30天处理
        day = 30;
    }else{
        NSString *year = arr[0];
        NSString *month = arr[1];
        BOOL isLeapYear = false;
        NSInteger yearInfo = year.integerValue;
        if((yearInfo % 400 == 0) || ((yearInfo % 4 == 0) && (yearInfo % 100 != 0))){
            isLeapYear = true ;
        }
        NSArray *dayCountArr = @[@"31",isLeapYear? @"29":@"28",@"31",@"30",@"31",@"30",@"31",@"31",@"30",@"31",@"30",@"31"];
        day = [dayCountArr[month.integerValue-1] intValue];
    }
    
    int min = 1;
    int max = day;
    if (limitDic && limitDic[@"min"]) {
        min = [limitDic[@"min"] intValue];
    }
    if (limitDic && limitDic[@"max"]) {
        max = [limitDic[@"max"] intValue];
    }
    
    for (int i = min; i <= max ; i++ ) {
        [dayArr addObject:[NSString stringWithFormat:@"%02d%@",i,name]];
    }
    
    return [NSArray arrayWithArray:dayArr];
}

/// 更新时间
- (void)updateTime:(NSNumber*)rowNum component:(NSNumber*)componentNum{
    if (self.maxDate||self.minDate) {
        NSInteger component = [componentNum integerValue];
        ///包含正确参数
        BOOL trueCongig = YES;
        ///防止越界
        if (component +1 >= [(NSArray*)self.param.wData count]) {
            trueCongig = NO;
        }
        ///判断date的typeConfig时候全面
        if (trueCongig) {
            for (int i = 0; i<=(component+1); i++) {
                NSString *type = self.dateConfigArr[i];
                if ([self.param.wDateTimeType rangeOfString:type].location == NSNotFound ) {
                    trueCongig = NO;break;
                }
            }
        }
        if (trueCongig) {
            //更新后面的所有列
            for (NSInteger k = component+1; k<[(NSArray*)self.param.wData count]; k++) {
                NSString *nextType = self.dateConfigArr[k];
                BOOL minLimit = YES;
                BOOL maxLimit = YES;
                NSMutableDictionary *mdic = [NSMutableDictionary new];
                NSCharacterSet* nonDigits =[[NSCharacterSet decimalDigitCharacterSet] invertedSet];
                //需要比较的时间
                NSMutableArray *compareDateArr = [NSMutableArray new];
                NSMutableArray *dateTypeArr = [NSMutableArray new];
                for (int i = 0; i<=k-1; i++) {
                    int tmpDateConfig = 0;
                    NSArray *tmpDateConfigArr = self.param.wData[i];
                    NSInteger yearIndex = [self.pickView selectedRowInComponent:i];
                    NSInteger index = MIN((self.param.wPickRepeat?yearIndex%tmpDateConfigArr.count:yearIndex), (self.param.wPickRepeat?(tmpDateConfigArr.count-1)%tmpDateConfigArr.count:(tmpDateConfigArr.count-1)));
                    tmpDateConfig =[[tmpDateConfigArr[index] stringByTrimmingCharactersInSet:nonDigits] intValue];
                    [compareDateArr addObject:@(tmpDateConfig)];
                    [dateTypeArr addObject:self.dateConfigArr[i]];
                }
                NSMutableArray *yearMontharr = [NSMutableArray new];
                for (int i = 0; i<compareDateArr.count; i++) {
                    int dateConfig = [compareDateArr[i] intValue];
                    NSString *dateType = dateTypeArr[i];
                    if (self.minDate && self.minDate[dateType]) {
                        if (dateConfig >[self.minDate[dateType] intValue]) {
                            minLimit = NO;
                        }
                    }
                    if (self.maxDate && self.maxDate[dateType]) {
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
                        self.param.wData[k] = [self performSelector:NSSelectorFromString(self.dateConfigInfo[nextType])  withObject:[NSArray arrayWithArray:yearMontharr] withObject:[NSDictionary dictionaryWithDictionary:mdic]];
                    );
                }else{
                    SuppressPerformSelectorLeakWarning(
                    self.param.wData[k] = [self performSelector:NSSelectorFromString(self.dateConfigInfo[nextType])  withObject:[NSDictionary dictionaryWithDictionary:mdic]];
                    );
                }
                [self.pickView reloadComponent:k];
            }
        }
    }
}
/// 确定事件
- (void)confirmAction:(WMZDialogButton*)sender{
    @DialogWeakify(self)
    if (self.param.wType == DialogTypeDatePicker) {
        [[WMZDialogManage.shareInstance currentDialog:self] closeView:^{
          @DialogStrongify(self)
          if (self.param.wEventOKFinish) {
              NSMutableArray *mArr = [NSMutableArray new];
              NSMutableArray *orginArr = [NSMutableArray new];
              NSMutableString *dateStr = [NSMutableString stringWithString:self.param.wDateTimeType];
              for (int i = 0; i<[self.param.wData count]; i++) {
              NSArray *arr = self.param.wData[i];
              NSString *str = arr [self.param.wPickRepeat?[self.pickView selectedRowInComponent:i]%arr.count:[self.pickView selectedRowInComponent:i]];
              [orginArr addObject:str];
              NSCharacterSet* nonDigits =[[NSCharacterSet decimalDigitCharacterSet] invertedSet];
              NSString * remainSecond = [str stringByTrimmingCharactersInSet:nonDigits];
              [mArr addObject:remainSecond];
            }
            NSMutableArray *containArr = [NSMutableArray new];
            for (NSString *str in self.dateConfigArr) {
                if ([self.param.wDateTimeType rangeOfString:str].location!=NSNotFound) {
                    [containArr addObject:str];
                }
            }
            for (int i = 0; i<containArr.count; i++) {
                NSString *containStr = containArr[i];
                NSString *value = mArr[i];
                [dateStr replaceCharactersInRange:[dateStr rangeOfString:containStr] withString:value];
            }
            self.param.wEventOKFinish(mArr, dateStr);
        }
     }];
    }else if(self.param.wType == DialogTypeCalander){
        NSMutableArray *marrStr = [NSMutableArray new];
        NSMutableArray *marrModel = [NSMutableArray new];
        NSMutableArray *rangeArr = [NSMutableArray new];
        if (self.param.wMultipleSelection&&self.selectArr.count>0) {
            [self.selectArr enumerateObjectsUsingBlock:^(WMZCalanderModel*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [marrStr addObject:obj.dateStr];
                [marrModel addObject:obj];
            }];
        }
        [[WMZDialogManage.shareInstance currentDialog:self] closeView:^{
            @DialogStrongify(self)
            if (self.param.wEventOKFinish) {
                if (self.param.wMultipleSelection) {
                    if (self.selectArr.count) {
                        if (self.selectArr.count == 1) {
                            WMZCalanderModel *tempModel = self.selectArr.firstObject;
                            NSString *str = tempModel.dateStr;
                            self.param.wEventOKFinish(str, marrModel);
                        }else if (self.selectArr.count >= 2){
                            if (self.param.wOpenMultiZone) {
                                [self.pathArr enumerateObjectsUsingBlock:^(NSArray *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                                    if ([obj isKindOfClass:[NSArray class]]) {
                                        if (obj.count == 1) {
                                            WMZCalanderModel *tempModel = obj.firstObject;
                                            NSString *rangeStr =  tempModel.dateStr;
                                            [rangeArr addObject:rangeStr];
                                        }else if (obj.count >= 2){
                                            WMZCalanderModel *firstModel = obj.firstObject;
                                            WMZCalanderModel *lastModel = obj.lastObject;
                                            NSString *beganStr = firstModel.dateStr;
                                            NSString *endStr =  lastModel.dateStr;
                                            [rangeArr addObject:[NSString stringWithFormat:@"%@ - %@",beganStr,endStr]];
                                        }
                                    }
                                }];
                                self.param.wEventOKFinish(rangeArr, self.pathArr);
                            }else{
                                WMZCalanderModel *firstModel = self.selectArr.firstObject;
                                WMZCalanderModel *lastModel = self.selectArr.lastObject;
                                NSString *began = firstModel.dateStr;
                                NSString *end = lastModel.dateStr;
                                self.param.wEventOKFinish([NSString stringWithFormat:@"%@ - %@",began,end], marrModel);
                            }
                        }
                    }else{
                        self.param.wEventOKFinish(@"暂无选中", nil);
                    }
                }else{
                    if (self.selecctWMZCalanderModel) {
                        self.param.wEventOKFinish(self.selecctWMZCalanderModel.dateStr, self.selecctWMZCalanderModel);
                    }else{
                        self.param.wEventOKFinish(@"暂无选中", nil);
                    }
                }
            };
        }];
    }
}

#pragma -mark 日历
- (void)setUpDays:(BOOL)changeDate{
    NSInteger lastTotalNum = 0;
    NSInteger nextTotalNum = 0;
    NSInteger index = 0;
    self.dataArr = [NSMutableArray new];
    for (int i = 0; i < NumberMounthes ; i++ ) {
        index = i;
        NSMutableArray *array = [NSMutableArray new];
        [self.dataArr addObject:array];
        BOOL resultLast =  [self updateDateYear:self.currentYear Month:self.currentMonth-i-1 index:self.dataArr.count - 1];
        if(resultLast) lastTotalNum += 1;
    }
    [self.dataArr  sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return NSOrderedDescending;
    }];
    
    NSMutableArray *array = [NSMutableArray new];
    [self.dataArr addObject:array];
    BOOL resultCurrent = [self updateDateYear:self.currentYear Month:self.currentMonth index:self.dataArr.count - 1];
    
    for (int i = 0; i < NumberMounthes ; i++ ) {
        index += i;
        NSMutableArray *array = [NSMutableArray new];
        [self.dataArr addObject:array];
        BOOL resultNext = [self updateDateYear:self.currentYear Month:self.currentMonth+i+1 index:self.dataArr.count - 1];
        if(resultNext) nextTotalNum += 1;
    }
    self.currentIndex = NumberMounthes;
    if(lastTotalNum < NumberMounthes || nextTotalNum < NumberMounthes || !resultCurrent){
        WMZCalanderModel *firstModel = nil;
        if(!changeDate){
            self.currentIndex = 0;
            if(self.dataArr.count){
                for (WMZCalanderModel *tmpModel in self.dataArr.firstObject) {
                    if(!tmpModel.wLastMonth && !tmpModel.wNextMonth){
                        firstModel = tmpModel;
                        self.currentYear = tmpModel.wYear;
                        self.currentMonth = tmpModel.wMonth;
                        self.currentDay = tmpModel.wDay;
                        break;
                    }
                }
            }
        }else{
            for (NSArray <WMZCalanderModel*>* tmpArr in self.dataArr) {
                for (WMZCalanderModel *tmpModel in tmpArr) {
                    if(!tmpModel.wLastMonth && !tmpModel.wNextMonth){
                        if(tmpModel.wYear == self.currentYear && tmpModel.wMonth == self.currentMonth){
                            self.currentIndex = [self.dataArr indexOfObject:tmpArr];
                            break;
                        }
                    }
                }
            }
        }
    }
    [self scrollIndexPath:self.currentIndex shouldReloadData:YES animal:NO first:YES];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [(NSArray*)[self.dataArr objectAtIndex:section] count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WMZCalanderModel *model = self.dataArr[indexPath.section][indexPath.row];
    if (self.param.wCalanderCell)
        return self.param.wCalanderCell(indexPath,collectionView,model);
    
    BOOL hidden = NO;
    if([self.param.wMinMaxResultArr indexOfObject:DialogCalanderLimitHide] != NSNotFound &&
       !model.wInRange){
        hidden = YES;
    }
    BOOL gray = NO;
    if([self.param.wMinMaxResultArr indexOfObject:DialogCalanderLimitGray] != NSNotFound &&
       !model.wInRange){
        gray = YES;
    }
    WMZDialogCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.param.wOpenChineseDate?@"WMZDialogCollectionCell":@"WMZDialogCalanderCell"  forIndexPath:indexPath];
    cell.dateLable.text = [NSString stringWithFormat:@"%ld",(long)model.wDay];
    cell.chineseLable.text = model.wChineseDate;
    UIColor *color =  DialogDarkOpenColor(DialogColor(0xffffff), WMZDialogManage.shareInstance.darkColorInfo[DialogDarkMainColor],self.param.wOpenDark);
    CGSize radio = CGSizeZero;
    CGFloat alpah = 1;
    UIRectCorner corner = UIRectCornerAllCorners;
    cell.contentView.hidden = hidden;
    /// 不可选中的部分
    if (model.wLastMonth||model.wNextMonth) {
        cell.circleLabel.text = @"";
        cell.dateLable.textColor = DialogDarkOpenColor(DialogColor(0xD9D9D9), DialogColor(0x666666),self.param.wOpenDark);
        cell.chineseLable.textColor = model.wHadHolday? DialogColor(0xFFCCCC):
        DialogDarkOpenColor(DialogColor(0xD3D3D3), DialogColor(0x999999),self.param.wOpenDark);
    }else{
        if (model.wShowCircle) {
            cell.circleLabel.text = @"●";
        }else{
            cell.circleLabel.text = @"";
        }
        cell.circleLabel.textColor = model.wCircleColor?:self.param.wThemeColor;
        /// 被选中
        if (model.wSelected) {
            cell.dateLable.textColor = DialogColor(0xFFFFFF);
            cell.chineseLable.textColor = DialogColor(0xFFFFFF);
            alpah = self.param.wLimitAlpha;
            color = self.param.wThemeColor;
            if (model.firstModel && !model.lastModel) {
                alpah = 1;
                radio = CGSizeMake(self.param.wCalanderCellSize.height* 0.5, self.param.wCalanderCellSize.height* 0.5);
                corner = UIRectCornerTopLeft|UIRectCornerBottomLeft;
            }else if (model.lastModel && !model.firstModel) {
                radio = CGSizeMake(self.param.wCalanderCellSize.height * 0.5, self.param.wCalanderCellSize.height* 0.5);
                corner = UIRectCornerTopRight|UIRectCornerBottomRight;
                alpah = 1;
            }else if (!model.lastModel && !model.firstModel) {
                radio = CGSizeMake(self.param.wCalanderCellSize.height * 0.5, self.param.wCalanderCellSize.height * 0.5);
                corner = UIRectCornerAllCorners;
                alpah = 1;
            }
        }else{
            if ([[NSString stringWithFormat:@"%ld-%ld-%ld",(long)model.wYear,(long)model.wMonth,(long)model.wDay] isEqualToString:self.today]) {
                cell.dateLable.textColor = self.param.wThemeColor;
                cell.chineseLable.textColor = self.param.wThemeColor;
            }else{
                /// 正常
                cell.dateLable.textColor = DialogDarkOpenColor(DialogColor(0x333333), DialogColor(0xffffff),self.param.wOpenDark);
                cell.chineseLable.textColor = model.wHadHolday?[UIColor redColor]:DialogDarkOpenColor(DialogColor(0x666666), DialogColor(0xffffff),self.param.wOpenDark);;
            }
        }
        if(gray){
            color =  DialogDarkOpenColor(DialogColor(0xffffff), WMZDialogManage.shareInstance.darkColorInfo[DialogDarkMainColor],self.param.wOpenDark);
            cell.dateLable.textColor = DialogDarkOpenColor(DialogColor(0xD9D9D9), DialogColor(0x666666),self.param.wOpenDark);
            cell.chineseLable.textColor = model.wHadHolday? DialogColor(0xFFCCCC):
            DialogDarkOpenColor(DialogColor(0xD3D3D3), DialogColor(0x999999),self.param.wOpenDark);
        }
    }
    cell.contentView.backgroundColor = color;
    cell.contentView.alpha = alpah;
    [WMZDialogUntils setCornerView:cell.contentView radio:radio rectCorner:corner];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    WMZCalanderModel *model = self.dataArr[indexPath.section][indexPath.row];
    if (!model.wInRange &&
        [self.param.wMinMaxResultArr indexOfObject:DialogCalanderLimitCloseClick] != NSNotFound) return;
    if (model.wLastMonth||model.wNextMonth) return;
    if (!self.param.wMultipleSelection) {
        if (self.selecctWMZCalanderModel!=model)
            self.selecctWMZCalanderModel.wSelected = NO;
    }
    model.wSelected = !model.wSelected;
    NSInteger deleteIndex = NSNotFound;
    if (self.param.wMultipleSelection) {
        if (model.wSelected) {
            if ([self.selectTimeArr indexOfObject:model.dateStr] == NSNotFound && [self.selectArr indexOfObject:model] == NSNotFound)
                [self.selectArr addObject:model];
        }else{
            deleteIndex = [self.selectArr indexOfObject:model];
            if (deleteIndex != NSNotFound )
               [self.selectArr removeObject:model];
        }
        [self changeSelect:model];
        
    }
    if (self.param.wCalanderCellClick) {
        self.param.wCalanderCellClick(indexPath,collectionView,model);
    }
    self.selecctWMZCalanderModel = model;
    [UIView performWithoutAnimation:^{
       [self.collectionView reloadData];
    }];
}

- (void)changeSelect:(WMZCalanderModel*)model{
    if (!self.param.wOpenMultiZone){
        if (self.selectArr.count > 2 && model) {
            [self.selectArr enumerateObjectsUsingBlock:^(WMZCalanderModel*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                obj.wSelected = NO;
                obj.firstModel = YES;
                obj.lastModel = YES;
            }];
            [self.selectArr removeAllObjects];
            model.wSelected = YES;
            model.firstModel = NO;
            model.lastModel = NO;
            if ([self.selectTimeArr indexOfObject:model.dateStr] == NSNotFound && [self.selectArr indexOfObject:model] == NSNotFound) {
                [self.selectArr addObject:model];
            }
        }
        if (self.selectArr.count == 1) {
            if (!model) {
                model = self.selectArr.firstObject;
            }
            model.firstModel = NO;
            model.lastModel = NO;
        }else if (self.selectArr.count >= 2) {
            [self.selectArr sortUsingComparator:^NSComparisonResult(WMZCalanderModel*  _Nonnull obj1, WMZCalanderModel*  _Nonnull obj2) {
                 return obj1.dateTime > obj2.dateTime;
            }];
            WMZCalanderModel *firstModel = self.selectArr.firstObject;
            WMZCalanderModel *lastModel = self.selectArr.lastObject;
            firstModel.firstModel = YES;
            firstModel.lastModel = NO;
            lastModel.firstModel = NO;
            lastModel.lastModel = YES;
            [self.dataArr enumerateObjectsUsingBlock:^(NSArray*  _Nonnull sectionData, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([sectionData isKindOfClass:[NSArray class]]) {
                    [sectionData enumerateObjectsUsingBlock:^(WMZCalanderModel*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        if ([obj isKindOfClass:[WMZCalanderModel class]]) {
                            if (obj.dateTime > firstModel.dateTime &&
                                obj.dateTime < lastModel.dateTime &&
                                !obj.wLastMonth &&
                                !obj.wNextMonth) {
                                obj.wSelected = YES;
                                obj.firstModel = YES;
                                obj.lastModel = YES;
                                if ([self.selectTimeArr indexOfObject:obj.dateStr] == NSNotFound &&
                                    [self.selectArr indexOfObject:obj] == NSNotFound) {
                                    [self.selectArr addObject:obj];
                                }
                            }
                        }
                    }];
                }
            }];
            [self.selectArr sortUsingComparator:^NSComparisonResult(WMZCalanderModel*  _Nonnull obj1, WMZCalanderModel*  _Nonnull obj2) {
                 return obj1.dateTime > obj2.dateTime;
            }];
        }
        self.pathArr = [NSMutableArray arrayWithArray:self.selectArr];
    }else{
        [self.selectArr sortUsingComparator:^NSComparisonResult(WMZCalanderModel*  _Nonnull obj1, WMZCalanderModel*  _Nonnull obj2) {
            return obj1.dateTime > obj2.dateTime;
        }];
        WMZCalanderModel *lastModel = nil;
        NSMutableArray *lastArr = nil;
        self.pathArr = [NSMutableArray new];
        for (WMZCalanderModel *model in self.selectArr) {
            NSMutableArray *marr = nil;
            if (!lastModel) {
                marr = [NSMutableArray new];
                [marr addObject:model];
            }else{
                if (model.dateTime - lastModel.dateTime == 86400 ||
                    model.dateTime - lastModel.dateTime == 86400) {
                    [lastArr addObject:model];
                }else{
                    marr = [NSMutableArray new];
                    [marr addObject:model];
                }
            }
            lastModel = model;
            if (marr) {
                lastArr = marr;
                [self.pathArr addObject:marr];
            }
        }
        [self.pathArr enumerateObjectsUsingBlock:^(NSArray<WMZCalanderModel*>*  _Nonnull arr, NSUInteger idx, BOOL * _Nonnull stop) {
            [arr enumerateObjectsUsingBlock:^(WMZCalanderModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (arr.count == 1) {
                    obj.firstModel = NO;
                    obj.lastModel = NO;
                }else{
                    if (idx == 0) {
                        obj.firstModel = YES;
                        obj.lastModel = NO;
                    }else if(idx == arr.count - 1){
                        obj.firstModel = NO;
                        obj.lastModel = YES;
                    }else{
                        obj.firstModel = YES;
                        obj.lastModel = YES;
                    }
                }
            }];
        }];
    }
}

/// 手动拖动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self loadDataScrollView:scrollView];
}

/// 点击上下月
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [self loadDataScrollView:scrollView];
}

/// 预加载
- (void)loadDataScrollView:(UIScrollView*)scrollView{
    if (scrollView != self.collectionView) return;
    int index = round(self.param.wDirectionVertical?(scrollView.contentOffset.y/scrollView.frame.size.height):(scrollView.contentOffset.x/scrollView.frame.size.width));
    if (index < 0 || index > self.dataArr.count-1) return;
    NSMutableArray *arr = self.dataArr[index];
    self.currentIndex = index;
    for (WMZCalanderModel *model in arr) {
        if (!model.wLastMonth&&!model.wNextMonth){
            self.currentYear = model.wYear;
            self.currentMonth = model.wMonth;
            self.currentDay = model.wDay;
            break;
        }
    }
    /// 首个或者最后一个 预加载上个和下个
    if (self.currentIndex  == 0 || self.currentIndex  == self.dataArr.count - 1 ) {
        NSMutableArray *arr = [NSMutableArray new];
        if (self.currentIndex  == 0) {
            [self.dataArr insertObject:arr atIndex:0];
        }else{
            [self.dataArr addObject:arr];
        }
        [self updateDateYear:self.currentYear Month:self.currentIndex  == 0?(self.currentMonth-1):(self.currentMonth+1) index: (self.currentIndex == 0)?  0: (self.dataArr.count-1)];
        if([self.param.wMinMaxResultArr indexOfObject:DialogCalanderLimitCloseScroll] != NSNotFound){
            if(self.currentYear == [NSDate year:self.param.wMinDate] && self.currentMonth == [NSDate month:self.param.wMinDate] ){
                return;
            }
            if (self.currentIndex == 0) {
                [self scrollIndexPath:1 shouldReloadData:NO animal:NO first:NO];
            }
        }else{
            if (self.currentIndex == 0) {
                [self scrollIndexPath:1 shouldReloadData:NO animal:NO first:NO];
            }
        }
        [UIView performWithoutAnimation:^{
            [self.collectionView reloadData];
        }];
    }
}

/// lastValue
- (void)lastValue{
    self.currentIndex-=1;
    if (self.currentIndex < 0) {
        self.currentIndex = 0;
    }
    [self scrollIndexPath:self.currentIndex shouldReloadData:NO animal:YES first:NO];
    
}

/// nextValue
- (void)nextValue{
    self.currentIndex+=1;
    if (self.currentIndex >= self.dataArr.count) {
        self.currentIndex = self.dataArr.count-1;
    }
    [self scrollIndexPath:self.currentIndex shouldReloadData:NO animal:YES first:NO];

}
/// 更新数据
- (BOOL)updateDateYear:(NSInteger)year Month:(NSInteger)month index:(NSInteger)index{
    BOOL result = YES;
    if (self.dataArr.count <= index) return NO;
    [[self.dataArr objectAtIndex:index] removeAllObjects];
    if (month > 12) {
        int num = (month / 12.0);
        month = month - (num + 1) * 12 ;
        year += (num + 1);
    }
    if (month < 1) {
        int num = (month / -12);
        month = month + (num + 1) * 12 ;
        year -= (num + 1);
    }
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    
    NSDateComponents *components = [[NSDateComponents alloc]init];
    components.month = month;
    components.year = year;
    components.day = 1;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *nowDate = [calendar dateFromComponents:components];
    
    nowDate = [nowDate dateByAddingTimeInterval: [zone secondsFromGMTForDate: nowDate]];
    if (components.month <= 1) {
        components.month = 12;
        components.year -= 1;
    }else{
        components.month -= 1;
    }
    NSDate *nextDate = [calendar dateFromComponents:components];
    nextDate = [nextDate dateByAddingTimeInterval: [zone secondsFromGMTForDate: nextDate]];
    NSInteger DaysInNextMonth = [NSDate totaldaysInMonth:nextDate];
    
    NSInteger firstDayInThisMounth = [NSDate firstWeekdayInThisMonth:nowDate];
    NSInteger daysInThisMounth = [NSDate totaldaysInMonth:nowDate];
    NSInteger tmpDay = 0;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];//解决8小时时间差问题
    NSInteger inRangeCount = 0;
    for (int j = 0; j < allCount ; j++) {
        NSInteger tmpYear = year;
        NSInteger tmpMonth = month;
        WMZCalanderModel *model = [WMZCalanderModel new];
        if (j < firstDayInThisMounth) {
            if (tmpMonth <= 1) {
                tmpMonth = 12;
                tmpYear -= 1;
            }else{
                tmpMonth -= 1;
            }
            tmpDay = DaysInNextMonth - firstDayInThisMounth + j + 1;
            model.wLastMonth = YES;
        }else if(j > daysInThisMounth + firstDayInThisMounth - 1){
            if (tmpMonth >= 12) {
                tmpMonth = 1;
                tmpYear += 1;
            }else{
                tmpMonth += 1;
            }
            tmpDay = j - (daysInThisMounth + firstDayInThisMounth - 1);
            model.wNextMonth = YES;
        }else{
            tmpDay = j - firstDayInThisMounth + 1;
        }
        NSString *detaMonth = [NSString stringWithFormat:@"%02ld",(long)tmpMonth];
        NSString *detaDay = [NSString stringWithFormat:@"%02ld",(long)tmpDay];
        NSString *dateStr = [NSString stringWithFormat:@"%ld-%@-%@",(long)tmpYear,detaMonth,detaDay];
        NSDate *myDate = [dateFormatter dateFromString:dateStr];
        NSDictionary *dic = [NSDate getChineseCalendarWithDate:myDate Year:tmpYear Month:tmpMonth Day:tmpDay];
        ///判断是否显示圆点
        if (self.param.wDateShowCircle&&!model.wLastMonth&&!model.wLastMonth) {
            NSUInteger index = [self.tempArr indexOfObject:dateStr];
            if (index!=NSNotFound) {
                model.wShowCircle = YES;
                NSDictionary *dic = self.param.wDateShowCircle[index];
                UIColor *color = dic[@"color"];
                if (color) {
                    model.wCircleColor = color;
                }
            }
        }
        model.wYear = tmpYear;
        model.wMonth = tmpMonth;
        model.wDay = tmpDay;
        model.wDate = myDate;
        model.wDetailChineseDate = dic[@"detail"];
        model.wHadHolday = [dic[@"holday"] boolValue];
        model.wIndex = self.param.wDirectionVertical? j : ( j % 7 * 6 + j / 7);
        model.wChineseDate = dic[@"name"];
        model.wInRange = [model checkModelWithMaxDate:self.param.wMaxDate minDate:self.param.wMinDate];
        if(!model.wInRange){
            inRangeCount += 1;
        }else{
            if(model.wNextMonth || model.wLastMonth){
                inRangeCount += 1;
            }
        }
        NSArray *compareArr = self.selectDate ? self.selectArr : self.param.wListDefaultValue;
        if(!DialogArrayNotEmpty(compareArr) && self.selecctWMZCalanderModel && !self.param.wMultipleSelection){
            compareArr = @[self.selecctWMZCalanderModel];
        }
        if (DialogArrayNotEmpty(compareArr)) {
            __block NSInteger count = 0;
            if (!model.wLastMonth && !model.wNextMonth) {
                [compareArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    BOOL result  = NO;
                    if ([obj isKindOfClass:[NSNumber class]]) {
                        result = ([obj doubleValue] == model.dateTime);
                    } else if ([obj isKindOfClass:[NSDate class]]) {
                        NSInteger year = [NSDate year:obj];
                        NSInteger month = [NSDate month:obj];
                        NSInteger day = [NSDate day:obj];
                        result = [model.dateStr isEqualToString:[NSString stringWithFormat:@"%ld-%ld-%ld",(long)year,(long)month,(long)day]];
                    } else if ([obj isKindOfClass:[NSString class]]) {
                        result = [model.dateStr isEqualToString:obj];
                    } else if ([obj isKindOfClass:[WMZCalanderModel class]]) {
                        WMZCalanderModel *compareModel = (WMZCalanderModel*)obj;
                        result = [model.dateStr isEqualToString:compareModel.dateStr];
                    }
                    if (result) {
                        if (self.param.wMultipleSelection) {
                            model.wSelected = YES;
                            if ([self.selectArr indexOfObject:model] == NSNotFound) {
                                if ([self.selectTimeArr indexOfObject:model.dateStr] == NSNotFound) {
                                    [self.selectArr addObject:model];
                                    count += 1;
                                }else{
                                    __block NSInteger index = NSNotFound;
                                    [self.selectArr enumerateObjectsUsingBlock:^(WMZCalanderModel*  _Nonnull objs, NSUInteger idxs, BOOL * _Nonnull stops) {
                                        if ([objs.dateStr isEqualToString:model.dateStr ]) {
                                            index = idxs;
                                            *stops = YES; return;
                                        }
                                    }];
                                    if (index != NSNotFound) {
                                        [self.selectArr replaceObjectAtIndex:index withObject:model];
                                        count += 1;
                                    }
                                }
                            }
                        }else{
                            if (self.selecctWMZCalanderModel) self.selecctWMZCalanderModel.wSelected = NO;
                            model.wSelected = YES;
                            self.selecctWMZCalanderModel = model;
                        }
                    }
                }];
                if (count) [self changeSelect:nil];
            }
        }
        [[self.dataArr objectAtIndex:index] insertObject:model atIndex:j];
    }
    if(inRangeCount == allCount && [self.param.wMinMaxResultArr indexOfObject:DialogCalanderLimitCloseScroll] != NSNotFound){
       [self.dataArr removeObjectAtIndex:index];
        result = NO;
    }
    if (!self.param.wDirectionVertical) {
        if(self.dataArr.count > index){
            NSMutableArray *arr = [self.dataArr objectAtIndex:index];
            [arr sortUsingComparator:^NSComparisonResult(WMZCalanderModel * _Nonnull obj1,  WMZCalanderModel * obj2) {
                return obj1.wIndex>obj2.wIndex;
            }];
        }
    }
    return result;
}

/// 刷新后滚动
- (void)scrollIndexPath:(NSInteger)section shouldReloadData:(BOOL)reloadData animal:(BOOL)animal first:(BOOL)first{
    if (reloadData) {
        [self.collectionView reloadData];
        [self.collectionView layoutIfNeeded];
    }
    if (self.param.wDirectionVertical) {
        [self.collectionView setContentOffset:CGPointMake(0, self.collectionView.frame.size.height*section) animated:animal];
    }else{
        [self.collectionView setContentOffset:CGPointMake(self.collectionView.frame.size.width*section, 0) animated:animal];
    }
    [self scrollViewDidEndDecelerating:self.collectionView];
}

/// 选择年份
- (void)textAction{
    @DialogWeakify(self)
    NSDateFormatter* formater = NSDateFormatter.new;
    [formater setDateFormat:@"yyyy-MM-dd"];
    Dialog()
     .wEventOKFinishSet(^(id anyID, id otherData) {
         @DialogStrongify(self)
         if (anyID &&
             [anyID isKindOfClass:NSArray.class] &&
             [(NSArray*)anyID count]) {
             NSInteger year = [((NSArray*)anyID)[0] integerValue];
             NSInteger month = [((NSArray*)anyID)[1] integerValue];
             if (year != self.currentYear || month != self.currentMonth) {
                 self.currentYear = year;
                 self.currentMonth = month;
                 self.currentDay = 1;
                 [self setUpDays:YES];
                 [self.collectionView reloadData];
             }
         }
     })
     .wDefaultDateSet([formater dateFromString:[NSString stringWithFormat:@"%ld-%ld-%ld",(long)self.currentYear,(long)self.currentMonth,(long)self.currentDay]])
     .wOKColorSet(self.param.wOKColor)
     .wCancelColorSet(self.param.wCancelColor)
     .wTitleSet(@"选择日期")
     .wMinDateSet(self.param.wMinDate)
     .wMaxDateSet(self.param.wMaxDate)
     .wTypeSet(DialogTypeDatePicker)
     .wDateTimeTypeSet(@"yyyy年MM月")
     .wStartView(self.superview);
}

- (void)setCurrentYear:(NSInteger)currentYear{
    _currentYear = currentYear;
    self.textLabel.text = [NSString stringWithFormat:@"%ld年%ld月",(long)currentYear,(long)self.currentMonth];
}

- (void)setCurrentMonth:(NSInteger)currentMonth{
    _currentMonth = currentMonth;
    self.textLabel.text = [NSString stringWithFormat:@"%ld年%ld月",(long)self.currentYear,(long)currentMonth];
}

- (NSArray<NSString *> *)dateConfigArr{
    if (!_dateConfigArr) {
        _dateConfigArr = @[@"yyyy",@"MM",@"dd",@"HH",@"mm",@"ss"];
    }
    return _dateConfigArr;
}

- (NSDictionary<NSString *,NSString *> *)dateConfigInfo{
    if (!_dateConfigInfo) {
        _dateConfigInfo = @{
        @"yyyy":@"timeYearData:",
        @"MM":@"timeMonthData:",
        @"dd":@"timeDayWithArr:Data:",
        @"HH":@"timeHourData:",
        @"mm":@"timeMinData:",
        @"ss":@"timeSecondData:",};
    }
    return _dateConfigInfo;
}

- (NSMutableArray<NSString *> *)selectTimeArr{
    _selectTimeArr = NSMutableArray.new;
    [self.selectArr enumerateObjectsUsingBlock:^(WMZCalanderModel*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [_selectTimeArr addObject:obj.dateStr];
    }];
    return _selectTimeArr;
}

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = NSMutableArray.new;
    }
    return _dataArr;
}

@end

@implementation WMZDialogCollectionCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self UI];
    }
    return self;
}

- (void)UI{
    CGRect frame =  self.frame;
    [self.contentView addSubview:self.dateLable];
    self.dateLable.frame = CGRectMake(0, self.contentView.frame.size.height*0.05, self.contentView.frame.size.width, self.contentView.frame.size.height*0.35);
    [self.contentView addSubview:self.chineseLable];
    self.chineseLable.frame = CGRectMake(0, CGRectGetMaxY(self.dateLable.frame), self.contentView.frame.size.width, self.contentView.frame.size.height*0.45);
    [self.contentView addSubview:self.circleLabel];
    self.circleLabel.frame = CGRectMake(0, CGRectGetMaxY(self.contentView.frame) - 10, frame.size.width, 10);
}

- (UILabel *)dateLable{
    if (!_dateLable) {
        _dateLable = [UILabel new];
        [_dateLable setTextAlignment:NSTextAlignmentCenter];
        [_dateLable setFont:[UIFont fontWithName:@"Helvetica-Bold" size:17.0]];
        _dateLable.textColor = DialogColor(0x333333);
    }
    return _dateLable;
}

- (UILabel *)chineseLable{
    if (!_chineseLable) {
        _chineseLable = [UILabel new];
        [_chineseLable setTextAlignment:NSTextAlignmentCenter];
        [_chineseLable setFont:[UIFont systemFontOfSize:12.0f]];
        _chineseLable.textColor = DialogColor(0x666666);
    }
    return _chineseLable;
}

- (UILabel *)circleLabel{
    if (!_circleLabel) {
        _circleLabel = [UILabel new];
        [_circleLabel setTextAlignment:NSTextAlignmentCenter];
        [_circleLabel setFont:[UIFont systemFontOfSize:7.0f]];
        _circleLabel.textColor = [UIColor orangeColor];
    }
    return _circleLabel;
}
@end

@implementation WMZDialogCalanderCell

- (void)UI{
    CGRect frame =  self.frame;
    [self.contentView addSubview:self.dateLable];
    self.dateLable.frame = CGRectMake(0, self.contentView.frame.size.height*0.25, self.contentView.frame.size.width, self.contentView.frame.size.height*0.5);
    [self.contentView addSubview:self.circleLabel];
    self.circleLabel.frame = CGRectMake(0, CGRectGetMaxY(self.contentView.frame), frame.size.width, 10);
}

@end
