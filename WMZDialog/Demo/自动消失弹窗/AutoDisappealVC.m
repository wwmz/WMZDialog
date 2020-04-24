//
//  AutoDisappealVC.m
//  WMZDialog
//
//  Created by wmz on 2020/4/10.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "AutoDisappealVC.h"

@interface AutoDisappealVC ()

@end

@implementation AutoDisappealVC

- (void)viewDidLoad {
    [super viewDidLoad];
     self.dataArr = @[@"文字",@"图文",@"图"];
}

-(void)action:(UIButton*)sender{
    switch (sender.tag) {
        case 0:{
            Dialog().wTypeSet(DialogTypeAuto)
            .wMessageSet(@"自动消失")
            //自动消失时间 默认1.5
            .wDisappelSecondSet(1)
            .wStart();
        }
            break;
        case 1:{
            Dialog().wTypeSet(DialogTypeAuto)
            //设置宽度
            .wWidthSet(140)
            .wImageNameSet(@"down_tyx")
            .wMessageSet(@"自动消失\n带图片")
            .wStart();
        }
            break;
        case 2:{
            Dialog().wTypeSet(DialogTypeAuto)
            //设置宽度
            .wWidthSet(100)
            .wMessageSet(@"")
            .wImageNameSet(@"down_tyx")
            .wStart();
        }
            break;
            
        default:
            break;
    }
}


@end
