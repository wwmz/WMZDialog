//
//  WMZDialogView.h
//  WMZDialog
//
//  Created by wmz on 2021/7/17.
//  Copyright © 2021 wmz. All rights reserved.
//

#import "WMZCustomPrototol.h"
#import "WMZDialogParam.h"
NS_ASSUME_NONNULL_BEGIN

@interface WMZDialogView : UIView<WMZCustomPrototol>

- (instancetype)initWithParam:(WMZDialogParam*)param;

+ (instancetype)initWithParam:(WMZDialogParam*)param;

/// 配置
@property (nonatomic,strong) WMZDialogParam *param;

@end

NS_ASSUME_NONNULL_END
