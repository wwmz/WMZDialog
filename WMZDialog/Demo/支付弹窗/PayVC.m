//
//  PayVC.m
//  WMZDialog
//
//  Created by wmz on 2020/4/10.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "PayVC.h"

@interface PayVC ()

@end

@implementation PayVC

- (void)viewDidLoad {
    [super viewDidLoad];
     self.dataArr = @[@"4位密码",@"6位密码",@"支付方式不可点击"];
}

-(void)action:(UIButton*)sender{
    switch (sender.tag) {
        case 0:{
            Dialog()
            .wEventFinishSet(^(id anyID,NSIndexPath *path, DialogType type) {
                NSLog(@"%@",anyID);
            })
            .wTypeSet(DialogTypePay)
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
        }
            break;
        case 1:{
            Dialog()
            .wTypeSet(DialogTypePay)
            //密码数量
            .wPayNumSet(6)
            //支付方式默认
            .wDefaultSelectPayStrSet(@"招商银行")
            //支付方式弹窗选择数据
            .wSonDataSet(@[@"农业银行",@"招商银行",@"建设银行",@"工商银行",@"中国银行",@"交通银行"])
            .wMessageSet(@"￥12000.00")
            .wStart();
        }
            break;
        case 2:{
            Dialog()
            .wTypeSet(DialogTypePay)
            //密码数量
            .wPayNumSet(6)
            //关闭支付方式选择
            .wCanSelectPaySet(NO)
            //支付方式默认
            .wDefaultSelectPayStrSet(@"招商银行")
            //支付方式弹窗选择数据
            .wMessageSet(@"￥12000.00")
            .wStart();
        }
            break;
            
        default:
            break;
    }
}

@end
