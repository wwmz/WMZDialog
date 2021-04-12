//
//  WMZDialogManage.m
//  WMZDialog
//
//  Created by wmz on 2021/4/9.
//  Copyright © 2021 wmz. All rights reserved.
//

#import "WMZDialogManage.h"
static WMZDialogManage* dialogManage = nil;
@implementation WMZDialogManage
//单例
+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        dialogManage = [[super allocWithZone:NULL] init];
        dialogManage.dialogInfo = [NSMutableDictionary new];
    }) ;
    return dialogManage ;
}

- (void)addDialog:(id)dialog cover:(BOOL)cover superView:(UIView*)superView{
    id key = nil;
    if ([dialog isKindOfClass:NSClassFromString(@"WMZDialog")]) {
        NSInteger tag = [[dialog valueForKey:@"wTag"] integerValue];
        key = @(tag);
    }
    if (key) {
        if ([self.dialogInfo objectForKey:key]) {
            if (cover) {
                [self.dialogInfo setObject:dialog forKey:key];
            }
        }else{
            [self.dialogInfo setObject:dialog forKey:key];
        }
        NSMutableArray *dialogArr = [NSMutableArray new];
        for (UIView *dialogView in superView.subviews) {
            if ([dialogView isKindOfClass:NSClassFromString(@"WMZDialog")]) {
                [dialogArr addObject:dialogView];
            }
        }
        NSInteger level = [[dialog valueForKey:@"wLevel"] integerValue];
        if (dialogArr.count > 0) {
            if (level == 999) { 
                [superView insertSubview:dialog aboveSubview:dialogArr.lastObject];
            } else  if (level == 0) {
                [superView insertSubview:dialog belowSubview:dialogArr.firstObject];
            } else {
                UIView *lastDialog = nil;
                if (dialogArr.count == 1) {
                    lastDialog = dialogArr.firstObject;
                    NSInteger lastDialogLevel = [[lastDialog valueForKey:@"wLevel"] integerValue];
                    if (level >= lastDialogLevel) {
                        [superView insertSubview:dialog aboveSubview:lastDialog];
                    }else{
                        [superView insertSubview:dialog belowSubview:lastDialog];
                    }
                }else{
                    NSMutableArray *tempArr = [NSMutableArray arrayWithArray:dialogArr];
                    [tempArr sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                        NSInteger obj1Level = [[obj1 valueForKey:@"wLevel"] integerValue];
                        NSInteger obj2Level = [[obj2 valueForKey:@"wLevel"] integerValue];
                        return obj1Level > obj2Level;
                    }];
                    UIView *first = tempArr.firstObject;
                    UIView *last = tempArr.lastObject;
                    NSInteger firstLevel = [[first valueForKey:@"wLevel"] integerValue];
                    NSInteger lastLevel = [[last valueForKey:@"wLevel"] integerValue];
                    if (level < firstLevel) {
                        [superView insertSubview:dialog belowSubview:first];
                    }else if (level > lastLevel){
                        [superView insertSubview:dialog aboveSubview:last];
                    }else{
                        for (UIView *cueerntDialog in tempArr) {
                            NSInteger currentLevel = [[cueerntDialog valueForKey:@"wLevel"] integerValue];
                            if (level > currentLevel) {
                                [superView insertSubview:dialog aboveSubview:cueerntDialog];
                                break;
                            }
                        }
                    }
                }
            }
        }else{
            [superView addSubview:dialog];
        }
    }
}
- (void)deleteDialog:(id)dialog{
    id key = nil;
    if ([dialog isKindOfClass:NSClassFromString(@"WMZDialog")]) {
        NSInteger tag = [[dialog valueForKey:@"wTag"] integerValue];
        key = @(tag);
    }
    if ([self.dialogInfo objectForKey:key]) {
        [self.dialogInfo removeObjectForKey:key];
        dialog = nil;
    }
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    return WMZDialogManage.shareInstance ;
}
- (id)copyWithZone:(struct _NSZone *)zone
{
    return  WMZDialogManage.shareInstance ;
}
@end
