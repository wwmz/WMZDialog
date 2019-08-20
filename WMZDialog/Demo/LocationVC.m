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
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    NSArray *arr = @[@"省",@"省市",@"省市区",@"pickview显示",@"tableview显示"];
    for (int i = 0; i<arr.count; i++) {
        CGFloat X = (i % 2) * ([UIScreen mainScreen].bounds.size.width/3 + 20);
        CGFloat Y = (i / 2) * (40 + 20);
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.backgroundColor = [UIColor cyanColor];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(X+50, Y+100, [UIScreen mainScreen].bounds.size.width/3, 40);
        [self.view addSubview:btn];
    }
    
}

- (void)action:(UIButton*)sender{
    Dialog()
    .wEventMenuClickSet(^(id anyID, NSInteger section, NSInteger row) {
        NSLog(@"选中 %@",anyID);
    })
    .wEventOKFinishSet(^(id anyID, id otherData) {
        NSLog(@"选中 %@",anyID);
    })
    .wChainTypeSet(sender.tag<4?ChainPickView:ChainTableView)
    .wLocationTypeSet(sender.tag<3?sender.tag+1:3)
    .wTypeSet(DialogTypeLocation)
    .wStart();
}


@end
