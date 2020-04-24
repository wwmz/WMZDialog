//
//  LocationVC.m
//  WMZDialog
//
//  Created by wmz on 2019/8/15.
//  Copyright © 2019年 wmz. All rights reserved.
//

#import "LocationVC.h"
#import "WMZDialog.h"
@interface LocationVC ()

@end

@implementation LocationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArr = @[@"省",@"省市",@"省市区",@"pickview显示",@"tableview显示"];
}

- (void)action:(UIButton*)sender{
    Dialog()
    .wEventMenuClickSet(^(id anyID, NSInteger section, NSInteger row) {
        NSLog(@"选中 %@ %ld %ld",anyID,section,row);
    })
    .wEventOKFinishSet(^(id anyID, id otherData) {
        NSLog(@"选中 %@ %@",anyID,otherData);
    })
    //分隔符
    .wSeparatorSet(@",")
    .wChainTypeSet(sender.tag<4?ChainPickView:ChainTableView)
    .wLocationTypeSet(sender.tag<3?sender.tag+1:3)
    .wTypeSet(DialogTypeLocation)
    .wStart();
}


@end
