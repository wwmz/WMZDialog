//
//  DownVC.m
//  WMZDialog
//
//  Created by wmz on 2020/4/10.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "DownVC.h"

@interface DownVC ()

@end

@implementation DownVC

- (void)viewDidLoad {
    [super viewDidLoad];
     self.dataArr = @[@"模拟下载"];
}

-(void)action:(UIButton*)sender{
    //使用
    WMZDialog *alert = Dialog()
    .wTitleSet(@"正在下载")
    .wTypeSet(DialogTypeDown)
    .wImageNameSet(@"down_tyx")
    .wEventFinishSet(^(id anyID, NSIndexPath *path, DialogType type) {
        NSLog(@"%@",anyID);
    })
    .wDataSet(@(0.0)).wStart();
         
    
    //模拟下载
    __block CGFloat seconds = 0;
    dispatch_queue_t global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, global);
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        if (seconds>=1) {
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
              [alert closeView];
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


@end
