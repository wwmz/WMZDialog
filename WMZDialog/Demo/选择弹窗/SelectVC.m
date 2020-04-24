


//
//  SelectVC.m
//  WMZDialog
//
//  Created by wmz on 2020/4/10.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "SelectVC.h"

@interface SelectVC ()

@end

@implementation SelectVC

- (void)viewDidLoad {
    [super viewDidLoad];
     self.dataArr = @[@"单选",@"多选"];
}

-(void)action:(UIButton*)sender{
    switch (sender.tag) {
        case 0:{
            Dialog()
            .wTypeSet(DialogTypeSelect)
            .wEventFinishSet(^(id anyID, NSIndexPath *path, DialogType type) {
                NSLog(@"%@ %@",anyID,path);
            })
            
            .wTitleSet(@"选择爱好")
            .wTitleColorSet([UIColor redColor]).wTitleFontSet(16.0)
            .wMessageSet(@"请选择")
            .wDataSet(@[@"游泳",@"打篮球",@"打羽毛球",@"爬山",@"踢足球",@"乒乓球"])
            .wStart();
        }
            break;
        case 1:{
            Dialog().wTypeSet(DialogTypeSelect)
            .wEventOKFinishSet(^(id anyID, id otherData) {
                NSLog(@"%@",anyID);
            })
            //出现动画
            .wShowAnimationSet(AninationCombineTwo)
            .wTitleSet(@"")
            .wMessageSet(@"")
            .wMultipleSelectionSet(YES).wSelectShowCheckedSet(YES)
            .wDataSet(@[@"游泳",@"打篮球",@"打羽毛球",@"爬山",@"踢足球",@"乒乓球"])
            .wStart();
        }
            break;
        default:
            break;
    }
}


@end
