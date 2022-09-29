//
//  ViewController.m
//  WMZDialog
//
//  Created by wmz on 2019/6/5.
//  Copyright © 2019年 wmz. All rights reserved.
//

#import "ViewController.h"
#import "WMZDialog.h"
#import "BaseVC.h"
#import "WMZDialog-Swift.h"
#import "Masonry.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *arr;
@property (nonatomic, strong) NSArray *vcArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.arr =@[@"普通弹窗",@"底部弹窗",@"自动消失弹窗",@"吐司弹窗",@"支付弹窗",@"分享弹窗",@"自适应编辑弹窗",@"选择弹窗",@"拾取器弹窗",@"任意位置弹出列表",@"下载弹窗",@"下拉无限级菜单弹窗",@"广告弹窗",@"地区弹窗",@"日期时间弹窗",@"底部菜单弹窗",@"顶部菜单弹窗",@"加载框",@"ios13Present弹窗",@"日历弹窗",@"自定义弹窗",@"swift示范",@"优先级多个弹窗",@"新自定义弹窗（实现协议）",@"暗黑模式(跟随系统变化)"];

    self.vcArr = @[@"NormalVC",@"SheetVC",@"AutoDisappealVC",@"ToastVC",@"PayVC",@"ShareVC",@"WriteVC",@"SelectVC",@"PickVC",@"PopVC",@"DownVC",@"MenusSelectVC",@"AdvertisementVC",@"LocationVC",@"DateTimeVC",@"TabbarMenuVC",@"NaviMenuVC",@"LoadingVC",@"PresentVC",@"CalanderVC",@"CustomVC",@"",@"MuchVC",@"NewCustomVC",@"DarkVC"];

    self.tableView =  [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 50;
    if (@available(iOS 11.0, *)) {

    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.tableView.rowHeight = 50;
    [self.view addSubview:self.tableView];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)updateViewConstraints{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    [super updateViewConstraints];
}

//展示所有属性
- (void)showAllProperties{
    Dialog()
    //自定义视图
    .wCustomTextViewSet(^(UITextView *textView) {
        
    })
    .wCustomMessageLaSet(^(UILabel *messageLa) {
        
    })
    .wCustomOKBtnSet(^(UIButton *okBtn) {
        
    })
    .wCustomCloseBtnSet(^(UIButton *closeBtn) {
        
    })
    .wCustomCancelBtnSet(^(UIButton *cancelBtn) {
        
    })
    .wCustomMainViewSet(^(UIView *mainView) {
        
    })
    .wCustomTableViewSet(^(UITableView *tableView) {
        tableView.bounces = NO;
    })
//    //自定义点击
//    .wSelectCellSet(^(NSIndexPath *indexPath, UITableView *tableView, id model) {
//
//    })
    //自定义cell内容 带选中select
    .wCustomCellSet(^UITableViewCell *(NSIndexPath *indexPath, UITableView *tableView, id model, BOOL isSelected) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        cell.textLabel.textColor = isSelected?[UIColor redColor]:[UIColor blueColor];
        cell.textLabel.text = model;
        return cell;
    })
    .wSeparatorSet(@",")
    //出现时候的动画
    .wShowAnimationSet(1)
    //消失时候的动画
    .wHideAnimationSet(1)
    //动画持续时间
    .wAnimationDurtionSet(0.7)
    
    //下拉无限级菜单选中事件
    .wEventMenuClickSet( ^(id anyID, NSInteger section, NSInteger row) {
        NSLog(@"菜单点击方法 当前选中值:%@ 当前选中列:%ld 当前选中行:%ld",anyID,(long)section,(long)row);
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
    //点击的视图的位置
    .wTapViewSet([UIView new])
    //数据
    .wDataSet(@[])
    //类型
    .wTypeSet(DialogTypeNornal)
    //子数据
    .wSonDataSet(@[@"农业银行",@"招商银行",@"建设银行",@"工商银行",@"中国银行",@"交通银行"])
    //键盘类型
    .wWirteKeyBoardTypeSet(UIKeyboardTypeDefault)
    //宽度
    .wWidthSet(DialogRealW(500))
    //高度
    .wHeightSet(DialogRealW(300))
    //自动消失时间
    .wDisappelSecondSet(1.5f)
    //按钮的高度
    .wMainBtnHeightSet(DialogRealW(60))
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
    .wMainOffsetYSet(DialogRealW(20))
    //主视图间的y轴间距
    .wMainOffsetXSet(DialogRealW(15))
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
    .wKeyBoardMarginYSet(DialogRealW(80))
    //支付密码的长度
    .wPayNumSet(6)
    //默认支付选择方式
    .wDefaultSelectPayStrSet(@"农业银行")
    //遮罩层能否点击
    .wShadowCanTapSet(YES)
    //遮罩层是否显示
    .wShadowShowSet(YES)
    //开启毛玻璃效果
    .wEffectShowSet(NO)
    //编辑框提示语
    .wPlaceholderSet(@"请输入内容")
    //编辑框最大文字数量 -1 不限制
    .wWirteTextMaxNumSet(-1)
    //编辑框最大行数
    .wWirteTextMaxLineSet(7)
    //气泡角度位置
    .wPercentAngleSet(0.5f)
    //弹出视图的位置
    .wPercentOrginXSet(1.0f)
    //弹出视图的方向
    .wDirectionSet(directionUp)
    //显示图片的大小
    .wImageSizeSet(CGSizeMake(DialogRealW(500), DialogRealW(500)))
    //图片地址
    .wImageNameSet(@"advise")
    //进度条闲置的颜色
    .wProgressTintColorSet(DialogColor(0xFF9900))
    //进度条运动时的颜色
    .wTrackTintColorSet(DialogColor(0xF3F4F6))
    //自定义弹窗时是否添加底部的确定取消按钮
    .wAddBottomViewSet(YES)
    //地区联动 显示的层级
    .wLocationTypeSet(DialogLocationProAndCityAndDis)
    //联动的样式  tableview列表或者pickview显示
    .wChainTypeSet(ChainPickView)
    //日期时间
    .wDateTimeTypeSet(@"yyyy年MM月dd日HH时mm分ss秒")
    //开启pickview无限循环
    .wPickRepeatSet(NO)
    //加载框内容
    .wLoadingTypeSet(LoadingStyleRight)
    //加载框颜色
    .wLoadingColorSet(DialogColor(0xFF9900))
    //加载框size
    .wLoadingSizeSet(CGSizeMake(50, 50))
    //多选
    .wMultipleSelectionSet(NO)
    //选中是否显示打钩
    .wSelectShowCheckedSet(NO)
    //自定义视图
    .wCustomTitleLaSet(^(UILabel *titleLa) {
       
    })
    //开始
    .wStart();
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  1;}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.arr.count;}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *data = self.arr[indexPath.section];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myCell"];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = data;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.vcArr[indexPath.section] isEqualToString:@""]) {
        SwiftVC *VC = [SwiftVC new];
        VC.name = self.arr[indexPath.section];
        VC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:VC animated:YES];
    }else{
        BaseVC *VC = [NSClassFromString(self.vcArr[indexPath.section]) new];
        VC.name = self.arr[indexPath.section];
        [self.navigationController pushViewController:VC animated:YES];
    }
}
@end

