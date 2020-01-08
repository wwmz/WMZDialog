



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
    NSArray *arr = @[@"年月日+默认时间",@"年月日时分秒",@"自由组合(年月时)",@"带后缀",@"自由带后缀",@"改字体颜色大小",@"无限循环滚动",@"设置最小和最大时间"];
    for (int i = 0; i<arr.count; i++) {
        CGFloat X = (i % 2) * ([UIScreen mainScreen].bounds.size.width/3 + 20);
        CGFloat Y = (i / 2) * (40 + 20);
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.backgroundColor =  DialogColor(0xE6CEAC);
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(X+50, Y+100, [UIScreen mainScreen].bounds.size.width/3, 40);
        [self.view addSubview:btn];
    }
    
}

- (void)action:(UIButton*)sender{
    
    //设置最小和最大时间
    if (sender.tag == 7) {
        
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
        [dateComponents setYear:+20];
        [dateComponents setMonth:-4];
        NSDate *maxDate = [gregorian dateByAddingComponents:dateComponents toDate:[NSDate date] options:0];
        NSDateComponents *dateComponents1 = [[NSDateComponents alloc] init];
        [dateComponents1 setYear:-20];
        NSDate *minDate = [gregorian dateByAddingComponents:dateComponents1 toDate:[NSDate date] options:0];
        Dialog()
        .wEventOKFinishSet(^(id anyID, id otherData) {
            NSLog(@"选中 %@ %@",anyID,otherData);
        })
        //年月日时分秒|年月日|年月| 的格式 设置时间限制才有效 其余没有具体时间的约束无效
        .wDateTimeTypeSet(@"yyyy年MM月dd日")
//        .wDateTimeTypeSet(@"yyyy-MM-dd HH:mm:ss")
        //最小时间
        .wMinDateSet(minDate)
        //最大时间
        .wMaxDateSet(maxDate)
        //此时最好关闭循环防止出错 
        .wPickRepeatSet(NO)
        .wTypeSet(DialogTypeDatePicker)
        .wStart();
        return;
    }
    
    
    
    NSDictionary *mdic = @{
                          @(0):@"yyyy-MM-dd",
                          @(1):@"yyyy-MM-dd HH:mm:ss",
                          @(2):@"yyyy-MM HH",
                          @(3):@"yyyy年MM月dd日 HH时mm分ss秒",
                          @(4):@"yyyy年MM月dd日 HH:mm:ss",
                          @(5):@"yyyy年MMdd日 HH时mm:ss",
                          @(6):@"yyyy-MM-dd HH:mm",
                          };
    Dialog()
    .wEventOKFinishSet(^(id anyID, id otherData) {
        NSLog(@"选中 %@ %@",anyID,otherData);
    })
    //默认选中时间 不传默认是当前时间
    .wDefaultDateSet(sender.tag == 0?[NSDate dateWithTimeIntervalSinceNow:24*60*60]:[NSDate date])
    .wDateTimeTypeSet(mdic[@(sender.tag)])
    .wPickRepeatSet(sender.tag == 6?YES:NO)
    .wTypeSet(DialogTypeDatePicker)
    .wMessageColorSet(sender.tag == 5?[UIColor redColor]:[UIColor blackColor])
    .wMessageFontSet(sender.tag == 5?18:16)
    .wStart();
}


@end
