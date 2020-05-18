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
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *arr;
@property(nonatomic,strong)NSArray *vcArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.arr =@[@"普通弹窗",@"底部弹窗",@"自动消失弹窗",@"支付弹窗",@"分享弹窗",@"自适应编辑弹窗",@"选择弹窗",@"拾取器弹窗",@"倒计时弹窗",@"上下左右弹出列表",@"下载弹窗",@"下拉无限级菜单弹窗",@"广告弹窗",@"地区弹窗",@"日期时间弹窗",@"底部菜单弹窗",@"顶部菜单弹窗",@"加载框",@"ios13Present弹窗",@"日历弹窗",@"自定义弹窗"];

    self.vcArr = @[@"NormalVC",@"SheetVC",@"AutoDisappealVC",@"PayVC",@"ShareVC",@"WriteVC",@"SelectVC",@"PickVC",@"TimeVC",@"PopVC",@"DownVC",@"MenusSelectVC",@"AdvertisementVC",@"LocationVC",@"DateTimeVC",@"TabbarMenuVC",@"NaviMenuVC",@"LoadingVC",@"PresentVC",@"CalanderVC",@"CustomVC"];

    self.tableView =  [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    if (@available(iOS 11.0, *)) {
        self.tableView.estimatedRowHeight = 50;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.tableView.rowHeight = 50;
    [self.view addSubview:self.tableView];
    self.view.backgroundColor = [UIColor whiteColor];
}

//展示所有属性
- (void)showAllProperties{
    Dialog()
    //自定义cell内容
    .wMyCellSet(^UITableViewCell *(NSIndexPath *indexPath, UITableView *tableView, id model) {
        return [UITableViewCell new];
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
    .wWidthSet(Dialog_GetWNum(500))
    //高度
    .wHeightSet(Dialog_GetHNum(300))
    //自动消失时间
    .wDisappelSecondSet(1.5f)
    //按钮的高度
    .wMainBtnHeightSet(Dialog_GetHNum(60))
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
    .wImageSizeSet(CGSizeMake(Dialog_GetWNum(500), Dialog_GetWNum(500)))
    //图片地址
    .wImageNameSet(@"advise")
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
    //开始
    .wStart();
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  1;}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.arr.count;}
- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return self.arr[section];}
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
    BaseVC *VC = [NSClassFromString(self.vcArr[indexPath.section]) new];
    VC.name = self.arr[indexPath.section];
    [self.navigationController pushViewController:VC animated:YES];
}
@end

