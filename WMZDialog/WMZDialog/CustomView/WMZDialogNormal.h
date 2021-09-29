//
//  WMZDialogNormal.h
//  WMZDialog
//
//  Created by wmz on 2021/7/17.
//  Copyright © 2021 wmz. All rights reserved.
//

#import "WMZDialogView.h"
#import "WMZDialogNormalProtocol.h"
#import "WMZDialogUntils.h"
@class WMZDialog;

NS_ASSUME_NONNULL_BEGIN

@interface WMZDialogNormal : WMZDialogView<WMZDialogNormalProtocol>

/// 添加底部
/// @param maxY 距离上一个视图的y值
- (UIView*)addBottomView:(CGFloat)maxY;

/// 添加顶部
- (UIView*)addTopView;

/// 添加顶部标题视图
- (CGFloat)addTopTitleView;

@end

NS_ASSUME_NONNULL_END
