


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
     self.dataArr = @[@"单行输入",@"多行输入"];
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
            Dialog().wTypeSet(DialogTypeWrite)
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
        default:
            break;
    }
}


@end
