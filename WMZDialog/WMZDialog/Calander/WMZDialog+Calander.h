//
//  WMZDialog+Calander.h
//  WMZDialog
//
//  Created by wmz on 2019/11/7.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "WMZDialog.h"

NS_ASSUME_NONNULL_BEGIN

@interface WMZDialogCollectionCell : UICollectionViewCell
@property (nonatomic,strong) UILabel *dateLable;
@property (nonatomic,strong) UILabel *chineseLable;
@property (nonatomic,strong) UILabel *circleLabel;
- (instancetype)initWithFrame:(CGRect)frame;
@end

@interface WMZDialogCalanderCell : WMZDialogCollectionCell
@end

@interface WMZDialog (Calander)
@end
NS_ASSUME_NONNULL_END
