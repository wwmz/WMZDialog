//
//  SheetVC.m
//  WMZDialog
//
//  Created by wmz on 2020/4/10.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "SheetVC.h"

@interface SheetVC ()

@end

@implementation SheetVC

- (void)viewDidLoad {
    [super viewDidLoad];
     self.dataArr = @[@"单选",@"多选",@"多选(底部取消)",@"传字典"];
}

-(void)action:(UIButton*)sender{
    switch (sender.tag) {
        case 0:{
            Dialog()
            .wCustomMainViewSet(^(UIView *mainView) {
                           [mainView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                               if (obj.frame.size.height == Dialog_GetWNum(20)) {
                                   [obj removeFromSuperview];
                                   *stop = YES;
                                   return;
                               }
                           }];
                       })
            .wTypeSet(DialogTypeSheet)
            .wDataSet(@[@"男",@"女",@"保密"])
            .wTitleSet(@"性别选择")
            //完成操作事件
            .wEventFinishSet(^(id anyID,NSIndexPath *path, DialogType type) {
                NSLog(@"%@",anyID);
            })
            
            //默认选中第二个
            .wListDefaultValueSet(@[@(1)])
            //默认选中男
//            .wListDefaultValueSet(@[@"男"])
            .wStart();
        }
            break;
        case 1:{
            Dialog().wTypeSet(DialogTypeSheet)
            //点击确定事件
            .wEventOKFinishSet(^(id anyID, id otherData) {
                NSLog(@"确定 %@",anyID);
            })
            .wDataSet(@[@"男",@"女",@"保密"])
            //默认选中男,女
            .wListDefaultValueSet(@[@"男",@"女"])
            .wMultipleSelectionSet(YES)
            .wSelectShowCheckedSet(YES)
            .wStart();
        }
            break;
        case 2:{
            Dialog()
            .wTypeSet(DialogTypeSheet)
            //如果需要多选底部也显示 取消 加入此事件
            .wEventCancelFinishSet(^(id anyID, id otherData) {})
             //点击确定事件
            .wEventOKFinishSet(^(id anyID, id otherData) {
                NSLog(@"确定 %@",anyID);
            })
            .wDataSet(@[@"男",@"女",@"保密"])
            .wMultipleSelectionSet(YES)
            .wShowAnimationSet(AninatonShowTop)
            .wHideAnimationSet(AninatonHideTop)
            .wStart();
        }
            break;
            
        case 3:{
            Dialog().wTypeSet(DialogTypeSheet)
            .wDataSet(@[@{@"name":@"男",@"id":@"1"},
                        @{@"name":@"女",@"id":@"2"},
                        @{@"name":@"未知",@"id":@"3"}])
            .wTitleSet(@"")
            .wCancelTitleSet(@"")//隐藏底部取消按钮
            //默认选中id为3
            .wListDefaultValueSet(@[@"3"])
            .wStart();
        }
            break;
            
        default:
            break;
    }
}


@end
