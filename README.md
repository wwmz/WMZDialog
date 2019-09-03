功能样式最多的最齐全的的弹窗控件 
控件全部采用链式编程，所有属性均可定制。(新增的日期和地区弹窗说明在后面)

* * *
## 看下效果图
![dialog.gif](https://upload-images.jianshu.io/upload_images/9163368-94bf77325d6d6fdd.gif?imageMogr2/auto-orient/strip)

## 引入
pod 'WMZDialog','~>1.0.0'       或者直接拉WMZDialog文件夹进入项目
## 在使用cocoapods安装时，请先执行 pod search WMZDialog，如果搜索不到，请执行pod setup命令。
## 注:要消除链式编程的警告 
要在Buildding Settings 把CLANG_WARN_OBJC_IMPLICIT_RETAIN_SELF 设为NO

## 调用枚举说明
```
typedef enum : NSUInteger{
    默认弹窗
    DialogTypeNornal,    
    底部弹窗               
    DialogTypeSheet,                  
    默认弹窗自动消失
    DialogTypeAuto,              
    支付密码框    
    DialogTypePay,               
    带分享的弹窗       
    DialogTypeShare,        
    带编辑框的弹窗             
    DialogTypeWrite,                      
    带选择的弹窗
    DialogTypeSelect,                    
    拾取器弹窗无嵌套
    DialogTypePickSelect,        
    带倒计时的弹窗   
    DialogTypeTime,                    
    下拉列表选择弹窗 
    DialogTypePop,                   
    带下载的弹窗     
    DialogTypeDown,                       
    下拉无限级菜单弹窗
    DialogTypeMenusSelect,        
    广告弹窗
    DialogTypeAdvertisement,      
    购物车弹窗
    DialogTypeBuyCar,                  
    自定义弹窗
    DialogTypeMyView,                 
}DialogType;
```

## 使用说明
```
#import "WMZDialog.h"

//最简单调用,只带确定的普通弹窗
Dialog().wTypeSet(DialogTypeNornal).wStart();
```

## 最全属性
```
    Dialog()
    //自定义cell内容
    .wMyCellSet(^UITableViewCell *(NSIndexPath *indexPath, UITableView *tableView, id model) {
    })
     //下拉无限级菜单选中事件
    .wEventMenuClickSet( ^(id anyID, NSInteger section, NSInteger row) {
        NSLog(@"菜单点击方法 当前选中值:%@ 当前选中列:%ld 当前选中行:%ld",anyID,section,row);
    })
    //关闭事件
    .wEventCloseSet(^(id anyID, DialogType type) {
        NSLog(@"关闭");
    })
    //点击确定事件
    .wEventOKFinishSet(^(id anyID, DialogType type) {
        NSLog(@"确定");
    })
    //点击取消事件
    .wEventCancelFinishSet(^(id anyID, DialogType type) {
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
    //开始
    .wStart();
```

##参数说明(详情使用看demo)

![82F3FF48-BB91-4D14-8AF4-4C9263CB63B4.png](https://upload-images.jianshu.io/upload_images/9163368-06c6a744aa470486.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![EC118098-3AD1-49ED-9602-FC273590ECB0.png](https://upload-images.jianshu.io/upload_images/9163368-491a16d720c90cfb.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

##说明一下其中的几个type的思路
（1）DialogTypeMenusSelect（无限级列表）
```
传入的数据格式
       @[
             @{
                 @"name":@"数据1",
                 @"id":@"1",
                 @"children":@[]
                 },
             @{
                 @"name":@"数据2",
                 @"id":@"2",
                 @"children":@[]
                 },
             @{
                 @"name":@"数据3",
                 @"id":@"3",
                 @"children":@[]
                 },
             ]
```

内部处理,转化为model（WMZTree）该思路可用于任何无限级控件
```
  //递归计算深度
    self.depth = 0;
    if ([self.wData isKindOfClass:[NSArray class]]||[self.wData isKindOfClass:[NSMutableArray class]]){
        if ([self.wData count]) {
            self.depth = 1;
            self.tree = [WMZTree new];
            self.tree.depth = 0;
            for (NSDictionary *dic in self.wData) {
                WMZTree *tree = [[WMZTree alloc]initWithDetpth:1 withName:dic[@"name"]?:@"" withID:dic[@"id"]?:@""];
                [self.tree.children addObject:tree];
                if (dic[@"children"]) {
                    [self getDepth:dic[@"children"] withTree:tree withDepth:1];
                }
            }
            
        }
    }

//递归方法
- (void)getDepth:(NSArray*)arr withTree:(WMZTree*)treePoint withDepth:(NSInteger)depth{
    if (arr&&([arr isKindOfClass:[NSArray class]]||[arr isKindOfClass:[NSMutableArray class]])&&[arr count]){
        self.depth = depth+1;
        for (NSDictionary *dic in arr) {
            WMZTree *tree = [[WMZTree alloc]initWithDetpth:depth+1 withName:dic[@"name"]?:@"" withID:dic[@"id"]?:@""];
            [treePoint.children addObject:tree];
            if (dic[@"children"]&&([dic[@"children"] isKindOfClass:[NSArray class]]||[dic[@"children"] isKindOfClass:[NSMutableArray class]])&&[dic[@"children"] count]) {
                [self getDepth:dic[@"children"] withTree:tree withDepth:depth+1];
            }
        }
    }
}
```

获取每一层的数据
```
//数据处理  type 1返回tree对象
- (id)getMyDataArr:(NSInteger )tableViewTag withType:(NSInteger)type{
    if (tableViewTag==100) {
        return type?self.tree:self.tree.children;
    }else{
        NSInteger taNum = 100;
        WMZTree *resultDic = nil;
        while (taNum < tableViewTag) {
            NSMutableArray *arr = (taNum == 100?self.tree.children:resultDic.children);
            int selectLastIndex = 0;
            for (int i = 0; i<arr.count; i++) {
                WMZTree *tree = arr[i];
                if (tree.isSelected) {
                    selectLastIndex = i;
                    break;
                }
            }
            resultDic = arr[selectLastIndex];
            taNum++;
        }
        return  type?resultDic:resultDic.children;
    }
}
```

（2）DialogTypeBuyCar（仿拼多多购物车）
用此type需要导入WMZTags控件，简书说明链接（[WMZTags(仿前端element-UI的功能最齐全的标签)](https://www.jianshu.com/p/1b70159cdbd7)  ）
传入参数
```
 //数据可自己配置 动态配置
    NSArray *myData = @[
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
                        ];

```

（3）DialogTypeMyView（自定义弹窗）该功能不支持自定义view中的点击事件 

```
   Dialog()
   .wTypeSet(temp.tag)
   .wAddBottomViewSet(YES)
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
         //需要返回最底部的view
         return te;
     }) .wStart();
```

* * *
## 20190815 
## 新增选择地区弹窗和日期选择弹窗

(1)地区弹窗效果图

![location1.gif](https://upload-images.jianshu.io/upload_images/9163368-5bf11bc9a6fd0d5c.gif?imageMogr2/auto-orient/strip)

使用参数说明：
wLocationType   地区关联层级 （1/2/3）默认3
wChainType       关联层级的样式（tableview/pickView）默认 ChainPickView
使用
```
Dialog()
.wEventOKFinishSet(^(id anyID, DialogType type) {
     NSLog(@"选中 %@",anyID);
})
.wChainTypeSet(ChainPickView)
.wLocationTypeSet(3)
.wTypeSet(DialogTypeLocation)
.wStart();
```
(2)日期选择效果图

![time.gif](https://upload-images.jianshu.io/upload_images/9163368-18739f862894fb35.gif?imageMogr2/auto-orient/strip)


使用参数说明：
wDateTimeType  时间选择器样式   yyyy:MM:dd HH:mm:ss   (可带后缀例如yyyy年也可以自由拼例如yyyy:MM)
wPickRepeat   无限循环  (默认YES)

使用
```
Dialog()
.wEventOKFinishSet(^(id anyID, DialogType type) {
       NSLog(@"选中 %@",anyID);
})
.wDateTimeTypeSet(@"yyyy年MM月dd日 HH时mm分ss秒")
.wPickRepeatSet(YES)
.wTypeSet(DialogTypeDatePicker)
.wMessageColorSet([UIColor redColor])
.wMessageFontSet(18)
.wStart();
```
