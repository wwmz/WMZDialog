





//
//  NestedPopDemo.m
//  WMZDialog
//
//  Created by wmz on 2019/12/23.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "NestedPopDemo.h"
#import "WMZDialog.h"
#define random1(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]
#define randomColor1 random1(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
@interface NestedPopDemo ()

@end

@implementation NestedPopDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self viewOne];
    [self viewTwo];
    [self viewThree];
}

- (void)viewOne{
     UIView *back = [UIView new];
     back.backgroundColor = randomColor1;
     back.frame = CGRectMake(0, 100, DialogScreenW, DialogScreenH/3-120);
     [self.view addSubview:back];
     UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
     btn1.tag = 998;
     btn1.titleLabel.font = [UIFont systemFontOfSize:14];
     btn1.backgroundColor =  DialogColor(0xE6CEAC);
     [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
     [btn1 setTitle:@"视图内点我" forState:UIControlStateNormal];
     [btn1 addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
     btn1.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/5, 50, [UIScreen mainScreen].bounds.size.width/3, 50);
     [back addSubview:btn1];
}

- (void)viewTwo{
    UIView *back = [UIView new];
     back.backgroundColor = randomColor1;
     back.frame = CGRectMake(0, DialogScreenH/3, DialogScreenW, DialogScreenH/3-120);
     [self.view addSubview:back];
     UIView *back1 = [UIView new];
     back1.backgroundColor = [UIColor orangeColor];
     back1.frame = CGRectMake(20, 20, back.frame.size.width-40, back.frame.size.height-40);
     [back addSubview:back1];
     UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
     btn1.tag = 999;
     btn1.titleLabel.font = [UIFont systemFontOfSize:14];
     btn1.backgroundColor =  DialogColor(0xE6CEAC);
     [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
     [btn1 setTitle:@"视图内点我" forState:UIControlStateNormal];
     [btn1 addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
     btn1.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/5, 50, [UIScreen mainScreen].bounds.size.width/3, 50);
     [back1 addSubview:btn1];
}

- (void)viewThree{
     UIView *back = [UIView new];
     back.backgroundColor = randomColor1;
     back.frame = CGRectMake(0, DialogScreenH*0.6, DialogScreenW, DialogScreenH/3-120);
     [self.view addSubview:back];
     UIView *back1 = [UIView new];
     back1.backgroundColor = [UIColor orangeColor];
     back1.frame = CGRectMake(20, 20, back.frame.size.width-40, back.frame.size.height-40);
     [back addSubview:back1];
     UIView *back2 = [UIView new];
     back2.backgroundColor = [UIColor redColor];
     back2.frame = CGRectMake(20, 20, back1.frame.size.width-40, back1.frame.size.height-40);
     [back1 addSubview:back2];
     UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
     btn1.tag = 999;
     btn1.titleLabel.font = [UIFont systemFontOfSize:14];
     btn1.backgroundColor =  DialogColor(0xE6CEAC);
     [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
     [btn1 setTitle:@"视图内点我" forState:UIControlStateNormal];
     [btn1 addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
     btn1.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/5,20, [UIScreen mainScreen].bounds.size.width/3, 50);
     [back2 addSubview:btn1];
}

- (void)action:(UIButton*)sender{
    Dialog().wTypeSet(DialogTypePop)
    .wShowAnimationSet(AninatonZoomIn)
    .wHideAnimationSet(AninatonZoomOut)
    .wDataSet(@[
            @{@"name":@"微信",@"image":@"wallet"},
            @{@"name":@"支付宝",@"image":@"aaa"},
            @{@"name":@"米聊",@"image":@"bbb"},
            @{@"name":@"微信1",@"image":@"wallet"},
        ])
    .wTapViewSet(sender)
    .wStart();
}

//传touch的坐标即可
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint touchPoint  = [[touches  anyObject] locationInView:self.view];
    Dialog().wTypeSet(DialogTypePop)
    .wTapRectSet(CGRectMake(touchPoint.x, touchPoint.y, 0, 0))
    .wDataSet(@[
               @{@"name":@"微信",@"image":@"wallet"},
               @{@"name":@"支付宝",@"image":@"aaa"},
               @{@"name":@"米聊",@"image":@"bbb"},
               @{@"name":@"微信1",@"image":@"wallet"},
        ])
    .wStart();
}

@end
