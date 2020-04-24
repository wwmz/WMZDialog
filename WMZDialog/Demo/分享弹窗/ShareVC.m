
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
     self.dataArr = @[@"2行4列(单页)",@"3行两列(翻页)"];
}

-(void)action:(UIButton*)sender{
    switch (sender.tag) {
        case 0:{
            Dialog()
            .wTypeSet(DialogTypeShare)
            .wTitleSet(@"分享")
            .wEventMenuClickSet(^(id anyID, NSInteger section, NSInteger row) {
                NSLog(@"%@ %ld %ld",anyID,section,row);
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
        case 1:{
             Dialog()
            .wTypeSet(DialogTypeShare)
            .wTitleSet(@"分享")
            .wEventMenuClickSet(^(id anyID, NSInteger section, NSInteger row) {
                NSLog(@"%@ %ld %ld",anyID,section,row);
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
