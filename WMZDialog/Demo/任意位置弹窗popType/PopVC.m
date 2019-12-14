//
//  PopVC.m
//  WMZDialog
//
//  Created by wmz on 2019/9/16.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "PopVC.h"
#import "WMZDialog.h"
@interface PopVC ()

@end

@implementation PopVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSArray *arr = @[@"上",@"左",@"下",@"",@"右"];
    for (int i = 0; i<arr.count; i++) {
        CGFloat X = (i % 2) * ([UIScreen mainScreen].bounds.size.width/3 + 20);
        CGFloat Y = (i / 2) * (40 + 100);
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.backgroundColor =  DialogColor(0xE6CEAC);
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(X+50, Y+Device_Dialog_Height/3, [UIScreen mainScreen].bounds.size.width/3, 40);
        [self.view addSubview:btn];
    }
}

- (void)action:(UIButton*)sender{
                Dialog().wTypeSet(DialogTypePop)
                .wEventFinishSet(^(id anyID, NSIndexPath *path, DialogType type) {
                    NSLog(@"%@ %@",anyID,path);
                })
                .wShowAnimationSet(AninatonZoomIn)
                .wHideAnimationSet(AninatonZoomOut)
                .wDirectionSet(sender.tag>3?3:sender.tag)
                .wDataSet(@[
                            @{@"name":@"微信",@"image":@"wallet"},
                            @{@"name":@"支付宝",@"image":@"aaa"},
                            @{@"name":@"米聊",@"image":@"bbb"},
                            @{@"name":@"微信1",@"image":@"wallet"},
                            ])
                .wTapViewSet(sender)
                .wStart();
}
@end
