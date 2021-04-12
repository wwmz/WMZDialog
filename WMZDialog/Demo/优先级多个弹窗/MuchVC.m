//
//  MuchVC.m
//  WMZDialog
//
//  Created by wmz on 2021/4/12.
//  Copyright © 2021 wmz. All rights reserved.
//

#import "MuchVC.h"
#import "CustomView.h"
@interface MuchVC ()

@end

@implementation MuchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setDataArr:@[@"最高级",@"最低级",@"自定义级别"]];
}

-(void)action:(UIButton*)sender{
    switch (sender.tag){
        case 0:{
            for (int i = 0; i < 5; i++) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(i * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self dialogWith:DialogLevelHigh index:i];
                });
            }
            break;
        }
        case 1:{
            for (int i = 0; i < 5; i++) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(i * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self dialogWith:DialogLevelLow index:i];
                });
            }
            break;;
        }
        case 2:{
            for (int i = 0; i < 5; i++) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(i * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self dialogWith:random()%10 index:i];
                });
            }
            break;;
        }
            
    }
}

- (void)dialogWith:(DialogLevel)level index:(NSInteger)index{
    if (level == DialogLevelHigh) {
        index = -index;
    }
    Dialog()
    //设置层级 可传NSInteger值 值越大的层级越高 越在前面
    .wLevelSet(level)
    //设置不同tag
    .wTagSet(random()%100000)
    //自适应宽度
    .wWidthSet(0)
    .wTypeSet(DialogTypeMyView)
    .wShowAnimationSet(AninatonZoomIn)
    .wMyDiaLogViewSet(^UIView *(UIView *mainView) {
        mainView.layer.masksToBounds = YES;
        UIView *view = [[CustomView alloc] initWithFrame:CGRectMake(0, 0, 300 + index* 20, 250 + index* 20) superView:mainView];
        mainView.layer.masksToBounds = YES;
        mainView.layer.cornerRadius = 10;
        return view;
    })
    .wStart();
}


@end
