//
//  WMZDialog+SystemSheet.m
//  WMZDialog
//
//  Created by wmz on 2019/6/6.
//  Copyright © 2019年 wmz. All rights reserved.
//

#import "WMZDialog+SystemSheet.h"

@implementation WMZDialog (SystemSheet)
- (UIAlertController*)systemSheetAction{
    
    __weak typeof(self) weakWMZSelf = self;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:self.wTitle message:self.wMessage preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    if ([self.wData isKindOfClass:[NSArray class]]||[self.wData isKindOfClass:[NSMutableArray class]]) {
        for (NSString *str in self.wData) {
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:str style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (weakWMZSelf.wEventOKFinish) {
                    weakWMZSelf.wEventOKFinish(str,self.wType);
                }
            }];
            
            [okAction setValue:self.wOKColor forKey:@"_titleTextColor"];
            [alert addAction:okAction];
        }
    }
  
    
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:self.wCancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (weakWMZSelf.wEventCancelFinish) {
            weakWMZSelf.wEventCancelFinish(@"取消",self.wType);
        }
    }];
    [cancelAction setValue:self.wCancelColor forKey:@"_titleTextColor"];
    [alert addAction:cancelAction];
    
    return alert;
}
@end
