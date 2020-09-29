


//
//  LoadingVC.m
//  WMZDialog
//
//  Created by wmz on 2020/4/10.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "LoadingVC.h"

@interface LoadingVC ()

@end

@implementation LoadingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArr = @[@"等待",@"正确",@"错误",@"自动消失"];
}

-(void)action:(UIButton*)sender{
    switch (sender.tag) {
        case 0:{

            Dialog()
            //加载框颜色
            .wLoadingColorSet(DialogColor(0xFF9900))
            //无文字
            .wTitleSet(@"")
            .wTypeSet(DialogTypeLoading)
            //加载框type
            .wLoadingTypeSet(LoadingStyleWait)
            //动画时间
            .wAnimationDurtionSet(1)
            //加载框大小
            .wLoadingSizeSet(CGSizeMake(50, 50))
            .wStartView(self.view);
            
        }
            break;
        case 1:{
                                    
            Dialog()
            //加载框颜色
            .wLoadingColorSet(DialogColor(0x108ee9))
            .wTitleSet(@"操作成功")
            //毛玻璃背景
            .wEffectShowSet(YES)
            .wTypeSet(DialogTypeLoading)
            //加载框type
            .wLoadingTypeSet(LoadingStyleRight)
            //动画时间
            .wAnimationDurtionSet(1)
            //加载框大小
            .wLoadingSizeSet(CGSizeMake(50, 50))
            .wStart();
            
            
        }
            break;
        case 2:{
            
            Dialog()
            //加载框颜色
            .wLoadingColorSet([UIColor redColor])
            .wTitleSet(@"操作失败")
            //毛玻璃背景
            .wEffectShowSet(YES)
            .wTypeSet(DialogTypeLoading)
            //加载框type
            .wLoadingTypeSet(LoadingStyleError)
            //动画时间
            .wAnimationDurtionSet(1)
            //加载框大小
            .wLoadingSizeSet(CGSizeMake(50, 50))
            .wStart();
        }
            break;
        case 3:{
            WMZDialog *alert =
            Dialog()
            //加载框颜色
            .wLoadingColorSet([UIColor redColor])
            .wTitleSet(@"操作失败")
            //毛玻璃背景
            .wTypeSet(DialogTypeLoading)
            //加载框type
            .wLoadingTypeSet(LoadingStyleError)
            //动画时间
            .wAnimationDurtionSet(1)
            //加载框大小
            .wLoadingSizeSet(CGSizeMake(50, 50))
            .wStart();
            
            //自动消失
            [alert performSelector:@selector(closeView) withObject:nil afterDelay:2.5];
        }
           break;
        
        default:
            break;
    }
}

@end
