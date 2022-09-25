//
//  WMZDialogTree.h
//  WMZDialog
//
//  Created by wmz on 2021/7/18.
//  Copyright © 2021 wmz. All rights reserved.
//

#import "WMZDialogMacro.h"

NS_ASSUME_NONNULL_BEGIN

/// 树形节点model
@interface WMZDialogTree:NSObject
/// 深度
@property (nonatomic, assign) NSInteger depth;
/// 名字
@property (nonatomic,   copy) NSString *name;
/// 对应id 唯一
@property (nonatomic,   copy) NSString *ID;
/// 是否选中
@property (nonatomic, assign) BOOL isSelected;
/// 子集
@property (nonatomic, strong) NSMutableArray<WMZDialogTree *> *children;
/// 其他
@property (nonatomic, strong) id data;

- (instancetype)initWithDetpth:(NSInteger)depth
                      withName:(NSString*)name
                        withID:(NSString*)ID;

@end

@interface WMZCalanderModel : NSObject
/// 节假日
@property (nonatomic, assign) BOOL wHadHolday;
/// 显示圆点
@property (nonatomic, assign) BOOL wShowCircle;
/// 圆点颜色
@property (nonatomic, strong) UIColor* wCircleColor;
/// 是当前月份 上个月的数据
@property (nonatomic, assign) BOOL wLastMonth;
/// 是当前月份 下个月的数据
@property (nonatomic, assign) BOOL wNextMonth;
/// 选中
@property (nonatomic, assign) BOOL wSelected;
/// 坐标
@property (nonatomic, assign) NSInteger wIndex;
/// 日期
@property (nonatomic, strong) NSDate* wDate;
/// 年
@property (nonatomic, assign) NSInteger wYear;
/// 月
@property (nonatomic, assign) NSInteger wMonth;
/// 日
@property (nonatomic, assign) NSInteger wDay;
/// 周
@property (nonatomic, assign) NSInteger wWeek;
/// 农历日
@property (nonatomic, copy) NSString* wChineseDate;
/// 农历详情
@property (nonatomic, copy) NSString* wDetailChineseDate;
/// 在最大最小范围内
@property (nonatomic, assign) BOOL wInRange;
/// 内部属性
@property (nonatomic, assign) BOOL firstModel;

@property (nonatomic, copy) NSString *dateStr;

@property (nonatomic, assign) NSTimeInterval dateTime;

@property (nonatomic, assign) BOOL lastModel;

- (BOOL)checkModelWithMaxDate:(NSDate*)maxDate minDate:(NSDate*)minDate;
@end

NS_ASSUME_NONNULL_END
