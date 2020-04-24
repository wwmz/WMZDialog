//
//  PopVC.m
//  WMZDialog
//
//  Created by wmz on 2019/9/16.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "PopVC.h"
@interface PopVC ()

@end

@implementation PopVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.tag = 111;
    [btn setTitleColor:DialogColor(0xF4606C) forState:UIControlStateNormal];
    [btn setTitle:@"导航弹窗" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [btn sizeToFit];
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = barItem;
    

    self.dataArr = @[@"上",@"左",@"下",@"tableview",@"右",@"collectionView",@"scrollView",@"嵌套视图"];
}

//导航栏点击
- (void)onBtnAction:(UIButton*)temp{
    Dialog()
    .wPercentAngleSet(0.9)
    //导航栏上 新写法 旧写法传入wNavigationItem也有效
    .wTapViewTypeSet(DiaPopInViewNavi)
    .wTypeSet(DialogTypePop).wDataSet(@[@{@"name":@"微信",@"image":@"wallet"},
                                        @{@"name":@"支付宝",@"image":@"wallet"},
                                        @{@"name":@"米聊",@"image":@"wallet"},
                                        @{@"name":@"飞信",@"image":@"wallet"},
                                        @{@"name":@"微博",@"image":@"wallet"}])
    .wTapViewSet(temp)
    .wStart();
}


- (void)action:(UIButton*)sender{
    
    
    if (sender.tag == 3) {
        [self.navigationController pushViewController:[NSClassFromString(@"TableViewPopDemo") new] animated:YES];
        return;
    }else if(sender.tag == 5){
        [self.navigationController pushViewController:[NSClassFromString(@"CollectionViewPopDemo") new] animated:YES];
               return;
    }else if(sender.tag == 6){
        [self.navigationController pushViewController:[NSClassFromString(@"ScrollViewPopDemo") new] animated:YES];
               return;
    }else if(sender.tag == 7){
        [self.navigationController pushViewController:[NSClassFromString(@"NestedPopDemo") new] animated:YES];
               return;
    }
    
    NSInteger type = sender.tag>3?3:sender.tag;
    if (sender.tag == 999) {
        type = directionDowm;
    }
    
    Dialog().wTypeSet(DialogTypePop)
    //点击事件
    .wEventFinishSet(^(id anyID, NSIndexPath *path, DialogType type) {
        NSLog(@"%@ %@",anyID,path);
    })
    //cell高度
//    .wCellHeightSet(100)
    //自定义cell
//    .wMyCellSet(^UITableViewCell *(NSIndexPath *indexPath, UITableView *tableView, id model) {
//        return [UITableViewCell new];
//    })
    //弹出动画
    .wShowAnimationSet(AninatonZoomIn)
    //消失动画
    .wHideAnimationSet(AninatonZoomOut)
    //全部圆角 用法和系统的UIRectCorner相同
    .wPopViewRectCornerSet(DialogRectCornerAllCorners)
    //弹窗位置
    .wDirectionSet(type)
    //数据
    .wDataSet(@[
                @{@"name":@"微信",@"image":@"wallet"},
                @{@"name":@"支付宝",@"image":@"aaa"},
                @{@"name":@"米聊",@"image":@"bbb"},
                @{@"name":@"微信1",@"image":@"wallet"},
                ])
    //弹出视图
    .wTapViewSet(sender)
    .wStart();
}
@end
