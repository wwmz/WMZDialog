//
//  TableViewPopDemo.m
//  WMZDialog
//
//  Created by wmz on 2019/12/21.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "TableViewPopDemo.h"
#import "WMZDialog.h"
#define random1(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]
#define randomColor1 random1(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
@interface TableViewPopDemo ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *ta;
@property(nonatomic,strong)NSArray *taData;
@end

@implementation TableViewPopDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITableView *ta = [[UITableView alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width,self.view.frame.size.height-100) style:UITableViewStyleGrouped];
    [self.view addSubview:ta];
    if (@available(iOS 11.0, *)) {
        ta.estimatedRowHeight = 0.01;
        ta.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [ta registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"UITableViewHeaderView"];
    [ta registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"UITableViewFooterView"];
    ta.dataSource = self;
    ta.delegate = self;
    self.ta = ta;
}

#pragma -mark HeaderView使用
- (void)headAction:(UIButton*)btn{
    Dialog()
    .wTypeSet(DialogTypePop)
    //在tableview上
    .wTapViewTypeSet(DiaPopInViewTableView)
    //弹出节点
    .wTableViewSectionHeadSet(btn.tag)
    .wShowAnimationSet(AninatonZoomIn)
    .wHideAnimationSet(AninatonZoomOut)
    //圆角
    .wPopViewRectCornerSet(DialogRectCornerTopLeft|DialogRectCornerTopRight)
    .wTapViewSet(btn)
    .wDataSet(@[
    @{@"name":@"微信",@"image":@"wallet"},
    @{@"name":@"支付宝",@"image":@"aaa"},
    @{@"name":@"米聊",@"image":@"bbb"},
    @{@"name":@"微信1",@"image":@"wallet"},
    ])
    .wStart();
}

#pragma -mark FooterView使用
- (void)footAction:(UIButton*)btn{
    Dialog()
    .wTypeSet(DialogTypePop)
    .wTapViewTypeSet(DiaPopInViewTableView)
    //tableViewFoot
    .wTapViewTableViewFootSet(YES)
    .wTableViewSectionHeadSet(btn.tag)
    //圆角
    .wPopViewRectCornerSet(DialogRectCornerTopLeft|DialogRectCornerTopRight|DialogRectCornerBottomLeft)
    .wShowAnimationSet(AninatonZoomIn)
    .wHideAnimationSet(AninatonZoomOut)
    .wTapViewSet(btn)
    .wDataSet(@[
    @{@"name":@"微信",@"image":@"wallet"},
    @{@"name":@"支付宝",@"image":@"aaa"},
    @{@"name":@"米聊",@"image":@"bbb"},
    @{@"name":@"微信1",@"image":@"wallet"},
    ])
    .wStart();
}

#pragma -mark tableViewCell使用
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    Dialog()
    .wTypeSet(DialogTypePop)
    .wTapViewTypeSet(DiaPopInViewTableView)
    .wShowAnimationSet(AninatonZoomIn)
    .wHideAnimationSet(AninatonZoomOut)
    .wTapViewSet(cell)
    .wDataSet(@[
    @{@"name":@"微信",@"image":@"wallet"},
    @{@"name":@"支付宝",@"image":@"aaa"},
    @{@"name":@"米聊",@"image":@"bbb"},
    @{@"name":@"微信1",@"image":@"wallet"},
    ])
    .wStart();
}
#pragma -mark cell上控件的弹窗
- (void)cellBtnTap:(UIButton*)sender{
    Dialog()
    .wTypeSet(DialogTypePop)
//    .wDirectionSet(directionright)
    .wTapViewTypeSet(DiaPopInViewTableView)
    .wShowAnimationSet(AninatonZoomIn)
    .wHideAnimationSet(AninatonZoomOut)
    .wTapViewSet(sender)
    ///如果是自定义的tableView或者collectionView或scrollView
//    .wPopNestStopViewSet(@"GNTableView")
    
//    .wMainBackColorSet([UIColor redColor])
    .wDataSet(@[
       @{@"name":@"微信",@"image":@"wallet"},
       @{@"name":@"支付宝",@"image":@"aaa"},
       @{@"name":@"米聊",@"image":@"bbb"},
       @{@"name":@"微信1",@"image":@"wallet"},
       ])
    .wStart();
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UITableViewHeaderFooterView *head = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"UITableViewHeaderView"];
    head.frame = CGRectMake(0, 0, DialogScreenW, 50);
    head.tag = section;
    head.contentView.backgroundColor = randomColor1;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(DialogScreenW-200, 0, 100, 50);
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    btn.tag = section;
    [head addSubview:btn];
    [btn setTitle:@"尾部点我弹出" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(footAction:) forControlEvents:UIControlEventTouchUpInside];
    return head;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UITableViewHeaderFooterView *head = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"UITableViewFooterView"];
    head.frame = CGRectMake(0, 0, DialogScreenW, 50);
    head.tag = section;
    head.contentView.backgroundColor = randomColor1;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(DialogScreenW-200, 0, 100, 50);
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    btn.tag = section;
    [head addSubview:btn];
    [btn setTitle:@"头部点我弹出" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(headAction:) forControlEvents:UIControlEventTouchUpInside];
    return head;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 8;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:14.0f];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld-%ldTableViewCell点我弹出",(long)indexPath.section,(long)indexPath.row];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(DialogScreenW-200, 15, 80, 50);
    [cell.contentView addSubview:btn];
    [btn setTitle:@"点我弹出" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(cellBtnTap:) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = randomColor1;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

@end

