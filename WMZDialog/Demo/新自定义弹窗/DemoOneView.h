//
//  DemoOneView.h
//  WMZDialog
//
//  Created by wmz on 2021/9/28.
//  Copyright © 2021 wmz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WMZCustomPrototol.h"
NS_ASSUME_NONNULL_BEGIN

@interface DemoOneView : UIView<WMZCustomPrototol>
@property (weak, nonatomic) IBOutlet UIButton *confirmBTN;
@property (weak, nonatomic) IBOutlet UIButton *closeBTN;
+ (DemoOneView*)loadNibView;
@end

NS_ASSUME_NONNULL_END
