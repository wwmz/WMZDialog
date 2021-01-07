//
//  DialogCell.m
//  WMZDialog
//
//  Created by wmz on 2021/1/5.
//  Copyright © 2021 wmz. All rights reserved.
//

#import "DialogCell.h"
#import "WMZDialogTool.h"
@implementation DialogCell
+(instancetype)getCell{
    return (DialogCell *)[[[WMZDialogTool getMainBundle] loadNibNamed:@"DialogCell" owner:nil options:nil] lastObject];
}
+(instancetype)getTextCell{
    return (DialogCell *)[[[WMZDialogTool getMainBundle]  loadNibNamed:@"DialogTextCell" owner:nil options:nil] lastObject];
}
+(instancetype)getImageCenterCell{
    return (DialogCell *)[[[WMZDialogTool getMainBundle] loadNibNamed:@"DialogCenterCell" owner:nil options:nil] lastObject];
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
    }
    return self;
}

@end
