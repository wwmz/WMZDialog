




//
//  NaviMenuVC.m
//  WMZDialog
//
//  Created by wmz on 2020/4/10.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "NaviMenuVC.h"

@interface NaviMenuVC ()

@end

@implementation NaviMenuVC

- (void)viewDidLoad {
    [super viewDidLoad];
     self.dataArr = @[@"顶部菜单"];
}

-(void)action:(UIButton*)sender{
     //和分享弹窗拥有的属性一致
     Dialog()
     .wTypeSet(DialogTypeNaviMenu)
     .wDataSet(@[
                 @{@"name":@"微信",@"image":@"wallet"},
                 @{@"name":@"支付宝",@"image":@"aaa"},
                 @{@"name":@"米聊",@"image":@"bbb"},
                 @{@"name":@"微信1",@"image":@"wallet"},
                 ])
     .wStart();
}
@end
