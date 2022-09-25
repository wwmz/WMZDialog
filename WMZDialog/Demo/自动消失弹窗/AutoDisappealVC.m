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
     self.dataArr = @[@"文字",@"图文",@"图",@"改变最大宽度",@"关闭交互"];
}

-(void)action:(UIButton*)sender{
    switch (sender.tag) {
        case 0:{
            Dialog().wTypeSet(DialogTypeAuto)
            .wMessageSet(@"自动消失")
            //自动消失时间 默认1.5
            .wDisappelSecondSet(1)
            //自定义属性
            .wMainOffsetXSet(15)
            .wMainOffsetYSet(15)
            .wShowAnimationSet(AninatonShowScaleFade)
            .wHideAnimationSet(AninatonHideScaleFade)
            ///关闭交互
            .wUserInteractionEnabledSet(NO)
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
        case 3:{
            Dialog().wTypeSet(DialogTypeAuto)
            .wAutoMaxWidthSet(DialogScreenW - 60)
            .wWidthSet(100)
            .wMessageSet(@"DialogTypeAutoDialogTypeAutoDialogTypeAutoDialogTypeAutoDialogTypeAutoDialogTypeAutoDialogTypeAutoDialogTypeAutoDialogTypeAutoDialogTypeAutoDialogTypeAutoDialogTypeAutoDialogTypeAutoDialogTypeAutoDialogTypeAutoDialogTypeAutoDialogTypeAutoDialogTypeAutoDialogTypeAutoDialogTypeAutoDialogTypeAutoDialogTypeAutoDialogTypeAutoDialogTypeAutoDialogTypeAuto")
            .wStart();
        }
            break;
        case 4:{
            Dialog().wTypeSet(DialogTypeAuto)
            .wTagSet(random()%1000)
            .wMessageSet(@"可点击其他视图")
            .wUserInteractionEnabledSet(NO)
            .wStartView(self.view);
        }
            break;
            
        default:
            break;
    }
}


@end
