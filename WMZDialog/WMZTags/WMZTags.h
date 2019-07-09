//
//  WMZTags.h
//  WMZTags
//
//  Created by wmz on 2019/5/23.
//  Copyright © 2019年 wmz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WMZTagParam.h"
#import "WMZTagBtn.h"
#define TagWitdh  [UIScreen mainScreen].bounds.size.width
#define TagHeight [UIScreen mainScreen].bounds.size.height
NS_ASSUME_NONNULL_BEGIN



@interface WMZTags : UIView
//传入的属性
@property(nonatomic,strong)WMZTagParam *param;

/**
 *  调用方法
 *
 */
- (instancetype)initConfigureWithModel:(WMZTagParam *)param;

/**
 *  更新方法
 *
 */
- (void)updateUI;

@end

NS_ASSUME_NONNULL_END
