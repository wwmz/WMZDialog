//
//  CustomVC.h
//  WMZDialog
//
//  Created by wmz on 2020/4/10.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "BaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface CustomView:UIView
- (instancetype)initWithFrame:(CGRect)frame superView:(UIView*)superView;
@end


@interface CustomVC : BaseVC

@end

NS_ASSUME_NONNULL_END
