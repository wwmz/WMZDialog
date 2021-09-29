

//
//  ScrollViewPopDemo.m
//  WMZDialog
//
//  Created by wmz on 2019/12/22.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "ScrollViewPopDemo.h"
#import "WMZDialog.h"
#define random1(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]
#define randomColor1 random1(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
@interface ScrollViewPopDemo ()

@end

@implementation ScrollViewPopDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIScrollView *sc = [UIScrollView new];
    sc.frame = self.view.bounds;
    [self.view addSubview:sc];
    sc.contentSize = CGSizeMake(DialogScreenW, DialogScreenH*1.5);
    
    UIButton *tmp = nil;
    for (int i = 0; i<10; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake((DialogScreenW-120)/2, !tmp?100:(CGRectGetMaxY(tmp.frame)+60), 120, 50);
        [sc addSubview:btn];
        btn.backgroundColor = randomColor1;
        [btn setTitle:@"点我弹出" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
        tmp = btn;
        [sc addSubview:btn];
    }
    if (tmp) {
        sc.contentSize = CGSizeMake(DialogScreenW, CGRectGetMaxY(tmp.frame)+60);
    }
}

- (void)tapAction:(UIButton*)btn{
    Dialog()
    .wTypeSet(DialogTypePop)
    .wTapViewTypeSet(DiaPopInViewScrollView)
    .wShowAnimationSet(AninatonZoomIn)
    .wHideAnimationSet(AninatonZoomOut)
    .wTapViewSet(btn)
    .wDataSet(@[
    @{@"name":@"微信",@"image":@"wallet"},
    @{@"name":@"支付宝",@"image":@"aaa"},
    @{@"name":@"米聊",@"image":@"bbb"},
    @{@"name":@"微信1",@"image":@"wallet"},
    ])
    .wStart();
}

@end
