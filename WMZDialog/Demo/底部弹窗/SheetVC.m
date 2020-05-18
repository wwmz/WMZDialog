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
     self.dataArr = @[@"单选",@"多选",@"多选(底部取消)"];
}

-(void)action:(UIButton*)sender{
    switch (sender.tag) {
        case 0:{
            Dialog().wTypeSet(DialogTypeSheet)
            .wDataSet(@[@"男",@"女",@"保密"])
            .wTitleSet(@"性别选择")
            //完成操作事件
            .wEventFinishSet(^(id anyID,NSIndexPath *path, DialogType type) {
                NSLog(@"%@",anyID);
            })
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
            
        default:
            break;
    }
}


@end
