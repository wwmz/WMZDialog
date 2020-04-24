
//
//  BuyCarVC.m
//  WMZDialog
//
//  Created by wmz on 2019/7/8.
//  Copyright © 2019年 wmz. All rights reserved.
//

#import "BuyCarVC.h"
#import "WMZDialog.h"
//需要导入WMZTag https://github.com/wwmz/WMZTags
#import "tagOneCell.h"
@interface BuyCarVC ()

@end

@implementation BuyCarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArr = @[@"自由配置1",@"自由配置2",@"自由配置3"];
}

- (void)action:(UIButton*)sender{
    //数据可自己配置
    NSDictionary *dic = @{
                          @(0):@[
                                  @{
                                      @"style":@"颜色分类",
                                      @"data":@[@"土豪金",@"深空灰色",@"闪亮银色",@"风骚红色",@"原谅绿色",@"唯美白色"]
                                      },
                                  @{
                                      @"style":@"套餐类型",
                                      @"data":@[@"套餐1",@"套餐2",@"套餐3",@"套餐4",@"套餐5"]
                                      },
                                  @{
                                      @"style":@"配置",
                                      @"data":@[@"i7+1050ti+512固态",@"i5+1060+256固态",@"i7+2060+256固态+1g机械",@"i7+2060+256固态+1g机械+送鼠标"]
                                      },
                                  @{
                                      @"style":@"分期",
                                      @"data":@[@"24期",@"12期",@"6期",@"3期"]
                                      },
                                  @"money"
                                  ],
                          @(1):@[
                                  @{
                                      @"style":@"颜色分类",
                                      @"data":@[@"土豪金",@"深空灰色",@"闪亮银色",@"风骚红色",@"原谅绿色",@"唯美白色"]
                                      },
                                  @{
                                      @"style":@"分期",
                                      @"data":@[@"24期",@"12期",@"6期",@"3期"]
                                      },
                                  @"money"
                                  ],
                          @(2):@[
                                  @{
                                      @"style":@"颜色分类",
                                      @"data":@[@"土豪金",@"深空灰色",@"闪亮银色",@"风骚红色",@"原谅绿色",@"唯美白色"]
                                      },
                                  @"money"
                                  ]
                          };
    NSArray *myData = dic[@(sender.tag)];
    Dialog()
    .wDataSet(myData)
    .wImageNameSet(@"computer")
    .wMessageSet(@"炫龙DDR3")
    .wMessageColorSet([UIColor redColor])
    .wTitleSet(@"请选择")
    //自动布局
    .wCellHeightSet(0)
    .wOKColorSet([UIColor whiteColor])
    //完成操作事件
    .wEventFinishSet(^(id anyID,NSIndexPath *path, DialogType type) {
        NSLog(@"%@",anyID);
    })
   // 自定义tableviewCell
    .wMyCellSet(^UITableViewCell *(NSIndexPath *indexPath, UITableView *tableView, id model) {
        if (indexPath.row==myData.count-1&&[model isKindOfClass:[NSString class]]) {
            moneyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"moneyCell"];
            if(!cell){
                cell = [[moneyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"moneyCell"] ;
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else{
            tagOneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WMZTagCell"];
            if(!cell){
                cell = [[tagOneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"WMZTagCell"] ;
            }
            cell.row = indexPath.row;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model = model;
            return cell;
        }
    })
    .wTypeSet(DialogTypeBuyCar).wStart();
}

@end
