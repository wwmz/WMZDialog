//
//  ViewController.m
//  WMZDialog
//
//  Created by wmz on 2019/6/5.
//  Copyright © 2019年 wmz. All rights reserved.
//

#import "ViewController.h"
#import "WMZDialog.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    WMZDialog *myAlert;
}
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *arr;
@property(nonatomic,strong)NSArray *dataArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.arr =@[@"普通弹窗",@"底部弹窗",@"自动消失弹窗",@"支付弹窗",@"分享弹窗",@"自适应编辑弹窗",@"选择弹窗",@"拾取器弹窗",@"倒计时弹窗",@"上下左右弹出列表",@"下载弹窗",@"下拉无限级菜单弹窗",@"广告弹窗",@"地区弹窗",@"日期时间弹窗",@"底部菜单弹窗",@"顶部菜单弹窗",@"加载框",@"购物车弹窗",@"自定义弹窗"];
    
    self.dataArr =@[@[@"普通弹窗",@"普通弹窗(+取消按钮+改变字体颜色)"],@[@"底部单选弹窗",@"底部多选弹窗"],@[@"自动消失弹窗"],@[@"支付弹窗(密码4位)",@"支付弹窗(密码6位)"],@[@"分享弹窗(2行4列)",@"分享弹窗(3行2列,翻页,毛玻璃)"],@[@"自适应编辑弹窗"],@[@"选择弹窗",@"选择弹窗(多选)"],@[@"拾取器弹窗"],@[@"倒计时弹窗"],@[@"上下左右弹出列表"],@[@"下载弹窗"],@[@"下拉无限级菜单弹窗"],@[@"广告弹窗"],@[@"地区弹窗"],@[@"日期时间弹窗"],@[@"底部菜单弹窗"],@[@"顶部菜单弹窗"],@[@"加载框(等待)",@"加载框(正确)",@"加载框(错误)"],@[@"购物车弹窗"],@[@"自定义弹窗(优酷)",@"自定义弹窗(哔哩哔哩)",@"自定义弹窗(饿了么升级)"]];
    
    
    self.tableView =  [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedSectionFooterHeight = 0.01;
    self.tableView.estimatedSectionHeaderHeight = 0.01;
    self.tableView.estimatedRowHeight = 50;
    self.tableView.rowHeight = 50;
    [self.view addSubview:self.tableView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.tag = 111;
    [btn setTitleColor:DialogColor(0xF4606C) forState:UIControlStateNormal];
    [btn setTitle:@"导航弹窗" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = barItem;
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setTitleColor:DialogColor(0xF4606C) forState:UIControlStateNormal];
    [btn1 setTitle:@"导航弹窗" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(onBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barItem1 = [[UIBarButtonItem alloc] initWithCustomView:btn1];
    self.navigationItem.rightBarButtonItem = barItem1;
    
    
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
    return nil;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return   [self.dataArr[section] count];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return self.arr[section];
}

# pragma  mark tableView 代理
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *data = self.dataArr[indexPath.section][indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myCell"];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = data;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger type = indexPath.section + 1;
    UITableViewCell *cell = (UITableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    switch (indexPath.section+1) {
        case DialogTypeNornal:
        {
            if (indexPath.row == 0) {
                 Dialog().wTypeSet(type).wStart();
            }else{
                 Dialog()
                //出现动画
                .wShowAnimationSet(AninatonZoomIn)
                //消失动画
                .wHideAnimationSet(AninatonZoomOut)
                .wEventCancelFinishSet(^(id anyID, id otherData) {})
                .wMessageSet(@"这是一条内容\n这是一条内容")
                .wTitleSet(@"这是一条标题\n这是一条标题")
                .wOKTitleSet(@"好的")
                .wCancelTitleSet(@"我知道了")
                .wMessageColorSet(DialogColor(0x333333))
                .wTitleColorSet(DialogColor(0x666666))
                .wOKColorSet([UIColor orangeColor])
                .wCancelColorSet([UIColor redColor])
                .wTitleFontSet(15)
                .wTypeSet(type).wStart();
            }
        }
            break;
        case DialogTypeSheet:
        {
            if (indexPath.row == 0) {
                 Dialog().wTypeSet(type).wDataSet(@[@"男",@"女",@"保密"]).wTitleSet(@"性别选择")
                //完成操作事件
                .wEventFinishSet(^(id anyID,NSIndexPath *path, DialogType type) {
                    NSLog(@"%@",anyID);
                })
                .wStart();
            }else{
                 Dialog().wTypeSet(type)
                //点击确定事件
                .wEventOKFinishSet(^(id anyID, id otherData) {
                    NSLog(@"确定 %@",anyID);
                })
                .wDataSet(@[@"男",@"女",@"保密"])
                .wMultipleSelectionSet(YES)
                .wSelectShowCheckedSet(YES).wStart();
            }
        }
            break;
        case DialogTypeAuto:
        {
             Dialog().wTypeSet(type)
            .wMessageSet(@"自动消失")
            //自动消失时间 默认1.5
            .wDisappelSecondSet(1)
            .wStart();
        }
            break;
        case DialogTypePay:
        {
            if (indexPath.row == 0) {
                Dialog()
                .wEventFinishSet(^(id anyID,NSIndexPath *path, DialogType type) {
                    NSLog(@"%@",anyID);
                })
                .wTypeSet(type)
                //出现动画
                .wShowAnimationSet(AninationCombineOne)
                //消失动画
                .wHideAnimationSet(AninationHideCombineOne)
                //密码数量
                .wPayNumSet(4)
                //支付方式默认
                .wDefaultSelectPayStrSet(@"农业银行")
                //支付方式弹窗选择数据
                .wSonDataSet(@[@"农业银行",@"招商银行",@"建设银行",@"工商银行",@"中国银行",@"交通银行"])
                .wMessageSet(@"￥2000.00")
                .wStart();
            }else{
                Dialog()
                .wTypeSet(type)
                //出现动画
                .wShowAnimationSet(AninatonZoomIn)
                //密码数量
                .wPayNumSet(6)
                //支付方式默认
                .wDefaultSelectPayStrSet(@"招商银行")
                //支付方式弹窗选择数据
                .wSonDataSet(@[@"农业银行",@"招商银行",@"建设银行",@"工商银行",@"中国银行",@"交通银行"])
                .wMessageSet(@"￥12000.00")
                .wStart();
            }
        }
            break;
        case DialogTypeShare:
        {
            WMZDialog *alert = Dialog();
            alert.wTypeSet(type)
            .wTitleSet(@"分享")
            .wEventMenuClickSet(^(id anyID, NSInteger section, NSInteger row) {
                NSLog(@"%@ %ld %ld",anyID,section,row);
            })
            .wDataSet(@[
                        @{@"name":@"微信",@"image":@"wallet"},
                        @{@"name":@"支付宝",@"image":@"aaa"},
                        @{@"name":@"米聊",@"image":@"bbb"},
                        @{@"name":@"微信1",@"image":@"wallet"},
                        @{@"name":@"支付宝2",@"image":@"aaa"},
                        @{@"name":@"米聊2",@"image":@"bbb"},
                        @{@"name":@"微信1",@"image":@"wallet"},
                        @{@"name":@"支付宝2",@"image":@"aaa"}
                        ]);
            
            if (indexPath.row == 0) {
                 //默认2行4列 多则翻页
                alert.wRowCountSet(2).wColumnCountSet(4);
            }else{
                alert.wRowCountSet(2).wColumnCountSet(3).wEffectShowSet(YES);
            }
            
            alert.wStart();
        }
            break;
        case DialogTypeWrite:
        {
            Dialog().wTypeSet(type)
            .wEventOKFinishSet(^(id anyID, id otherData) {
                NSLog(@"%@",anyID);
            })
            //提示文本
           .wPlaceholderSet(@"请输入内容")
            //编辑框最大行数 大于行数则滚动
           .wWirteTextMaxLineSet(7)
            //编辑框可输入的文本最大文本长度
           .wWirteTextMaxNumSet(200)
            //键盘类型
           .wWirteKeyBoardTypeSet(UIKeyboardTypeDefault)
            .wStart();
        }
            break;
        case DialogTypeSelect:
        {
            if (indexPath.row == 0) {
                Dialog().wTypeSet(type)
                .wEventFinishSet(^(id anyID, NSIndexPath *path, DialogType type) {
                    NSLog(@"%@ %@",anyID,path);
                })
                .wTitleSet(@"选择爱好").wTitleColorSet([UIColor redColor]).wTitleFontSet(16.0)
                .wDataSet(@[@"游泳",@"打篮球",@"打羽毛球",@"爬山",@"踢足球",@"乒乓球"])
                .wStart();
            }else{
                Dialog().wTypeSet(type)
                .wEventOKFinishSet(^(id anyID, id otherData) {
                    NSLog(@"%@",anyID);
                })
                //出现动画
                .wShowAnimationSet(AninationCombineTwo)
                .wTitleSet(@"")
                .wMultipleSelectionSet(YES).wSelectShowCheckedSet(YES)
                .wDataSet(@[@"游泳",@"打篮球",@"打羽毛球",@"爬山",@"踢足球",@"乒乓球"])
                .wStart();
            }
        }
            break;
        case DialogTypePickSelect:
        {
            Dialog()
            .wEventOKFinishSet(^(id anyID, id otherData) {
                NSLog(@"%@",anyID);
            })
            .wTypeSet(type).wDataSet( @[@[@"数据11",@"数据12",@"数据13",@"数据14"],
                                      @[@"数据2",@"数据22",@"数据23",@"数据24"],
                                      @[@"数据31",@"数据32",@"数据33",@"数据34"],
                                      @[@"数据41",@"数据42",@"数据43",@"数据44"]]
                                            )
            .wStart();
        }
            break;
        case DialogTypeTime:
        {
            Dialog().wTypeSet(type).wDataSet(@(100)).wStart();
        }
            break;
        case DialogTypePop:
        {
            [self.navigationController pushViewController:[NSClassFromString(@"PopVC") new] animated:YES];
        }
            break;
        case DialogTypeDown:
        {
 
            WMZDialog *alert = Dialog()
            .wTypeSet(DialogTypeDown)
            .wEventFinishSet(^(id anyID, NSIndexPath *path, DialogType type) {
                NSLog(@"%@",anyID);
            })
            .wDataSet(@(0.0)).wStart();
            
            //模拟下载
            __block CGFloat seconds = 0;
            dispatch_queue_t global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, global);
            dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
            dispatch_source_set_event_handler(timer, ^{
                if (seconds>=1) {
                    dispatch_source_cancel(timer);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [alert closeView];
                    });
                }else{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if(![alert updateAlertTypeDownProgress:seconds]){
                            dispatch_source_cancel(timer);
                        }
                    });
                }
                seconds+=0.2;
            });
            dispatch_resume(timer);
        }
            break;
        case DialogTypeMenusSelect:
        {
            [self.navigationController pushViewController:[NSClassFromString(@"MenusSelectVC") new] animated:YES];
        }
            break;
        case DialogTypeAdvertisement:
        {
            Dialog().wTypeSet(type)
            .wEventFinishSet(^(id anyID, NSIndexPath *path, DialogType type) {
                NSLog(@"%@",anyID);
            })
            //出现动画
            .wShowAnimationSet(AninationCombineOne)
            //显示图片的大小
            .wImageSizeSet(CGSizeMake(Dialog_GetWNum(500), Dialog_GetWNum(500)))
            //图片地址
            .wImageNameSet(@"advise")
            .wStart();
        }
            break;
        case DialogTypeLocation:
        {
            [self.navigationController pushViewController:[NSClassFromString(@"LocationVC") new] animated:YES];
        }
            break;
        case DialogTypeDatePicker:
        {
            [self.navigationController pushViewController:[NSClassFromString(@"DateTimeVC") new] animated:YES];
        }
            break;
        case DialogTypeTabbarMenu:
        {
            //和分享弹窗拥有的属性一致
            Dialog().wTypeSet(type)
            .wDataSet(@[
                        @{@"name":@"微信",@"image":@"wallet"},
                        @{@"name":@"支付宝",@"image":@"aaa"},
                        @{@"name":@"米聊",@"image":@"bbb"},
                        @{@"name":@"微信1",@"image":@"wallet"},
                        ])
            .wStart();
        }
            break;
        case DialogTypeNaviMenu:
        {
            //和分享弹窗拥有的属性一致 
            Dialog().wTypeSet(type)
            .wDataSet(@[
                        @{@"name":@"微信",@"image":@"wallet"},
                        @{@"name":@"支付宝",@"image":@"aaa"},
                        @{@"name":@"米聊",@"image":@"bbb"},
                        @{@"name":@"微信1",@"image":@"wallet"},
                        @{@"name":@"支付宝2",@"image":@"aaa"},
                        @{@"name":@"米聊2",@"image":@"bbb"},
                        ])
            .wStart();
        }
            break;
        case DialogTypeLoading:
        {
            WMZDialog *alert = Dialog();
            if (indexPath.row == 0) {
                //加载框颜色
                alert.wLoadingColorSet(DialogColor(0xFF9900))
                //无文字
                .wTitleSet(@"")
                //毛玻璃背景
                .wEffectShowSet(YES);
            }else  if (indexPath.row == 1) {
                alert.wLoadingColorSet(DialogColor(0x108ee9))
                .wTitleSet(@"操作成功");
            }else{
                alert.wLoadingColorSet([UIColor redColor]).wTitleSet(@"操作失败");
            }
            
            alert.wTypeSet(type)
            //加载框type
            .wLoadingTypeSet(indexPath.row)
            //动画时间
            .wAnimationDurtionSet(1)
            //加载框大小
            .wLoadingSizeSet(CGSizeMake(50, 50))
            .wStart();
        }
            break;
        case DialogTypeMyView:
        {
            if (indexPath.row == 0) {
                [self youkuDialog];
            }else  if (indexPath.row == 1) {
                [self bilibiliDialog];
            }else{
                [self elementDialog];
            }
           
        }
            break;
        case DialogTypeBuyCar:
        {
             [self.navigationController pushViewController:[NSClassFromString(@"BuyCarVC") new] animated:YES];
        }
            break;
        default:
            break;
    }
}


//导航栏点击
- (void)onBtnAction:(UIButton*)temp{
    Dialog()
    .wPercentAngleSet(temp.tag==111?0.1:0.9)
    .wNavigationItemSet(YES)   //导航栏标题必须添加这一属性
    .wTypeSet(DialogTypePop).wDataSet(@[@{@"name":@"微信",@"image":@"wallet"},
                                        @{@"name":@"支付宝",@"image":@"wallet"},
                                        @{@"name":@"米聊",@"image":@"wallet"},
                                        @{@"name":@"飞信",@"image":@"wallet"},
                                        @{@"name":@"微博",@"image":@"wallet"}])
    .wTapViewSet(temp)
    .wStart();
}


//自定义优酷方法
- (void)youkuDialog{
    __weak ViewController *WEAK = self;
    myAlert = Dialog()
    .wTypeSet(DialogTypeMyView)
    //关闭事件 此时要置为不然会内存泄漏
    .wEventCloseSet(^(id anyID, id otherData) {
        myAlert = nil;
    })
    .wShowAnimationSet(AninatonZoomIn)
    .wHideAnimationSet(AninatonZoomOut)
    .wMyDiaLogViewSet(^UIView *(UIView *mainView) {
        UIImageView *image = [UIImageView new];
        image.image = [UIImage imageNamed:@"healthy"];
        image.frame = CGRectMake(0, 0, mainView.frame.size.width, 80);
        [mainView addSubview:image];
        
        UILabel *la = [UILabel new];
        la.font = [UIFont systemFontOfSize:15.0f];
        la.text = @"为呵护未成年人健康成长,优酷特别推出青少年模式,该模式下部分功能无法正常使用,请监护人主动选择，并设置监护密码";
        la.numberOfLines = 0;
        la.frame = CGRectMake(10, CGRectGetMaxY(image.frame), mainView.frame.size.width-20, 100);
        [mainView addSubview:la];
        
        UIButton *enter = [UIButton buttonWithType:UIButtonTypeCustom];
        [mainView addSubview:enter];
        enter.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        enter.frame = CGRectMake(0, CGRectGetMaxY(la.frame), mainView.frame.size.width, 44);
        [enter setTitle:@"进入青少年模式 >" forState:UIControlStateNormal];
        [enter setTitleColor:DialogColor(0x108ee9) forState:UIControlStateNormal];
        [enter addTarget:WEAK action:@selector(youkuAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *know = [UIButton buttonWithType:UIButtonTypeCustom];
        [mainView addSubview:know];
        know.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        know.frame = CGRectMake(0, CGRectGetMaxY(enter.frame), mainView.frame.size.width, 44);
        [know setTitle:@"我知道了" forState:UIControlStateNormal];
        [know setTitleColor:DialogColor(0x3333333) forState:UIControlStateNormal];
        [know addTarget:WEAK action:@selector(youkuAction:) forControlEvents:UIControlEventTouchUpInside];
        
        mainView.layer.masksToBounds = YES;
        mainView.layer.cornerRadius = 10;
        return know;
    })
    .wStart();
}

//优酷自定义方法
- (void)youkuAction:(UIButton*)sender{
    NSLog(@"优酷点击");
    //关闭
    [myAlert closeView];
}

//哔哩哔哩
- (void)bilibiliDialog{
    myAlert = Dialog()
    .wTypeSet(DialogTypeMyView)
    //关闭事件 此时要置为不然会内存泄漏
    .wEventCloseSet(^(id anyID, id otherData) {
        myAlert = nil;
    })
    .wShowAnimationSet(AninatonCounterclockwise)
    .wHideAnimationSet(AninatonClockwise)
    .wWidthSet(Device_Dialog_Width*0.85)
    .wMyDiaLogViewSet(^UIView *(UIView *mainView) {

        UILabel *la = [UILabel new];
        la.font = [UIFont systemFontOfSize:17.0f];
        la.textAlignment = NSTextAlignmentCenter;
        la.text = @"协议条款更新提示";
        la.numberOfLines = 0;
        la.frame = CGRectMake(0, 15, mainView.frame.size.width, 35);
        [mainView addSubview:la];
        
        UITextView *textView = [UITextView new];
        textView.editable = NO;
        textView.frame = CGRectMake(0, CGRectGetMaxY(la.frame)+15, mainView.frame.size.width, 100);
        textView.textColor = DialogColor(0x666666);
        textView.font = [UIFont systemFontOfSize:16.0];
        textView.text = @"  本协议是用户（下称“用户”或“您”）与哔哩哔哩之间的协议，哔哩哔哩将按照本协议约定之内容为您提供服务。“哔哩哔哩”是指哔哩哔哩和/或其相关服务可能存在的运营关联单位。若您不同意本协议中所述任何条款或其后对协议条款的修改，请您不要使用哔哩哔哩提供的相关服务。您的使用行为将视作对本协议全部条款的完全接受。请您仔细阅读本协议的全部条款与条件，尤其是协议中黑色加粗的条款。\n  如您为未成年人的，请在法定监护人的陪同下阅读和判断是否同意本协议，特别注意未成年人条款。未成年人行使和履行本协议项下的权利和义务视为已获得监护人的认可";
        [mainView addSubview:textView];
        
        UILabel *text = [UILabel new];
        text.font = [UIFont systemFontOfSize:15.0f];
        text.textAlignment = NSTextAlignmentCenter;
        text.textColor = DialogColor(0x999999);
        NSString *str = @"您可通过阅读完整版《哔哩哔哩弹幕网用户使用协议》了解详尽的条款内容";
        NSMutableAttributedString *mStr = [[NSMutableAttributedString alloc] initWithString:str];
        [mStr addAttribute:NSForegroundColorAttributeName value:DialogColor(0x5297E1) range:[str rangeOfString:@"《哔哩哔哩弹幕网用户使用协议》"]];
        text.attributedText = mStr;
        text.numberOfLines = 2;
        text.frame = CGRectMake(0, CGRectGetMaxY(textView.frame)+10, mainView.frame.size.width, 60);
        [mainView addSubview:text];
        
        mainView.layer.masksToBounds = YES;
        mainView.layer.cornerRadius = 10;
        return text;
    })
    //添加底部
    .wAddBottomViewSet(YES)
    .wEventCancelFinishSet(^(id anyID, id otherData) {})
    .wOKTitleSet(@"同意")
    .wCancelTitleSet(@"不同意")
    .wOKColorSet(DialogColor(0xff709a))
    .wCancelColorSet(DialogColor(0x666666))
    .wStart();
}


//饿了么
- (void)elementDialog{
    __weak ViewController *WEAK = self;
    myAlert = Dialog()
    .wTypeSet(DialogTypeMyView)
    //关闭事件 此时要置为不然会内存泄漏
    .wEventCloseSet(^(id anyID, id otherData) {
        myAlert = nil;
    })
    .wWidthSet(Device_Dialog_Width*0.8)
    .wShowAnimationSet(AninatonZoomIn)
    .wHideAnimationSet(AninatonZoomOut)
    .wMyDiaLogViewSet(^UIView *(UIView *mainView) {
        UIImageView *image = [UIImageView new];
        image.image = [UIImage imageNamed:@"down_tyx"];
        image.frame = CGRectMake((mainView.frame.size.width-70)/2, 15, 70, 70);
        [mainView addSubview:image];
        
        UILabel *la = [UILabel new];
        la.font = [UIFont systemFontOfSize:17.0f];
        la.text = @"新版本抢先体验";
        la.textAlignment = NSTextAlignmentCenter;
        la.frame = CGRectMake(20, CGRectGetMaxY(image.frame)+15, mainView.frame.size.width-40, 40);
        [mainView addSubview:la];
        
        UILabel *text = [UILabel new];
        text.numberOfLines = 0;
        text.textColor = DialogColor(0x333333);
        text.font = [UIFont systemFontOfSize:15.0f];
        text.text = @"1.首页改版升级,找到心仪的频道更健康。(逐步开放中)\n2.订单页视觉升级,新增附近常卖模块。(大量开放中)";
        text.textAlignment = NSTextAlignmentCenter;
        text.frame = CGRectMake(20, CGRectGetMaxY(la.frame)+15, mainView.frame.size.width-40, 100);
        [mainView addSubview:text];
        
        UIButton *know = [UIButton buttonWithType:UIButtonTypeCustom];
        [mainView addSubview:know];
        know.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        know.frame = CGRectMake(20, CGRectGetMaxY(text.frame)+15, mainView.frame.size.width-40, 44);
        [know setTitle:@"参加内侧" forState:UIControlStateNormal];
        know.backgroundColor = DialogColor(0x108ee9);
        [know addTarget:WEAK action:@selector(elementAction:) forControlEvents:UIControlEventTouchUpInside];
        
        mainView.layer.masksToBounds = YES;
        mainView.layer.cornerRadius = 10;
        return know;
    })
    .wStart();
}

- (void)elementAction:(UIButton*)sender{
    NSLog(@"饿了么点击");
     [myAlert closeView];
}
@end
