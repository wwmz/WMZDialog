//
//  WMZDialog+System.m
//  WMZDialog
//
//  Created by wmz on 2019/6/6.
//  Copyright © 2019年 wmz. All rights reserved.
//

#import "WMZDialog+System.h"

@implementation WMZDialog (System)
- (UIAlertController*)systemAction{
    
    __weak typeof(self) weakWMZSelf = self;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:self.wTitle message:self.wMessage preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:self.wOKTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (weakWMZSelf.wEventOKFinish) {
            weakWMZSelf.wEventOKFinish(@"确定",nil);
        }
    }];
    [okAction setValue:self.wOKColor forKey:@"_titleTextColor"];
    [alert addAction:okAction];


    if (self.wEventCancelFinish) {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:self.wCancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                weakWMZSelf.wEventCancelFinish(@"取消",nil);
        }];
        [cancelAction setValue:self.wCancelColor forKey:@"_titleTextColor"];
        [alert addAction:cancelAction];
    }
  
    
    return alert;
}
@end
