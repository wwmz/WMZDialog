//
//  WMZDialogTree.m
//  WMZDialog
//
//  Created by wmz on 2021/7/18.
//  Copyright © 2021 wmz. All rights reserved.
//

#import "WMZDialogTree.h"
#import "WMZDialogUntils.h"

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

- (BOOL)checkModelWithMaxDate:(NSDate*)maxDate minDate:(NSDate*)minDate{
    int result = YES;
    if (maxDate) {
       int maxResult = [NSDate compareOneDay:self.wDate withAnotherDay:maxDate];
        if (maxResult == 1) {
            result = NO;
        }
    }
     if (minDate) {
        int minResult = [NSDate compareOneDay:self.wDate withAnotherDay:minDate];
        if (minResult == -1) {
            result = NO;
        }
    }
    return result;
}

@end

