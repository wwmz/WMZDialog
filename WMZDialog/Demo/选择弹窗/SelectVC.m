


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
     self.dataArr = @[@"单选",@"多选(自定义cell)"];
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
            .wListDefaultValueSet(@[@(2)]) //默认选中第三个
//            .wListDefaultValueSet(@[@"爬山"])   //默认选中爬山
            .wDataSet(@[@"游泳",@"打篮球",@"打羽毛球",@"爬山",@"踢足球",@"乒乓球",@"游泳",@"打篮球",@"打羽毛球",@"爬山",@"踢足球",@"乒乓球"])
            //添加下划线
//            .wSeparatorStyleSet(UITableViewCellSeparatorStyleSingleLine)
//            //单选底部添加确定按钮
//            .wAddBottomViewSet(YES)
//            //单选底部添加取消按钮
//            .wEventCancelFinishSet(^(id anyID, id otherData) {
//
//            })
//            .wEventOKFinishSet(^(id anyID, id otherData) {
//                NSLog(@"%@",anyID);
//            })
            //父view
            .wStartView(self.view);
        }
            break;
        case 1:{
            Dialog()
            .wEventCancelFinishSet(^(id anyID, id otherData) {
                
            })
            //自定义cell
            .wCustomCellSet(^UITableViewCell *(NSIndexPath *indexPath, UITableView *tableView, id model, BOOL isSelected) {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
                if (!cell) {
                    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
                }
                cell.textLabel.textColor = isSelected?[UIColor redColor]:DialogDarkColor(UIColor.blackColor, UIColor.whiteColor);
                cell.textLabel.text = model;
                cell.detailTextLabel.text = @"自定义cell";
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            })
            .wTypeSet(DialogTypeSelect)
            .wEventOKFinishSet(^(id anyID, id otherData) {
                NSLog(@"%@",anyID);
            })
//            .wListDefaultValueSet(@[@"打篮球",@"爬山"])  //默认选中  也可以传入字典 显示值key为@"name" 
            //出现动画
            .wShowAnimationSet(AninationCombineTwo)
            .wTitleSet(@"标题")
            .wMessageSet(@"提示")
            .wMultipleSelectionSet(YES)
            .wSelectShowCheckedSet(YES)
            .wDataSet(@[@"游泳",@"打篮球",@"打羽毛球",@"爬山",@"踢足球",@"乒乓球"])
            .wStart();
        }
            break;
        default:
            break;
    }
}


@end
