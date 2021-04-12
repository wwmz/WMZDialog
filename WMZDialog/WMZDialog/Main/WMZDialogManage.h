//
//  WMZDialogManage.h
//  WMZDialog
//
//  Created by wmz on 2021/4/9.
//  Copyright © 2021 wmz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@interface WMZDialogManage : NSObject
@property(nonatomic,strong)NSMutableDictionary *dialogInfo;
+ (instancetype)shareInstance;
- (void)addDialog:(id)dialog cover:(BOOL)cover superView:(UIView*)superView;
- (void)deleteDialog:(id)dialog;
@end

NS_ASSUME_NONNULL_END
