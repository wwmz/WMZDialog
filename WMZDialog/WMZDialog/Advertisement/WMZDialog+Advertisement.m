//
//  WMZDialog+Advertisement.m
//  WMZDialog
//
//  Created by wmz on 2019/7/8.
//  Copyright © 2019年 wmz. All rights reserved.
//

#import "WMZDialog+Advertisement.h"

@implementation WMZDialog (Advertisement)
-(UIView*)advertisementAction{
    
    UIImageView *image = [UIImageView new];
    image.image = [UIImage imageNamed:self.wImageName];
    image.frame = CGRectMake((self.wWidth-self.wImageSize.width)/2, 0, self.wImageSize.width, self.wImageSize.height);
//    image.layer.cornerRadius = 10;
//    image.layer.masksToBounds = YES;
    image.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(advertTapAction)];
    [image addGestureRecognizer:tap];
    [self.mainView addSubview:image];


    self.wCloseBtn.frame = CGRectMake((self.wWidth-self.wMainBtnHeight)/2, CGRectGetMaxY(image.frame)+self.wMainOffsetY, self.wMainBtnHeight, self.wMainBtnHeight);
    [self.wCloseBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    self.wCloseBtn.backgroundColor = DialogColor(0xeeeeee);
    self.wCloseBtn.layer.cornerRadius = self.wMainBtnHeight/2;
    [self.mainView addSubview:self.wCloseBtn];
    
    [self reSetMainViewFrame:CGRectMake(0, 0, self.wWidth, CGRectGetMaxY(self.wCloseBtn.frame)+self.wMainOffsetY)];
    
    
    return self.mainView;
}

- (void)advertTapAction{
    if (self.wEventFinish) {
        self.wEventFinish(@"广告点击",nil, self.wType);
    }
}

@end
