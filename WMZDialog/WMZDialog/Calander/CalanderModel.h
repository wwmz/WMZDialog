//
//  CalanderModel.h
//  WMZDialog
//
//  Created by wmz on 2019/11/8.
//  Copyright © 2019 wmz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WMZDialogMacro.h"
NS_ASSUME_NONNULL_BEGIN

@interface CalanderModel : NSObject
//节假日
WMZDialogStatementAndPropSetFuncStatement(assign, CalanderModel, BOOL,                          wHadHolday)
//显示圆点
WMZDialogStatementAndPropSetFuncStatement(assign, CalanderModel, BOOL,                          wShowCircle)
//圆点颜色
WMZDialogStatementAndPropSetFuncStatement(strong, CalanderModel, UIColor*,                      wCircleColor)
//是当前月份 上个月的数据
WMZDialogStatementAndPropSetFuncStatement(assign, CalanderModel, BOOL,                          wLastMonth)
//是当前月份 下个月的数据
WMZDialogStatementAndPropSetFuncStatement(assign, CalanderModel, BOOL,                          wNextMonth)
//选中
WMZDialogStatementAndPropSetFuncStatement(assign, CalanderModel, BOOL,                          wSelected)
//坐标
WMZDialogStatementAndPropSetFuncStatement(assign, CalanderModel, NSInteger,                     wIndex)
//日期
WMZDialogStatementAndPropSetFuncStatement(strong, CalanderModel, NSDate*,                       wDate)
//年
WMZDialogStatementAndPropSetFuncStatement(assign, CalanderModel, NSInteger,                     wYear)
//月
WMZDialogStatementAndPropSetFuncStatement(assign, CalanderModel, NSInteger,                     wMonth)
//日
WMZDialogStatementAndPropSetFuncStatement(assign, CalanderModel, NSInteger,                     wDay)
//周
WMZDialogStatementAndPropSetFuncStatement(assign, CalanderModel, NSInteger,                     wWeek)
//农历日
WMZDialogStatementAndPropSetFuncStatement(strong, CalanderModel, NSString*,                     wChineseDate)
//农历详情
WMZDialogStatementAndPropSetFuncStatement(strong, CalanderModel, NSString*,                     wDetailChineseDate)
@end

NS_ASSUME_NONNULL_END
