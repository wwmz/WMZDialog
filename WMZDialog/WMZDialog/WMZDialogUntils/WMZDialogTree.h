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
WMZDialogStatementAndPropSetFuncStatement(assign, WMZCalanderModel, BOOL, wHadHolday)
/// 显示圆点
WMZDialogStatementAndPropSetFuncStatement(assign, WMZCalanderModel, BOOL, wShowCircle)
/// 圆点颜色
WMZDialogStatementAndPropSetFuncStatement(strong, WMZCalanderModel, UIColor*,wCircleColor)
/// 是当前月份 上个月的数据
WMZDialogStatementAndPropSetFuncStatement(assign, WMZCalanderModel, BOOL, wLastMonth)
/// 是当前月份 下个月的数据
WMZDialogStatementAndPropSetFuncStatement(assign, WMZCalanderModel, BOOL, wNextMonth)
/// 选中
WMZDialogStatementAndPropSetFuncStatement(assign, WMZCalanderModel, BOOL, wSelected)
/// 坐标
WMZDialogStatementAndPropSetFuncStatement(assign, WMZCalanderModel, NSInteger, wIndex)
/// 日期
WMZDialogStatementAndPropSetFuncStatement(strong, WMZCalanderModel, NSDate*, wDate)
/// 年
WMZDialogStatementAndPropSetFuncStatement(assign, WMZCalanderModel, NSInteger, wYear)
/// 月
WMZDialogStatementAndPropSetFuncStatement(assign, WMZCalanderModel, NSInteger, wMonth)
/// 日
WMZDialogStatementAndPropSetFuncStatement(assign, WMZCalanderModel, NSInteger, wDay)
/// 周
WMZDialogStatementAndPropSetFuncStatement(assign, WMZCalanderModel, NSInteger, wWeek)
/// 农历日
WMZDialogStatementAndPropSetFuncStatement(strong, WMZCalanderModel, NSString*, wChineseDate)
/// 农历详情
WMZDialogStatementAndPropSetFuncStatement(strong, WMZCalanderModel, NSString*, wDetailChineseDate)

/// 内部属性
@property (nonatomic, assign) BOOL firstModel;

@property (nonatomic, copy) NSString *dateStr;

@property (nonatomic, assign) NSTimeInterval dateTime;

@property (nonatomic, assign) BOOL lastModel;

@end

NS_ASSUME_NONNULL_END
