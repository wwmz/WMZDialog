//
//  BaseVC.h
//  WMZDialog
//
//  Created by wmz on 2020/4/10.
//  Copyright © 2020 wmz. All rights reserved.
//


#import "WMZDialog.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseVC : UIViewController
@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) CGFloat btnWidth;
-(void)action:(UIButton*)sender;
@end

NS_ASSUME_NONNULL_END
