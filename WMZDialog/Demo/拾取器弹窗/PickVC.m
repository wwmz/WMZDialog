//
//  PickVC.m
//  WMZDialog
//
//  Created by wmz on 2020/4/10.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "PickVC.h"

@interface PickVC ()

@end

@implementation PickVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArr = @[@"2列",@"4列"];
}

-(void)action:(UIButton*)sender{
    switch (sender.tag) {
           case 0:{
               Dialog()
               .wEventOKFinishSet(^(id anyID, id otherData) {
                   NSLog(@"%@",anyID);
               })
               .wTypeSet(DialogTypePickSelect)
               .wDataSet( @[@[@"数据11",@"数据12",@"数据13",@"数据14"],
                            @[@"数据2",@"数据22",@"数据23",@"数据24"]])
               .wStart();
           }
               break;
           case 1:{
               Dialog()
               .wEventOKFinishSet(^(id anyID, id otherData) {
                   NSLog(@"%@",anyID);
               })
               .wTypeSet(DialogTypePickSelect)
               .wDataSet(
                        @[
                           @[@"数据11",@"数据12",@"数据13",@"数据14"],
                           @[@"数据2",@"数据22",@"数据23",@"数据24"],
                           @[@"数据31",@"数据32",@"数据33",@"数据34"],
                           @[@"数据41",@"数据42",@"数据43",@"数据44"]
                        ])
               .wStart();
           }
               break;
           default:
               break;
       }
}
                                                           

@end
