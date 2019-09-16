# WMZDailog - 功能样式最多的最齐全的的弹窗控件 控件全部采用链式编程，所有属性均可定制

演示
==============
![dialog.gif](https://upload-images.jianshu.io/upload_images/9163368-726a77c2ce22aa32.gif?imageMogr2/auto-orient/strip)


特性
==============
- 链式语法 结构优雅
- 支持单选/多选
- 支持地区1/2/3级联动
- 支持无限级联动
- 支持时间选择
- 支持支持多种动画
- 支持所有字体颜色/字体大小的设置
- 支持支付视图
- 支持自定义弹窗

## 调用枚举说明
```
typedef enum : NSUInteger{
    DialogTypeNornal = 1,           //默认弹窗
    DialogTypeSheet,                //底部弹窗
    DialogTypeAuto,                 //默认弹窗自动消失
    DialogTypePay,                  //支付密码框
    DialogTypeShare,                //带分享的弹窗
    DialogTypeWrite,                //带编辑框的弹窗
    DialogTypeSelect,               //带选择的弹窗
    DialogTypePickSelect,           //拾取器弹窗无嵌套
    DialogTypeTime,                 //带倒计时的弹窗
    DialogTypePop,                  //下拉列表选择弹窗
    DialogTypeDown,                 //带下载的弹窗
    DialogTypeMenusSelect,          //下拉无限级菜单弹窗
    DialogTypeAdvertisement,        //广告弹窗
    DialogTypeLocation,             //地区选择
    DialogTypeDatePicker,           //日期选择
    DialogTypeTabbarMenu,           //闲鱼 微博+号底部弹窗
    DialogTypeNaviMenu,             //QQ顶部弹窗
    DialogTypeLoading,              //加载框
    DialogTypeBuyCar ,              //购物车弹窗  可自行导入WMZTags
    DialogTypeMyView,               //自定义弹窗
}DialogType;
```

## 参数说明(详情使用看demo)
```
 /*=========================================Attributes================================================================*/

/*=========================================参数说明=====================================================================

 =========================================通用=========================================================================
参数                    说明                         类型                   可选值               默认值                    是否必传
wStart                 开始                           -                      -                   -                      是
wData                 数据源                          id                     -                   -                       -
wShowAnimation       出现的动画                 DialogShowAnination         参考枚举           AninatonZoomIn              -
wHideAnimation       消失的动画                 DialogHideAnination         参考枚举              none                     -
wAnimationDurtion     动画时间                    NSTimeInterval             -                  0.8                      -
wParentVC             父控制器                  UIViewController             -                当前VC                      -
wType                弹窗是类型                    DialogType              参考枚举          DialogTypeNornal              -
wWidth              弹窗视图的宽度                   CGFloat                  -            Dialog_GetWNum(500)            -
wHeight             弹窗视图的宽度                   CGFloat                  -     默认自适应高度(Dialog_GetHNum(300))      -
wMainOffsetY           Y间距                       CGFloat                  -             Dialog_GetHNum(20)            -
wMainOffsetX           X间距                       CGFloat                  -             Dialog_GetHNum(15)            -
wMainBtnHeight        按钮高度                      CGFloat                  -             Dialog_GetHNum(60)            -
wMyCell              自定义cell                 UITableViewCell              -                   -                       -
wMainToBottom       视图在最底部                       BOOL                   -                  NO                       -
wLineColor           线条的颜色                     UIColor                   -            DialogColor(0x333333)          -
wLineAlpha          线条的透明度                     CGFLoat                  -                 0.5f                      -
wTitle                标题文本                      NSString                 -                  提示                      -
wMessage              内容文本                      NSString                 -                  内容                      -
wOKTitle            确定按钮的文本                   NSString                 -                  确定                      -
wCancelTitle        取消按钮的文本                   NSString                 -                  取消                      -
wOKColor            确定按钮的颜色                    UIColor                 -            DialogColor(0xFF9900)          -
wCancelColor        取消按钮的颜色                    UIColor                 -            DialogColor(0x666666)          -
wMainBackColor     弹出视图的背景颜色                  UIColor                 -            DialogColor(0xffffff)          -
wTitleColor         标题文本的颜色                    UIColor                 -            DialogColor(0x333333)          -
wMessageColor       内容文本的颜色                    UIColor                 -            DialogColor(0x333333)          -
wOKFont            确定按钮的字体大小                  CGFLoat                 -                  16.0f                    -
wCancelFont        取消按钮的字体大小                  CGFLoat                 -                  16.0f                    -
wTitleFont         标题文本的字体大小                  CGFLoat                 -                  14.0f                    -
wMessageFont       内容文本的字体大小                  CGFLoat                 -                  16.0f                    -
wMainRadius         弹出视图的圆角                    CGFLoat                 -                  15.0f                    -
wShadowColor        遮罩层的颜色                      UIColor                 -            DialogColor(0x333333)          -
wShadowAlpha       遮罩层的透明度                     CGFLoat                 -                  16.0f                    -
wShadowCanTap     遮罩层能否点击关闭                    BOOL                   -                   YES                     -
wShadowShow         遮罩层是否显示                     BOOL                   -                   YES                     -
wEffectShow         毛玻璃是否显示                     BOOL                   -                    NO                     -
wMultipleSelection      多选                         BOOL                   -                    NO                     -
wSelectShowChecked    选中是否打钩                     BOOL                   -                    NO                     -
wTextAlignment        文本对齐方式                NSTextAlignment             _                   center                  _
wEventOKFinish        确定点击事件                DialogClickBlock            -                    -                      -
wEventCancelFinish 取消点击事件(不传默认没有取消按钮) DialogClickBlock            -                    -                      -
wEventFinish         所有的操作事件                DialogClickBlock            -                   -                       -
 
 
=========================================disappear=======================================================================
 
wDisappelSecond     自动消失的时间                    CGFLoat                  -                   1.5f                     -
 
=========================================pay=============================================================================
 
wSonData            支付方式选择数据源                 id                     -                    -                        -
wKeyBoardMarginY    弹窗与键盘的距离                 CGFLoat                   -                Dialog_GetHNum(70)          -
wPayNum               支付密码位数                  NSInteger                 -            6(若要设置位数比6大的则要保证宽度足够) -
wDefaultSelectPayStr 支付方式默认文本                NSString                  -                   农业银行                   -
 
=========================================write=============================================================================
 
wPlaceholder             提示语                     NSString                 -                    请输入                    -
wWirteTextMaxLine   编辑框可换行的最大行数            NSInteger                 -                     7                      -
wWirteTextMaxNum    编辑框可输入的最大数字            NSInteger                 -                  -1(-1为不限制)              -
wWirteKeyBoardType   编辑框的键盘type              UIKeyBoardType             -               UIKeyboardTypeDefault        -
 
=========================================pop=============================================================================
 
wPercentAngle       弹出的气泡位置                 CGFLoat                (0-1)不包含0和1          0.5f                      -
wPercentOrginX      弹出视图的中心X轴偏移           CGFLoat                  -                    1.0f(默认中间)              -
wDirection          弹出式图的方向                DiaDirection          left/right/top/bottom   directionDowm               -
wNavigationItem     导航栏位置                       BOOL                   NO                      _                      _
wTapView            触发点的视图                   UIView                   -                        -                      -（pop的时候必传）
 
=========================================down=============================================================================
wImageSize            图片的大小                     CGSize                   -     Dialog_GetWNum(110),Dialog_GetWNum(110) -
wImageName            图片路径名字                   NSString                 -                  down_tyx                    -
wProgressTintColor   进度条闲置时候的颜色              UIColor                  -                DialogColor(0xFF9900)        -
wTrackTintColor      进度条动作时候的颜色              UIColor                  -                DialogColor(0xF3F4F6)        -

=========================================menu=============================================================================
 
wTableViewColor      tableview的背景颜色              NSArray                  -             FFFFFF/F6F7FA/EBECF0/666666     -
 
=========================================location============================================================================
 
wLocationType        地区关联层级                     NSInteger              1/2/3                   3                      -
wChainType           关联层级的样式                   ChainType        tableview/pickView      ChainPickView                 -
wSeparator           选中数据的分隔符                  NSString                -                      ，                     -
 
=========================================datePicker==========================================================================
 
wDateTimeType        时间选择器样式                   NSString  yyyy年MM月dd日HH时mm分ss秒(自由组合) yyyy:MM:dd HH:mm:ss       -
wPickRepeat         pickView无限循环                  BOOL                   -                     yes                    -
 
=============================Share/tabbarMenu/NaviMENU========================================================================
 
注意如果设置了行和列 要如期显示 要设置好wHeight
wColumnCount           列                            NSInteger              -                     -                       -
wRowCount              行                            NSInteger              -                     -                       -

=========================================loading===============================================================================
wLoadingType          加载框样式                     LoadingStyle             -                LoadingStyleWait            -
wLoadingSize          加载框size                     CGSize                  -              Dialog_GetHNum(90,90)         -
wLoadingColor         加载框线条颜色                  UIColor                  -                  确定按钮的文本颜色           -
 
=========================================custom===============================================================================
 
wAddBottomView       是否添加底部按钮                   BOOL                   -                     NO                     -
wMyDiaLogView        自定义弹窗View(返回最底部的view)     -                     -                     -                      -
 
=========================================参数说明==========================================================================*/
```

用法
==============

### 默认模式

      Dialog().wTypeSet(DialogTypeNornal).wStart();
    
### 多选模式

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

### 自定义弹窗(优酷) 更多自定义弹窗看demo
	
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

### 其他模式看demo

### 依赖
无任何依赖 
如果需要用到购物车弹窗 可自行导入WMZTags

安装
==============

### CocoaPods
1. 将 cocoapods 更新至最新版本.
2. 在 Podfile 中添加 `pod 'WMZDialog'`。
3. 执行 `pod install` 或 `pod update`。
4. 导入 #import "WMZDialog.h"。

### 注:要消除链式编程的警告 
要在Buildding Settings 把CLANG_WARN_OBJC_IMPLICIT_RETAIN_SELF 设为NO

### 手动安装

1. 下载 WMZDialog 文件夹内的所有内容。
2. 将 WMZDialog 内的源文件添加(拖放)到你的工程。
3. 导入 #import "WMZDialog.h"

系统要求
==============
该库最低支持 `iOS 9.0` 和 `Xcode 9.0`。



许可证
==============
LEETheme 使用 MIT 许可证，详情见 [LICENSE](LICENSE) 文件。


个人主页
==============
使用过程中如果有什么bug欢迎给我提issue 我看到就会解决
[我的简书](https://www.jianshu.com/p/601ad3960353)
