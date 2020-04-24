


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
            //毛玻璃背景
            .wEffectShowSet(YES)
            .wTypeSet(DialogTypeLoading)
            //加载框type
            .wLoadingTypeSet(LoadingStyleWait)
            //动画时间
            .wAnimationDurtionSet(1)
            //加载框大小
            .wLoadingSizeSet(CGSizeMake(50, 50))
            .wStart();
            
            
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
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [alert closeView];
            });
        }
           break;
        
        default:
            break;
    }
}

@end
