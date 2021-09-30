//
//  BaseVC.m
//  WMZDialog
//
//  Created by wmz on 2020/4/10.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "BaseVC.h"

@interface BaseVC ()

@end

@implementation BaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setTitle:self.name];
}
- (void)setDataArr:(NSArray *)dataArr{
    _dataArr = dataArr;
    NSInteger row = 2;
    if (self.view.bounds.size.width/self.btnWidth*1.0 < 2) {
        row = 1;
    }
    for (int i = 0; i<dataArr.count; i++) {
        CGFloat X = (i % row) * (self.btnWidth + 20);
        CGFloat Y = (i / row) * (40 + 20);
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.layer.backgroundColor =  DialogColor(0xE6CEAC).CGColor;
        btn.layer.cornerRadius = 3;
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitle:dataArr[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(X+50, Y+100, self.btnWidth, 40);
        [self.view addSubview:btn];
    }
}

-(void)action:(UIButton*)sender{
    
}

- (CGFloat)btnWidth{
    if (!_btnWidth) {
        _btnWidth = [UIScreen mainScreen].bounds.size.width/3;
    }
    return _btnWidth;
}

@end
