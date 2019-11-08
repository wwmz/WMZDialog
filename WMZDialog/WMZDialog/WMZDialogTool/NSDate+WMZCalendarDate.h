//
//  NSDate+WMZCalendarDate.h
//  WMZDialog
//
//  Created by wmz on 2019/11/7.
//  Copyright © 2019 wmz. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@interface NSDate (WMZCalendarDate)
#pragma mark - 获取日
+ (NSInteger)day:(NSDate *)date;
#pragma mark - 获取月
+ (NSInteger)month:(NSDate *)date;
#pragma mark - 获取年
+ (NSInteger)year:(NSDate *)date;
#pragma mark - 获取当月第一天周几
+ (NSInteger)firstWeekdayInThisMonth:(NSDate *)date;
#pragma mark - 获取当前月有多少天
+ (NSInteger)totaldaysInMonth:(NSDate *)date;
#pragma mark -- 获取date农历信息
+ (NSDictionary*)getChineseCalendarWithDate:(NSDate*)dateTemp Year:(NSInteger)myYear Month:(NSInteger)myMonth Day:(NSInteger)myDay;
#pragma mark -- 是否属于同一天判断
+ (BOOL)isInSameDay:(NSDate*)date1 time2:(NSDate*)date2;
@end

NS_ASSUME_NONNULL_END
