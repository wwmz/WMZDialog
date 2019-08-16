



//
//  DateTimeVC.m
//  WMZDialog
//
//  Created by wmz on 2019/8/15.
//  Copyright © 2019年 wmz. All rights reserved.
//

#import "DateTimeVC.h"
#import "WMZDialog.h"
@interface DateTimeVC ()

@end

@implementation DateTimeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    NSArray *arr = @[@"年月日",@"年月日时分秒",@"自由组合(年月时)",@"带后缀",@"自由带后缀",@"改字体颜色大小",@"无限循环滚动"];
    for (int i = 0; i<arr.count; i++) {
        CGFloat X = (i % 2) * ([UIScreen mainScreen].bounds.size.width/3 + 20);
        CGFloat Y = (i / 2) * (40 + 20);
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.backgroundColor = [UIColor cyanColor];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(X+50, Y+100, [UIScreen mainScreen].bounds.size.width/3, 40);
        [self.view addSubview:btn];
    }
    
}

- (void)action:(UIButton*)sender{
    NSDictionary *mdic = @{
                          @(0):@"yyyy-MM-dd",
                          @(1):@"yyyy-MM-dd HH:mm:ss",
                          @(2):@"yyyy-MM HH",
                          @(3):@"yyyy年MM月dd日 HH时mm分ss秒",
                          @(4):@"yyyy年MM月dd日 HH:mm:ss",
                          @(5):@"yyyy年MMdd日 HH时mm:ss",
                          @(6):@"yyyy-MM-dd HH",
                          };
    Dialog()
    .wEventOKFinishSet(^(id anyID, id otherData) {
        NSLog(@"选中 %@",anyID);
    })
    .wDateTimeTypeSet(mdic[@(sender.tag)])
    .wPickRepeatSet(sender.tag == 6?YES:NO)
    .wTypeSet(DialogTypeDatePicker)
    .wMessageColorSet(sender.tag == 5?[UIColor redColor]:[UIColor blackColor])
    .wMessageFontSet(sender.tag == 5?18:16)
    .wStart();
}


@end
