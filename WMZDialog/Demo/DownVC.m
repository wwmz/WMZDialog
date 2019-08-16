





//
//  DownVC.m
//  WMZDialog
//
//  Created by wmz on 2019/8/16.
//  Copyright © 2019年 wmz. All rights reserved.
//

#import "DownVC.h"
#import "WMZDialog.h"
@interface DownVC ()
{
    WMZDialog * alert;
}
@end

@implementation DownVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSArray *arr = @[@"开始"];
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
    id data = @(0.0);

    alert = Dialog()
    //关闭事件
    .wEventCloseSet(^(id anyID, id otherData) {
        //此时 需要手动置为nil 否则会持有alert导致无法销毁
        alert = nil;
    })
    .wTypeSet(DialogTypeDown)
    .wDataSet(data).wStart();
    
    __block CGFloat seconds = 0;
    dispatch_queue_t global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, global);
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        if (seconds>=1) {
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
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

- (void)dealloc{
    NSLog(@"销毁");
}

@end
