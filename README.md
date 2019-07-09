功能样式最多的最齐全的的弹窗控件 
控件全部采用链式编程，所有属性均可定制。
* * *
看下效果图
![dialog.gif](https://upload-images.jianshu.io/upload_images/9163368-94bf77325d6d6fdd.gif?imageMogr2/auto-orient/strip)

调用枚举说明
```
typedef enum : NSUInteger{
    默认弹窗
    DialogTypeNornal,    
    底部弹窗               
    DialogTypeSheet,                  
    默认弹窗自动消失
    DialogTypeAuto,             
    系统弹窗          
    DialogTypeSystemPush,         
    系统底部弹窗
    DialogTypeSystemSheet,    
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

使用说明
```
#import "WMZDialog.h"

//最简单调用,只带确定的普通弹窗
Dialog().wTypeSet(DialogTypeNornal).wStart();
```

参数说明(详情使用看demo)

![82F3FF48-BB91-4D14-8AF4-4C9263CB63B4.png](https://upload-images.jianshu.io/upload_images/9163368-06c6a744aa470486.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![EC118098-3AD1-49ED-9602-FC273590ECB0.png](https://upload-images.jianshu.io/upload_images/9163368-491a16d720c90cfb.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

说明一下其中的几个type的思路
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
