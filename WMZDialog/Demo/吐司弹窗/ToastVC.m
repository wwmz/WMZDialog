//
//  ToastVC.m
//  WMZDialog
//
//  Created by wmz on 2021/4/22.
//  Copyright © 2021 wmz. All rights reserved.
//

#import "ToastVC.h"

@interface ToastVC ()

@end

@implementation ToastVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setDataArr:@[@"普通吐司",@"显示在底部",@"自定义位置",@"固定高度",@"改变样式"]];
}
- (void)action:(UIButton *)sender{
    switch (sender.tag) {
        case 0:
        {
            Dialog().wMessageSet(@"吐司\n吐司").wTypeSet(DialogTypeToast).wStart();
        }
            break;
        case 1:
        {
            Dialog()
            //位置
            .wToastPositionSet(DialogToastBottom)
            .wTypeSet(DialogTypeToast)
            .wMessageSet(@"Toast")
            //调整宽度
            .wMainOffsetXSet(30)
            .wStart();
        }
            break;
        case 2:
        {
            Dialog()
            .wMessageSet(@"Toast")
            //自定义位置
            .wCustomMainViewSet(^(UIView *mainView) {
                CGRect rect = mainView.frame;
                rect.origin.x = 30;
                rect.origin.y = 100;
                mainView.frame = rect;
            })
            .wTypeSet(DialogTypeToast)
            //调整宽度
            .wMainOffsetXSet(30)
            .wStart();
        }
            break;
        case 3:
        {
            Dialog()
            //固定40
            .wHeightSet(60)
            .wMessageSet(@"吐司\n吐司\n吐司\n吐司")
            .wTypeSet(DialogTypeToast).wStart();
        }
            break;
        case 4:
        {
            Dialog()
            .wMessageSet(@"Toast")
            .wMainRadiusSet(0)
            .wMessageColorSet(UIColor.whiteColor)
            .wMainBackColorSet(UIColor.orangeColor)
            .wTypeSet(DialogTypeToast).wStart();
        }
            break;
        default:
            break;
    }
}

@end
