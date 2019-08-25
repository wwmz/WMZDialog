//
//  ViewController.m
//  WMZDialog
//
//  Created by wmz on 2019/6/5.
//  Copyright © 2019年 wmz. All rights reserved.
//

#import "ViewController.h"
#import "WMZDialog.h"
@interface ViewController ()
{
    WMZDialog *alert;
}
@property(nonatomic,strong)NSString *name;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.tag = 111;
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn setTitle:@"导航弹窗" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = barItem;
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn1 setTitle:@"导航弹窗" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(onBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barItem1 = [[UIBarButtonItem alloc] initWithCustomView:btn1];
    self.navigationItem.rightBarButtonItem = barItem1;
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    NSArray *arr =@[@"普通弹窗",@"底部弹窗",@"自动消失弹窗",@"支付弹窗",@"分享弹窗",@"自适应编辑弹窗",@"选择弹窗",@"拾取器弹窗",@"倒计时弹窗",@"上下左右弹出列表",@"下载弹窗",@"下拉无限级菜单弹窗",@"广告弹窗",@"购物车弹窗",@"地区弹窗",@"日期时间弹窗",@"自定义弹窗"];
    
    for (int i = 0; i<arr.count; i++) {
        CGFloat X = (i % 2) * ([UIScreen mainScreen].bounds.size.width/3 + 20);
        CGFloat Y = (i / 2) * (40 + 20);
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i+1;
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.backgroundColor = [UIColor cyanColor];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(X+50, Y+100, [UIScreen mainScreen].bounds.size.width/3, 40);
        [self.view addSubview:btn];
    }
    
    
    

}

- (void)action:(UIButton*)temp{
    id data = nil;

    DiaDirection dir = arc4random() % 4;
    if (temp.tag == DialogTypePickSelect) {
        data = @[@[@"数据11",@"数据12",@"数据13",@"数据14"],
                 @[@"数据2",@"数据22",@"数据23",@"数据24"],
                 @[@"数据31",@"数据32",@"数据33",@"数据34"],
                 @[@"数据41",@"数据42",@"数据43",@"数据44"]];
    }else if (temp.tag == DialogTypeMyView) {
        DialogWeakSelf(self)
         Dialog()
        .wTypeSet(temp.tag)
        .wAddBottomViewSet(YES)
        .wEventOKFinishSet( ^(id anyID, id otherData) {
            DialogStrongSelf(self)
            NSLog(@"%@ %@",anyID,strongObject.name);
        })
        .wMyDiaLogViewSet(^UIView *(UIView *mainView) {
            UILabel *la = [UILabel new];
            la.text = @"外部自定义的文本";
            la.textColor = [UIColor cyanColor];
            la.textAlignment = NSTextAlignmentCenter;
            la.frame = CGRectMake(Dialog_GetWNum(20), 10, Dialog_GetWNum(460), 50);
            [mainView addSubview:la];

            UITextField *te = [UITextField new];
            te.placeholder = @"提示";
            te.layer.borderWidth = 1.0f;
            te.layer.borderColor = [UIColor lightGrayColor].CGColor;
            te.frame = CGRectMake(Dialog_GetWNum(20), CGRectGetMaxY(la.frame)+10, Dialog_GetWNum(460), 50);
            [mainView addSubview:te];
            //返回最底部的view
            return te;
        })
        .wStart();
        return;
    }else if (temp.tag == DialogTypeShare||temp.tag == DialogTypePop) {
        data = @[@{@"name":@"微信",@"image":@"wallet"},
                 @{@"name":@"支付宝",@"image":@"wallet"},
                 @{@"name":@"米聊",@"image":@"wallet"},
                 @{@"name":@"飞信",@"image":@"wallet"},
                 @{@"name":@"微博",@"image":@"wallet"}];
    }else if (temp.tag == DialogTypeTime) {
        data = @"100";
    }else if (temp.tag == DialogTypeDown){
        [self.navigationController pushViewController:[NSClassFromString(@"DownVC") new] animated:YES];
        return;
    }else if(temp.tag == DialogTypeMenusSelect){
        [self.navigationController pushViewController:[NSClassFromString(@"MenusSelectVC") new] animated:YES];
        return;
    }else if(temp.tag == DialogTypeBuyCar){
        [self.navigationController pushViewController:[NSClassFromString(@"BuyCarVC") new] animated:YES];
        return;
    }else if(temp.tag == DialogTypeLocation){
        [self.navigationController pushViewController:[NSClassFromString(@"LocationVC") new] animated:YES];
        return;
    }else if(temp.tag == DialogTypeDatePicker){
        [self.navigationController pushViewController:[NSClassFromString(@"DateTimeVC") new] animated:YES];
        return;
    }else{
        data = @[@"数据1",@"数据2",@"数据3",@"数据4",@"数据5",@"数据6",@"数据7"];
    }
     Dialog()
    //自定义cell内容
//    .wMyCellSet(^UITableViewCell *(NSIndexPath *indexPath, UITableView *tableView, id model) {
//    })
     //下拉无限级菜单选中事件
    .wEventMenuClickSet( ^(id anyID, NSInteger section, NSInteger row) {
        NSLog(@"菜单点击方法 当前选中值:%@ 当前选中列:%ld 当前选中行:%ld",anyID,section,row);
    })
    //关闭事件
    .wEventCloseSet(^(id anyID, id otherData) {
        NSLog(@"关闭");
    })
    //点击确定事件
    .wEventOKFinishSet(^(id anyID, id otherData) {
        NSLog(@"确定 %@",anyID);
    })
    //点击取消事件
    .wEventCancelFinishSet(^(id anyID, id otherData) {
        NSLog(@"取消");
    })
    //完成操作事件
    .wEventFinishSet(^(id anyID,NSIndexPath *path, DialogType type) {
        NSLog(@"%@",anyID);
    })
    //标题文本
    .wTitleSet(@"提示")
    //内容文本
    .wMessageSet(@"内容")
    //视图出现动画
    .wStyleSet(UIModalTransitionStyleCrossDissolve)
    //点击的视图的位置
    .wTapViewSet(temp)
    //数据
    .wDataSet(data)
    //类型
    .wTypeSet(temp.tag)
    //子数据
    .wSonDataSet(@[@"农业银行",@"招商银行",@"建设银行",@"工商银行",@"中国银行",@"交通银行"])
    //键盘类型
    .wWirteKeyBoardTypeSet(UIKeyboardTypeDefault)
    //宽度
    .wWidthSet(Dialog_GetWNum(500))
    //高度
    .wHeightSet(Dialog_GetHNum(300))
    //自动消失时间
    .wDisappelSecondSet(1.5f)
    //按钮的高度
    .wMainBtnHeightSet(Dialog_GetHNum(60))
    //当前控制器
    .wParentVCSet(self)
    //确定按钮文本
    .wOKTitleSet(@"确定")
    //取消按钮文本
    .wCancelTitleSet(@"取消")
    //确定按钮颜色
    .wOKColorSet(DialogColor(0xFF9900))
    //取消按钮颜色
    .wCancelColorSet(DialogColor(0x666666))
    //文本对齐方式
    .wTextAlignmentSet(NSTextAlignmentCenter)
    //主视图圆角
    .wMainRadiusSet(15.0f)
    //主视图背景颜色
    .wMainBackColorSet(DialogColor(0xFFFFFF))
    //线的颜色
    .wLineColorSet(DialogColor(0x333333))
    //主视图间的x轴间距
    .wMainOffsetYSet(Dialog_GetHNum(20))
    //主视图间的y轴间距
    .wMainOffsetXSet(Dialog_GetWNum(15))
    //线的透明度
    .wLineAlphaSet(0.5f)
    //标题的文本大小
    .wTitleFontSet(14.0f)
    //内容的文本大小
    .wMessageFontSet(16.0f)
    //确定按钮的文本大小
    .wOKFontSet(16.0f)
    //取消按钮的文本大小
    .wCancelFontSet(16.0f)
    //遮罩层的透明度
    .wShadowAlphaSet(0.4f)
    //遮罩层的颜色
    .wShadowColorSet(DialogColor(0x333333))
    //主视图距离弹出键盘的距离
    .wKeyBoardMarginYSet(Dialog_GetHNum(80))
    //支付密码的长度
    .wPayNumSet(6)
    //默认支付选择方式
    .wDefaultSelectPayStrSet(@"农业银行")
    //遮罩层能否点击
    .wShadowCanTapSet(YES)
    //遮罩层是否显示
    .wShadowShowSet(YES)
    //编辑框最大文字数量
    .wWirteTextMaxNumSet(-1)
    //编辑框最大行数
    .wWirteTextMaxLineSet(7)
    //气泡角度位置
    .wPercentAngleSet(0.5f)
    //弹出视图的位置
    .wPercentOrginXSet(1.0f)
    //弹出视图的方向
    .wDirectionSet(dir)
    //显示图片的大小
    .wImageSizeSet(temp.tag==DialogTypeAdvertisement?CGSizeMake(Dialog_GetWNum(500), Dialog_GetWNum(500)):CGSizeMake(Dialog_GetWNum(110), Dialog_GetWNum(110)))
    //图片地址
    .wImageNameSet(temp.tag==DialogTypeAdvertisement?@"advise":@"down_tyx")
    //进度条闲置的颜色
    .wProgressTintColorSet(DialogColor(0xFF9900))
    //进度条运动时的颜色
    .wTrackTintColorSet(DialogColor(0xF3F4F6))
    //自定义弹窗时是否添加底部的确定取消按钮
    .wAddBottomViewSet(YES)
    //地区联动 显示的层级 支持只显示1 2 3层
    .wLocationTypeSet(3)
    //联动的样式  tableview列表或者pickview显示
    .wChainTypeSet(ChainPickView)
    //日期时间
    .wDateTimeTypeSet(@"yyyy年MM月dd日HH时mm分ss秒")
    //开启pickview无限循环
    .wPickRepeatSet(NO)
    //开始
    .wStart();
}


- (void)onBtnAction:(UIButton*)temp{
    Dialog()
    .wPercentAngleSet(temp.tag==111?0.1:0.9)
    .wNavigationItemSet(YES)   //导航栏标题必须添加这一属性
    .wTypeSet(DialogTypePop).wDataSet(@[@{@"name":@"微信",@"image":@"wallet"},
                                        @{@"name":@"支付宝",@"image":@"wallet"},
                                        @{@"name":@"米聊",@"image":@"wallet"},
                                        @{@"name":@"飞信",@"image":@"wallet"},
                                        @{@"name":@"微博",@"image":@"wallet"}]).wTapViewSet(temp).wStart();
}


@end
