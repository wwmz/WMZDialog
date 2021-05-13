


//
//  WriteVC.m
//  WMZDialog
//
//  Created by wmz on 2020/4/10.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "WriteVC.h"

@interface WriteVC ()

@end

@implementation WriteVC

- (void)viewDidLoad {
    [super viewDidLoad];
     self.dataArr = @[@"单行输入",@"多行输入",@"输入规则",@"手动校验关闭"];
}

-(void)action:(UIButton*)sender{
    switch (sender.tag) {
        case 0:{
            Dialog().wTypeSet(DialogTypeWrite)
            .wEventOKFinishSet(^(id anyID, id otherData) {
                NSLog(@"%@",anyID);
            })
            //默认内容
            .wWriteDefaultTextSet(@"默认内容")
            //提示文本
            .wPlaceholderSet(@"请输入内容")
            //编辑框最大行数 大于行数则滚动
            .wWirteTextMaxLineSet(1)
            //键盘类型
            .wWirteKeyBoardTypeSet(UIKeyboardTypeDefault)
            .wStart();
        }
            break;
        case 1:{
            Dialog()
            .wTypeSet(DialogTypeWrite)
            //增加取消按钮
            .wEventCancelFinishSet(^(id anyID, id otherData) {
                
            })
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
        case 2:{
            Dialog()
            .wTypeSet(DialogTypeWrite)
            //输入规则
            .wRegularSet(@{@"reguler":@"^1+[3578]+\\d{9}",@"regulerTip":@"手机号格式错误"})
            .wWirteKeyBoardTypeSet(UIKeyboardTypePhonePad)
            .wStart();
            break;
        }
        case 3:{
            Dialog()
            .wTypeSet(DialogTypeWrite)
            //关闭库内的自动关闭
            .wAutoCloseSet(NO)
            .wEventOKFinishSet(^(id anyID, id otherData) {
                //模拟
                if (anyID &&
                    [anyID isKindOfClass:NSString.class]) {
                    if ([(NSString*)anyID length]) {
                        //手动调用类方法关闭
                        [WMZDialog closeWithshowView:nil block:nil];
                    }else{
                        AlertAuto(@"输入不能为空")
                    }
                }
            })
            .wStart();
            break;
        }
        default:
            break;
    }
}


@end
