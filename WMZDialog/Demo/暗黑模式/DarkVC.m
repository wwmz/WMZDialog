//
//  DarkVC.m
//  WMZDialog
//
//  Created by wmz on 2021/9/29.
//  Copyright © 2021 wmz. All rights reserved.
//

#import "DarkVC.h"

@interface DarkVC ()

@end

@implementation DarkVC

- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 13.0, *)) {
        self.overrideUserInterfaceStyle = UIUserInterfaceStyleDark;
    }
    self.dataArr = @[@"暗黑模式",@"自定义暗黑颜色"];
}

- (void)action:(UIButton *)sender{
    switch (sender.tag) {
        case 0:
            Dialog()
            .wTypeSet(DialogTypeShare)
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
            /// 暗黑模式
            .wDarkMode(nil)
            .wStartView(self.view);
            break;
        case 1:
            Dialog()
            .wTypeSet(DialogTypeSheet)
            .wDataSet(@[@"男",@"女",@"保密"])
            /// 暗黑模式 自定义颜色 此处为全局配置  例如这里更换了配置 case 0 的暗黑颜色也会随之改变 所以如果需要不同的暗黑颜色 需要每次调用的时候都传 
            .wDarkMode(@{DialogDarkMainColor:UIColor.darkGrayColor,
//                         DialogDarkC2:UIColor.redColor,
//                         DialogDarkC3:UIColor.orangeColor
                       })
            .wStartView(self.view);
            break;
        default:
            break;
    }
}

@end
