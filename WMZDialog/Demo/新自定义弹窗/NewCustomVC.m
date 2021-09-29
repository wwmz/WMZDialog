//
//  NewCustomVC.m
//  WMZDialog
//
//  Created by wmz on 2021/9/28.
//  Copyright © 2021 wmz. All rights reserved.
//

#import "NewCustomVC.h"
#import "DemoOneView.h"
#import "DemoTwoView.h"
#import "DemoThreeView.h"
@interface NewCustomVC ()

@end

@implementation NewCustomVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.btnWidth = self.view.bounds.size.width * 0.7;
    self.dataArr = @[@"实现WMZCustomPrototol协议",@"继承WMZDialogNormal",@"继承WMZDialogTable"];
}

- (void)action:(UIButton *)sender{
    switch (sender.tag) {
        case 0:
            /// 传入实现WMZCustomPrototol协议的view
            Dialog().wCustomView([DemoOneView loadNibView]).wStart();
            break;
        case 1:
            /// 继承WMZDialogNormal
            Dialog()
            .wTitleSet(@"设置一个新名字")
            .wMessageSet(@"最多20个字符")
            .wOpenKeyBoardSet(YES)
            .wCustomView(DemoTwoView.new)
            .wStart();
            break;
        case 2:
            /// 继承WMZDialogTable
            Dialog()
            .wDataSet(@[@"此处继承只是",@"为了不重复一些UI的逻辑",@"使用库内的"])
            .wCustomView(DemoThreeView.new)
            .wStart();
            break;
        default:
            break;
    }
}


@end
