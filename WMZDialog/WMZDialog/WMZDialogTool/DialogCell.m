//
//  DialogCell.m
//  WMZDialog
//
//  Created by wmz on 2021/1/5.
//  Copyright © 2021 wmz. All rights reserved.
//

#import "DialogCell.h"

@implementation DialogCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(instancetype)getCell{
    return (DialogCell *)[[[NSBundle mainBundle] loadNibNamed:@"DialogCell" owner:nil options:nil] lastObject];
}
+(instancetype)getTextCell{
    return (DialogCell *)[[[NSBundle mainBundle] loadNibNamed:@"DialogTextCell" owner:nil options:nil] lastObject];
}
+(instancetype)getImageCenterCell{
    return (DialogCell *)[[[NSBundle mainBundle] loadNibNamed:@"DialogCenterCell" owner:nil options:nil] lastObject];
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
    }
    return self;
}

@end
