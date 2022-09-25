//
//  WMZDialogNormalProtocol.h
//  WMZDialog
//
//  Created by wmz on 2021/7/17.
//  Copyright © 2021 wmz. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WMZDialogButton;
NS_ASSUME_NONNULL_BEGIN

@protocol WMZDialogNormalProtocol <NSObject>
/// 标题
@property (nonatomic, strong) UILabel *titleLabel;
/// 主要文本
@property (nonatomic, strong) UILabel *textLabel;
/// 确定按钮
@property (nonatomic, strong) WMZDialogButton *OKBtn;
/// 取消按钮
@property (nonatomic, strong) WMZDialogButton *cancelBtn;
/// 关闭按钮
@property (nonatomic, strong) WMZDialogButton *closeBtn;
/// 图片
@property (nonatomic, strong) UIImageView* iconIV;
/// 底部确定取消视图
@property (nonatomic, strong) UIView *bottomView;
/// 顶部确定取消视图
@property (nonatomic, strong, nullable) UIView *headView;
/// 分享视图
@property (nonatomic, strong) UIScrollView *shareView;

@end

NS_ASSUME_NONNULL_END
