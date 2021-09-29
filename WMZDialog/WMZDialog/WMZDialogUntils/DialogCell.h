//
//  DialogCell.h
//  WMZDialog
//
//  Created by wmz on 2021/1/5.
//  Copyright © 2021 wmz. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface DialogCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *textLa;

@property (weak, nonatomic) IBOutlet UIImageView *iconImage;

@property (weak, nonatomic) IBOutlet UIView *lineView;

@property (weak, nonatomic) IBOutlet UIImageView *button;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tempWidth;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftOffset;

+(instancetype)getCell;

+(instancetype)getTextCell;

+(instancetype)getImageCenterCell;

@end

NS_ASSUME_NONNULL_END
