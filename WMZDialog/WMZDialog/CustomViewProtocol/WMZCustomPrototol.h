

//
//  WMZCustomPrototol.h
//  WMZDialog
//
//  Created by wmz on 2021/7/17.
//  Copyright © 2021 wmz. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@protocol WMZCustomPrototol <NSObject>

@required
/// 显示的frame
- (CGRect)mz_setupRect;

@optional
/// 布局
- (void)mz_setupView;
/// 使用居中布局 默认YES
- (BOOL)mz_centerView;
/// 整体圆角 传入 -99999 为不使用圆角
- (UIRectCorner)mz_setupCorner;
/// 自动消失  返回-1 不消失
- (CGFloat)mz_autoDisappeal;
/// 动态从外部改变值
- (BOOL)mz_changeValue:(id)value;
/// 改变了frame后的回调
- (void)mz_changeFrame:(NSValue*)value;

@end

NS_ASSUME_NONNULL_END
