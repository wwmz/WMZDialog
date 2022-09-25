


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
            .wDisappelSecondSet(2)
            .wEventOKFinishSet(^(id anyID, id otherData) {
                NSLog(@"%@",anyID);
            })
            .wMessageSet(@"最多输入10个字符")
            ///输入框文字颜色
            .wInputTextColorSet(UIColor.redColor)
            .wTitleSet(@"请输入文本")
            //默认内容
            .wWriteDefaultTextSet(@"默认内容")
            //提示文本
            .wPlaceholderSet(@"请输入内容")
            ///超出字符提示 不传则不提示
            .wRegularSet(@{DialogRegularMaxTip:@"已超出字数最大限制"})
            //编辑框最大行数 1
            .wWirteTextMaxLineSet(1)
            //编辑框可输入的文本最大文本长度 defualt -1 不限制
            .wWirteTextMaxNumSet(10)
            .wStart();
        }
            break;
        case 1:{
            Dialog()
            .wMessageSet(@"请输入文本")
            .wTypeSet(DialogTypeWrite)
            //增加取消按钮
            .wEventCancelFinishSet(^(id anyID, id otherData) {
                
            })
            .wEventOKFinishSet(^(id anyID, id otherData) {
                NSLog(@"%@",anyID);
            })
            /// borderColor
            .wBottomLineColorSet(DialogDarkColor(DialogColor(0xeeeeee), DialogColor(0x373637)))
            /// 背景颜色
            .wInputBackGroundColorSet(DialogDarkColor(DialogColor(0xeeeeee), DialogColor(0x373637)))
            ///最小高度
            .wInputAreaHeightSet(100)
            //提示文本
            .wPlaceholderSet(@"请输入内容")
            //编辑框最大行数 大于行数则滚动
            .wWirteTextMaxLineSet(5)
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
            .wRegularSet(@{DialogRegulars:@"^1+[3578]+\\d{9}",DialogRegularTip:@"手机号格式错误"})
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
                if (DialogStrIsNotEmpty(anyID)) {
                    //手动调用类方法关闭
                    [WMZDialog closeWithshowView:nil block:nil];
                }else{
                    AlertAuto(@"输入不能为空")
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
