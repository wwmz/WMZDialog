//
//  DialogCell.m
//  WMZDialog
//
//  Created by wmz on 2021/1/5.
//  Copyright © 2021 wmz. All rights reserved.
//

#import "DialogCell.h"
#import "WMZDialogUntils.h"

@implementation DialogCell

+(instancetype)getCell{
    return (DialogCell *)[[[WMZDialogUntils getMainBundle] loadNibNamed:@"DialogCell" owner:nil options:nil] lastObject];
}

+(instancetype)getTextCell{
    return (DialogCell *)[[[WMZDialogUntils getMainBundle]  loadNibNamed:@"DialogTextCell" owner:nil options:nil] lastObject];
}

+(instancetype)getImageCenterCell{
    return (DialogCell *)[[[WMZDialogUntils getMainBundle] loadNibNamed:@"DialogCenterCell" owner:nil options:nil] lastObject];
}

@end
