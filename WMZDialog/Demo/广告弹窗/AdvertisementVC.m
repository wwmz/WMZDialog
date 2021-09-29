//
//  AdvertisementVC.m
//  WMZDialog
//
//  Created by wmz on 2020/4/10.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "AdvertisementVC.h"

@interface AdvertisementVC ()

@end

@implementation AdvertisementVC

- (void)viewDidLoad {
    [super viewDidLoad];
     self.dataArr = @[@"广告"];
}

-(void)action:(UIButton*)sender{
     Dialog()
     .wTypeSet(DialogTypeAdvertisement)
//      //自定义图片
//     .wCustomImageViewSet(^(UIImageView *imageView) {
//
//     })
     .wEventFinishSet(^(id anyID, NSIndexPath *path, DialogType type) {
         NSLog(@"%@",anyID);
     })
     //出现动画
//     .wShowAnimationSet(AninationCombineOne)
     //显示图片的大小
     .wImageSizeSet(CGSizeMake(DialogRealW(350), DialogRealW(350)))
     //图片地址
     .wImageNameSet(@"advise")
     .wStart();
}
@end
