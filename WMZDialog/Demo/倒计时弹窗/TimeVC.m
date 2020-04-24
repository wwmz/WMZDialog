





//
//  TimeVC.m
//  WMZDialog
//
//  Created by wmz on 2020/4/10.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "TimeVC.h"

@interface TimeVC ()

@end

@implementation TimeVC

- (void)viewDidLoad {
    [super viewDidLoad];
     self.dataArr = @[@"倒计时"];
}

-(void)action:(UIButton*)sender{
     Dialog().wTypeSet(DialogTypeTime).wDataSet(@(100)).wStart();
}

@end
