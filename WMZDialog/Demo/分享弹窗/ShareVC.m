
//
//  ShareVC.m
//  WMZDialog
//
//  Created by wmz on 2020/4/10.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "ShareVC.h"

@interface ShareVC ()

@end

@implementation ShareVC

- (void)viewDidLoad {
    [super viewDidLoad];
     self.dataArr = @[@"一行",@"2行4列(单页)",@"3行两列(翻页)"];
}

-(void)action:(UIButton*)sender{
    switch (sender.tag) {
        case 0:{
            WMZDialogParam *param = WMZDialogParam.new;
            param.wType = DialogTypeShare;
            param.wEventMenuClick = ^(id anyID, NSInteger section, NSInteger row) {
                
            };
            param.wData = @[
                @{@"name":@"微信",@"image":@"wallet"},
                @{@"name":@"支付宝",@"image":@"aaa"},
    ];
            param.wRowCount = 1;
            param.wColumnCount = 4;
            Dialog().wStartParam(param);
        }
            break;
        case 1:{
            Dialog()
            .wTypeSet(DialogTypeShare)
            .wEventMenuClickSet(^(id anyID, NSInteger section, NSInteger row) {
                NSLog(@"%@ %ld %ld",anyID,(long)section,(long)row);
            })
            .wDataSet(@[
                        @{@"name":@"微信",@"image":@"wallet"},
                        @{@"name":@"支付宝",@"image":@"aaa"},
                        @{@"name":@"米聊",@"image":@"bbb"},
                        @{@"name":@"微信1",@"image":@"wallet"},
                        @{@"name":@"支付宝2",@"image":@"aaa"},
                        @{@"name":@"米聊2",@"image":@"bbb"},
                        @{@"name":@"微信1",@"image":@"wallet"},
                        @{@"name":@"支付宝2",@"image":@"aaa"}
            ])
            .wRowCountSet(2)
            .wColumnCountSet(4)
            .wStart();
        }
            break;
        case 2:{
             Dialog()
            .wTypeSet(DialogTypeShare)
            .wTitleSet(@"分享")
            .wEventMenuClickSet(^(id anyID, NSInteger section, NSInteger row) {
                NSLog(@"%@ %ld %ld",anyID,(long)section,(long)row);
            })
            .wDataSet(@[
                           @{@"name":@"微信",@"image":@"wallet"},
                           @{@"name":@"支付宝",@"image":@"aaa"},
                           @{@"name":@"米聊",@"image":@"bbb"},
                           @{@"name":@"微信1",@"image":@"wallet"},
                           @{@"name":@"支付宝2",@"image":@"aaa"},
                           @{@"name":@"米聊2",@"image":@"bbb"},
                           @{@"name":@"微信1",@"image":@"wallet"},
                           @{@"name":@"支付宝2",@"image":@"aaa"}
            ])
            .wRowCountSet(2)
            .wColumnCountSet(3)
            //开启毛玻璃
            .wEffectShowSet(YES)
            .wStart();
        }
            break;
            
        default:
            break;
    }
}
@end
