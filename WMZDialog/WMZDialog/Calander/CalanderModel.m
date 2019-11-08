//
//  CalanderModel.m
//  WMZDialog
//
//  Created by wmz on 2019/11/8.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "CalanderModel.h"

@implementation CalanderModel
WMZDialogSetFuncImplementation(CalanderModel, NSInteger,                     wYear)
WMZDialogSetFuncImplementation(CalanderModel, NSInteger,                     wMonth)
WMZDialogSetFuncImplementation(CalanderModel, NSInteger,                     wDay)
WMZDialogSetFuncImplementation(CalanderModel, NSInteger,                     wWeek)
WMZDialogSetFuncImplementation(CalanderModel, NSInteger,                     wIndex)
WMZDialogSetFuncImplementation(CalanderModel, BOOL,                          wLastMonth)
WMZDialogSetFuncImplementation(CalanderModel, BOOL,                          wNextMonth)
WMZDialogSetFuncImplementation(CalanderModel, NSString*,                     wChineseDate)
WMZDialogSetFuncImplementation(CalanderModel, NSDate*,                       wDate)
WMZDialogSetFuncImplementation(CalanderModel, BOOL,                          wHadHolday)
WMZDialogSetFuncImplementation(CalanderModel, BOOL,                          wSelected)
WMZDialogSetFuncImplementation(CalanderModel, NSString*,                     wDetailChineseDate)
WMZDialogSetFuncImplementation(CalanderModel, BOOL,                          wShowCircle)
WMZDialogSetFuncImplementation(CalanderModel, UIColor*,                      wCircleColor)
@end
