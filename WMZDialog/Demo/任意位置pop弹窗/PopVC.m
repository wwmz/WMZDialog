//
//  PopVC.m
//  WMZDialog
//
//  Created by wmz on 2019/9/16.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "PopVC.h"
#import "Masonry.h"
@interface PopVC ()

@end

@implementation PopVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.tag = 111;
    [btn setTitleColor:DialogColor(0xF4606C) forState:UIControlStateNormal];
    [btn setTitle:@"微信右上角" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(customWX:) forControlEvents:UIControlEventTouchUpInside];
    [btn sizeToFit];
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = barItem;
    

    self.dataArr = @[@"上",@"左",@"下",@"tableview",@"右",@"collectionView",@"scrollView",@"嵌套视图",@"行列内容",@"自定义内容"];
}

- (void)action:(UIButton*)sender{
    if(sender.tag == 8){
        [self rowView:sender];
        return;
    }
    
    if(sender.tag == 9){
        [self customView:sender];
        return;
    }
    
    else if (sender.tag == 3) {
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
    //弹出位置的距离 default 0
//    .wMainOffsetYSet(10)
    //弹出三角形的size default  CGSizeMake(DialogRealW(30), DialogRealW(20)
//    .wAngleSizeSet(CGSizeMake(20, 15))
    //可以设置三角形的颜色
//    .wMainBackColorSet([UIColor orangeColor])
    
     ///如果需要背景为图片的时候
//    .wCustomMainViewSet(^(UIView *mainView) {
//        mainView.layer.contents = (id)[UIImage imageNamed:@"healthy"].CGImage;
//        for (WMZDialogTableView *view in [mainView subviews]) {
//            if ([view isKindOfClass:WMZDialogTableView.class]) {
//                view.backgroundColor = UIColor.clearColor;
//                [view layoutIfNeeded];
//                for (UITableViewCell *cell in view.visibleCells) {
//                    cell.contentView.backgroundColor = UIColor.clearColor;
//                    cell.backgroundColor = UIColor.clearColor;
//                }
//                break;;
//            }
//        }
//    })
    
    //下划线显示
    .wSeparatorStyleSet(UITableViewCellSeparatorStyleSingleLine)
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

///行列视图
- (void)rowView:(UIButton*)sender{
    Dialog()
    ///自定义修改默认内容
    .wCustomShareViewSet(^(UIScrollView * _Nullable shareView) {
        NSLog(@"%@",shareView.subviews);
    })
    .wTypeSet(DialogTypePop)
    ///分享类型内容
    .wPopStyleTypeSet(DialogPopTypeShare)
    ///多少列 此处必须设置正确
    .wColumnCountSet(3)
    ///多少行  此处必须设置正确
    .wRowCountSet(2)
    ///item高度宽度
    .wCellHeightSet(60)
    .wTapViewSet(sender)
    .wEventFinishSet(^(id anyID, NSIndexPath *path, DialogType type) {
        NSLog(@"%@ %@",anyID,path);
    })
    .wDirectionSet(0)
//    .wDataSet(@[@"微信",@"支付宝",@"米聊",@"微信1",@"微信2"])
    .wDataSet(@[
        @{@"name":@"微信",@"image":@"wallet"},
        @{@"name":@"支付宝",@"image":@"aaa"},
        @{@"name":@"米聊",@"image":@"bbb"},
        @{@"name":@"微信1",@"image":@"wallet"},
        @{@"name":@"微信1",@"image":@"wallet"},
        ])
    .wStart();
}

///自定义视图
- (void)customView:(UIButton*)sender{
    Dialog()
    .wTypeSet(DialogTypePop)
    ///自定义类型内容
    .wPopStyleTypeSet(DialogPopTypeCustom)
    ///自定义内容
    .wPopCustomViewSet(^UIView *{
        UIView *mainView = UIView.new;
        mainView.frame = CGRectMake(0, 0, 100, 100);
        mainView.backgroundColor = UIColor.redColor;
        return mainView;
    })
    .wTapViewSet(sender)
    .wDirectionSet(0)
    .wStart();
}

//自定义微信例子
- (void)customWX:(UIButton*)sender{
    Dialog()
    .wTypeSet(DialogTypePop)
    //隐藏阴影
    .wShadowAlphaSet(0.02)
    //点击事件
    .wEventFinishSet(^(id anyID, NSIndexPath *path, DialogType type) {
        NSLog(@"%@ %@",anyID,path);
    })
    //导航栏上 新写法 旧写法传入wNavigationItem也有效
    .wTapViewTypeSet(DiaPopInViewNavi)
    //三角形中心点
    .wPercentAngleSet(0.9)
    .wShowAnimationSet(AninatonZoomIn)
    .wHideAnimationSet(AninatonZoomOut)
    //距离弹出点的距离
    .wMainOffsetYSet(10)
    //弹出点
    .wTapViewSet(sender)
    //自定义cell高度
    .wCellHeightSet(44)
    //自定义cell(如有需要)
    .wCustomCellSet(^UITableViewCell *(NSIndexPath *indexPath, UITableView *tableView, id model, BOOL isSelected){
        WXCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WXCell"];
        if (!cell) {
            cell = [[WXCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"WXCell"];
        }
        cell.myLine.hidden = (indexPath.row == 3);
        cell.myImage.image = [UIImage imageNamed:model[@"image"]?:@" "];
        cell.myLa.text = model[@"name"]?:@"";
        return cell;
    })
    //自定义三角形size
    .wAngleSizeSet(CGSizeMake(8, 8))
    //自定义三角形背景颜色
    .wMainBackColorSet(DialogColor(0x4d4b4d))
    //圆角
    .wPopViewRectCornerSet(DialogRectCornerAllCorners)
    .wDataSet(@[
                @{@"name":@"发起群聊",@"image":@"bbb"},
                @{@"name":@"添加朋友",@"image":@"aaa"},
                @{@"name":@"扫一扫",@"image":@"bbb"},
                @{@"name":@"收付款",@"image":@"aaa"},
    ])
    .wStart();
}
@end

@implementation WXCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.myLa];
        [self.contentView addSubview:self.myImage];
        [self.contentView addSubview:self.myLine];
        [self.myImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.centerY.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(25, 25));
        }];
        [self.myLa mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.myImage.mas_right).offset(10);
            make.centerY.mas_equalTo(0);
        }];
        [self.myLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(DialogK1px);
            make.right.mas_equalTo(0);
            make.left.equalTo(self.myLa.mas_left);
            make.bottom.mas_equalTo(0);
        }];
        self.contentView.backgroundColor  = DialogColor(0x4d4b4d);
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
- (UILabel *)myLa{
    if (!_myLa) {
        _myLa = [UILabel new];
        _myLa.textColor = [UIColor whiteColor];
        _myLa.font = [UIFont systemFontOfSize:15.0f];
    }
    return _myLa;
}
- (UIImageView *)myImage{
    if (!_myImage) {
        _myImage = [UIImageView new];
    }
    return _myImage;
}
- (UIView *)myLine{
    if (!_myLine) {
        _myLine = [UIView new];
        _myLine.backgroundColor = [UIColor whiteColor];
    }
    return _myLine;
}
@end
