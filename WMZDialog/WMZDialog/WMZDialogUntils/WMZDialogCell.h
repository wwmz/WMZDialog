//
//  WMZDialogCell.h
//  WMZDialog
//
//  Created by wmz on 2022/11/19.
//  Copyright © 2022 wmz. All rights reserved.
//

#import "WMZDialogParam.h"

static NSString * _Nullable const DialogCellTextReuseIdentifier = @"DialogCellTextReuseIdentifier";

static NSString * _Nullable const DialogCellImageTextReuseIdentifier = @"DialogCellImageTextReuseIdentifier";

NS_ASSUME_NONNULL_BEGIN

@interface WMZDialogCell : UITableViewCell
///title
@property (strong, nonatomic, readonly) UILabel *textLa;
///icon
@property (strong, nonatomic, readonly) UIImageView *iconImage;
///line
@property (strong, nonatomic, readonly) UIView *lineView;
///checkBTN
@property (strong, nonatomic, readonly) UIImageView *button;
/// params
@property (strong, nonatomic, readonly) WMZDialogParam *params;
///bgView
@property (strong, nonatomic, readonly) UIView *bgView;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier param:(WMZDialogParam*)params;
@end

NS_ASSUME_NONNULL_END
