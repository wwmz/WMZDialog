


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
    self.dataArr = @[@"等待",@"正确",@"错误",@"信息",@"自动消失",@"菊花框",@"封装一个加载框"];
}

-(void)action:(UIButton*)sender{
    switch (sender.tag) {
        case 0:{

            Dialog()
            //加载框颜色
            .wLoadingColorSet(DialogColor(0xFF9900))
            //文字
            .wTitleSet(@"加载中...")
            .wTypeSet(DialogTypeLoading)
            //加载框type
            .wLoadingTypeSet(LoadingStyleWait)
            .wShadowAlphaSet(0.02)
            //动画时间
            .wAnimationDurtionSet(1)
            //加载框大小
            .wLoadingSizeSet(CGSizeMake(40, 40))
            .wStartView(self.view);
            
        }
            break;
        case 1:{
                                    
            Dialog()
            //加载框颜色
            .wLoadingColorSet(DialogColor(0x108ee9))
            .wTitleSet(@"操作成功")
            //加载框线条宽度
            .wLoadingWidthSet(2.5)
            .wTypeSet(DialogTypeLoading)
            //加载框type
            .wLoadingTypeSet(LoadingStyleRight)
            //动画时间
            .wAnimationDurtionSet(0.8)
            //加载框大小
            .wLoadingSizeSet(CGSizeMake(40, 40))
            .wStart();
            
            
        }
            break;
        case 2:{
            
            Dialog()
            //加载框颜色
            .wLoadingColorSet([UIColor redColor])
            .wTitleSet(@"操作失败")
            .wTypeSet(DialogTypeLoading)
            //加载框type
            .wLoadingTypeSet(LoadingStyleError)
            //动画时间
            .wAnimationDurtionSet(0.8)
            //加载框大小
            .wLoadingSizeSet(CGSizeMake(40, 40))
            .wStart();
        }
            break;
        case 3:{
            Dialog()
            //加载框颜色
            .wLoadingColorSet([UIColor yellowColor])
            .wTitleSet(@"操作信息")
            .wTypeSet(DialogTypeLoading)
            //加载框type
            .wLoadingTypeSet(LoadingStyleInfo)
            //动画时间
            .wAnimationDurtionSet(0.5)
            //加载框大小
            .wLoadingSizeSet(CGSizeMake(40, 40))
            .wStart();
        }
            break;
        case 4:{
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
            //消失时间
            .wDisappelSecondSet(1.6)
            //加载框大小
            .wLoadingSizeSet(CGSizeMake(50, 50))
            .wStart();
        }
           break;
        case 5:{
          Dialog()
          .wTitleSet(@"加载中...")
          .wTypeSet(DialogTypeLoading)
          .wShadowShowSet(NO)
          //展示右上角关闭按钮
          .wShowCloseSet(YES)
          .wLoadingTypeSet(LoadingStyleSystem)
          .wStart();
            break;
        }
        case 6:{
            [LoadingVC showHudWithText:@"加载中..." inView:self.view];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [LoadingVC hideHudInView:self.view];
            });
        }
        default:
            break;
    }
}

//封装一个简单的加载框
+ (void)showHudWithText:(NSString*)text inView:(UIView*)view{
    Dialog()
    .wLoadingColorSet(DialogColor(0xFF9900))
    .wTitleSet(text)
    .wTypeSet(DialogTypeLoading)
    .wLoadingTypeSet(LoadingStyleWait)
    .wShadowAlphaSet(0.01)
    .wShowCloseSet(NO)
    .wHideAnimationSet(AninatonHideNone)
    .wAnimationDurtionSet(1)
    .wLoadingSizeSet(CGSizeMake(50, 50))
    .wTagSet(222)
    .wStartView(view);
}

//封装一个简单的加载框
+ (void)hideHudInView:(UIView*)view{
    [WMZDialog closeWithshowView:view tag:222 block:nil];
}
@end

