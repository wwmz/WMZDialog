//
//  WMZDialogTree.m
//  WMZDialog
//
//  Created by wmz on 2021/7/18.
//  Copyright © 2021 wmz. All rights reserved.
//

#import "WMZDialogTree.h"

@implementation WMZDialogTree

- (instancetype)initWithDetpth:(NSInteger)depth
                      withName:(NSString*)name
                        withID:(NSString*)ID{
    if (self = [super init]) {
        _depth = depth;
        _name = name;
        _ID = ID;
    }
    return self;
}

- (NSMutableArray<WMZDialogTree *> *)children{
    if (!_children) {
        _children = [NSMutableArray new];
    }
    return _children;
}

@end


@implementation WMZCalanderModel
WMZDialogSetFuncImplementation(WMZCalanderModel, NSInteger, wYear)
WMZDialogSetFuncImplementation(WMZCalanderModel, NSInteger, wMonth)
WMZDialogSetFuncImplementation(WMZCalanderModel, NSInteger, wDay)
WMZDialogSetFuncImplementation(WMZCalanderModel, NSInteger, wWeek)
WMZDialogSetFuncImplementation(WMZCalanderModel, NSInteger, wIndex)
WMZDialogSetFuncImplementation(WMZCalanderModel, BOOL, wLastMonth)
WMZDialogSetFuncImplementation(WMZCalanderModel, BOOL, wNextMonth)
WMZDialogSetFuncImplementation(WMZCalanderModel, NSString*, wChineseDate)
WMZDialogSetFuncImplementation(WMZCalanderModel, NSDate*, wDate)
WMZDialogSetFuncImplementation(WMZCalanderModel, BOOL, wHadHolday)
WMZDialogSetFuncImplementation(WMZCalanderModel, BOOL, wSelected)
WMZDialogSetFuncImplementation(WMZCalanderModel, NSString*, wDetailChineseDate)
WMZDialogSetFuncImplementation(WMZCalanderModel, BOOL, wShowCircle)
WMZDialogSetFuncImplementation(WMZCalanderModel, UIColor*, wCircleColor)
- (NSTimeInterval)dateTime{
    if (!_dateTime) {
        _dateTime = [self.wDate timeIntervalSince1970];
    }
    return _dateTime;
}

- (NSString *)dateStr{
    _dateStr = [NSString stringWithFormat:@"%ld-%ld-%ld",(long)self.wYear,(long)self.wMonth,(long)self.wDay];
    return _dateStr;
}

@end

