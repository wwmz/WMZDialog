
//
//  WMZDialog+time.m
//  WMZDialog
//
//  Created by wmz on 2019/6/24.
//  Copyright © 2019年 wmz. All rights reserved.
//

#import "WMZDialog+time.h"
@implementation WMZDialog (time)
- (UIView*)timeAction{
    
    [self.mainView addSubview:self.titleLabel];
    self.titleLabel.frame = CGRectMake(self.wMainOffsetX, self.wTitle.length?self.wMainOffsetY:0, self.wWidth-self.wMainOffsetX*2, [WMZDialogTool sizeForTextView:CGSizeMake(self.wWidth-self.wMainOffsetX*2, CGFLOAT_MAX) text:self.titleLabel.text font:self.titleLabel.font.pointSize].height);
    
    [self.mainView addSubview:self.textLabel];
    [self.textLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:self.wTitleFont*2]];
    self.textLabel.frame =  CGRectMake(self.wMainOffsetX,CGRectGetMaxY(self.titleLabel.frame)+ self.wMainOffsetY, self.wWidth-self.wMainOffsetX*2, [WMZDialogTool sizeForTextView:CGSizeMake(self.wWidth-self.wMainOffsetX*2, CGFLOAT_MAX) text:[WMZDialogTool getMMSSFromSS:self.wData?:@"占位字符"] font:self.textLabel.font.pointSize].height);
    
    UIView *view =  [self addBottomView:CGRectGetMaxY(self.textLabel.frame)+self.wMainOffsetY];
    [self reSetMainViewFrame:CGRectMake(0, 0, self.wWidth, CGRectGetMaxY(view.frame))];
    
    if (self.wData&&([self.wData isKindOfClass:[NSString class]]||[self.wData isKindOfClass:[NSNumber class]])) {
       [self createTimer:self.wData];
    }

    return self.mainView;
}


//创建计时器
- (void)createTimer:(NSString *)totalTime{
    __block NSInteger seconds = [totalTime integerValue];
    __weak typeof(self) weakSelf = self;
    if (seconds == 0) {
        DialogWeakSelf(self)
        [self closeView:^{
            if (weakObject.wEventFinish) {
                weakObject.wEventFinish(@"ok",nil, weakObject.wType);
            }
        }];
    }
    dispatch_queue_t global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, global);
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        seconds --;
        if (self.close) {
             dispatch_source_cancel(timer);
        }
        if (seconds<=0) {
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf closeView:^{
                    if (weakSelf.wEventFinish) {
                        weakSelf.wEventFinish(@"ok", nil,weakSelf.wType);
                    }
                }];
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.textLabel.text = [WMZDialogTool getMMSSFromSS:[NSString stringWithFormat:@"%ld",seconds]];
            });
        }
    });
    dispatch_resume(timer);
    
    //如果需要进入后台 定时器也运行的话需要在AppDelegate的enterBackGoround里添加代码 看本项目手动添加
}



@end
