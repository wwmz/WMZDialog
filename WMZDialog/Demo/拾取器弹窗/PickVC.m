//
//  PickVC.m
//  WMZDialog
//
//  Created by wmz on 2020/4/10.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "PickVC.h"

@interface PickVC ()
{
    WMZDialog *dialog;
}
@end

@implementation PickVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArr = @[@"1列",@"2列",@"4列"];
}

-(void)action:(UIButton*)sender{
    switch (sender.tag) {
           case 0:{
               NSDictionary *info = @{@"name":@"数据3"};
                Dialog()
               .wTypeSet(DialogTypePickSelect)
               .wEventOKFinishSet(^(id anyID, id otherData) {
                      NSLog(@"%@",anyID);
                })
               .wListDefaultValueSet(@[@"数据3"])  //默认
               //一层直接传入带字典/字符串的数组 name为显示的文字 其他携带的model可以自由传入
               .wDataSet(@[@{@"name":@"数据1"},@{@"name":@"数据2"},info,@"数据4"])
               .wStart();
           }
               break;
           case 1:{
                Dialog()
               .wEventOKFinishSet(^(id anyID, id otherData) {
                   NSLog(@"%@",anyID);
               })
               .wListDefaultValueSet(@[@"数据12",@(2)])  //默认选中第一列数据12 第二列第三个(可传入id/nsnumber类型 组合)
               .wTypeSet(DialogTypePickSelect)
               .wDataSet( @[@[@"数据11",@"数据12",@"数据13",@"数据14"],
                            @[@"数据2",@"数据22",@"数据23",@"数据24"]])
               .wStart();
           }
               break;
           case 2:{
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
