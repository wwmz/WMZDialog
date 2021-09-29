


//
//  CustomVC.m
//  WMZDialog
//
//  Created by wmz on 2020/4/10.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "CustomVC.h"
#import "CustomView.h"
@interface CustomVC ()
{
    WMZDialog *myAlert;
}
@end

@implementation CustomVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArr = @[@"优酷(自动布局)",@"bili(自动计算)",@"饿了么(固定高度)",@"传入一个View"];
}

-(void)action:(UIButton*)sender{
    switch (sender.tag) {
        case 0:{
            [self youkuDialog];
        }
            break;
        case 1:{
            [self bilibiliDialog];
        }
            break;
        case 2:{
            [self elementDialog];
        }
            break;
        case 3:{
            Dialog()
            .wTypeSet(DialogTypeMyView)
            .wMyDiaLogViewSet(^UIView *(UIView *mainView) {
                mainView.layer.masksToBounds = YES;
                UIView *view = [[CustomView alloc] initWithFrame:CGRectMake(0, 0, 400, 250) superView:mainView];
                mainView.layer.masksToBounds = YES;
                mainView.layer.cornerRadius = 10;
                return view;
            })
            .wStart();
        }
        break;
        default:
            break;
    }
}


//自定义优酷方法  Masonry使用示例
- (void)youkuDialog{
    __weak CustomVC *WEAK = self;
    myAlert = Dialog()
    .wTypeSet(DialogTypeMyView)
    .wShowAnimationSet(AninatonZoomIn)
    .wHideAnimationSet(AninatonZoomOut)
    .wMyDiaLogViewSet(^UIView *(UIView *mainView) {
        UIImageView *image = [UIImageView new];
        image.image = [UIImage imageNamed:@"healthy"];
        [mainView addSubview:image];
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(80).priorityHigh();
            make.left.right.top.mas_equalTo(0);
        }];
        
        UILabel *la = [UILabel new];
        la.font = [UIFont systemFontOfSize:15.0f];
        la.text = @"为呵护未成年人健康成长,优酷特别推出青少年模式,该模式下部分功能无法正常使用,请监护人主动选择，并设置监护密码";
        la.numberOfLines = 0;
        [mainView addSubview:la];
        [la mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.top.equalTo(image.mas_bottom);
        }];
        
        UIButton *enter = [UIButton buttonWithType:UIButtonTypeCustom];
        [mainView addSubview:enter];
        enter.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [enter setTitle:@"进入青少年模式 >" forState:UIControlStateNormal];
        [enter setTitleColor:DialogColor(0x108ee9) forState:UIControlStateNormal];
        [enter addTarget:WEAK action:@selector(youkuAction:) forControlEvents:UIControlEventTouchUpInside];
        [enter mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(44).priorityHigh();
            make.top.equalTo(la.mas_bottom);
        }];
        
        UIButton *know = [UIButton buttonWithType:UIButtonTypeCustom];
        [mainView addSubview:know];
        know.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [know setTitle:@"我知道了" forState:UIControlStateNormal];
        [know setTitleColor:DialogDarkColor(DialogColor(0x3333333), DialogColor(0xffffff)) forState:UIControlStateNormal];
        [know addTarget:WEAK action:@selector(youkuAction:) forControlEvents:UIControlEventTouchUpInside];
        [know mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(44).priorityHigh();
            make.top.equalTo(enter.mas_bottom);
        }];
    
        mainView.layer.masksToBounds = YES;
        mainView.layer.cornerRadius = 10;
        return know;
    })
    .wStartView(self.view);
}

//优酷自定义方法
- (void)youkuAction:(UIButton*)sender{
    NSLog(@"点击方法");
    //关闭
    [myAlert closeView];
}

//哔哩哔哩
- (void)bilibiliDialog{
    myAlert = Dialog()
    .wTypeSet(DialogTypeMyView)
    .wShowAnimationSet(AninatonCounterclockwise)
    .wHideAnimationSet(AninatonClockwise)
    .wWidthSet(DialogScreenW*0.85)
    .wMyDiaLogViewSet(^UIView *(UIView *mainView) {

        UILabel *la = [UILabel new];
        la.font = [UIFont systemFontOfSize:17.0f];
        la.textAlignment = NSTextAlignmentCenter;
        la.text = @"协议条款更新提示";
        la.numberOfLines = 0;
        la.frame = CGRectMake(0, 15, mainView.frame.size.width, 35);
        [mainView addSubview:la];
        
        UITextView *textView = [UITextView new];
        textView.editable = NO;
        textView.frame = CGRectMake(0, CGRectGetMaxY(la.frame)+15, mainView.frame.size.width, 120);
        textView.font = [UIFont systemFontOfSize:16.0];
        textView.text = @"  本协议是用户（下称“用户”或“您”）与哔哩哔哩之间的协议，哔哩哔哩将按照本协议约定之内容为您提供服务。“哔哩哔哩”是指哔哩哔哩和/或其相关服务可能存在的运营关联单位。若您不同意本协议中所述任何条款或其后对协议条款的修改，请您不要使用哔哩哔哩提供的相关服务。您的使用行为将视作对本协议全部条款的完全接受";
        [mainView addSubview:textView];
        
        UILabel *text = [UILabel new];
        text.font = [UIFont systemFontOfSize:15.0f];
        text.textAlignment = NSTextAlignmentCenter;
        text.textColor = DialogColor(0x999999);
        NSString *str = @"您可通过阅读完整版《哔哩哔哩弹幕网用户使用协议》了解详尽的条款内容";
        NSMutableAttributedString *mStr = [[NSMutableAttributedString alloc] initWithString:str];
        [mStr addAttribute:NSForegroundColorAttributeName value:DialogColor(0x5297E1) range:[str rangeOfString:@"《哔哩哔哩弹幕网用户使用协议》"]];
        text.attributedText = mStr;
        text.numberOfLines = 2;
        text.frame = CGRectMake(0, CGRectGetMaxY(textView.frame)+10, mainView.frame.size.width, 60);
        [mainView addSubview:text];
        
        mainView.layer.masksToBounds = YES;
        mainView.layer.cornerRadius = 10;
        return text;
    })
    //添加底部
    .wAddBottomViewSet(YES)
    .wEventCancelFinishSet(^(id anyID, id otherData) {})
    .wOKTitleSet(@"同意")
    .wCancelTitleSet(@"不同意")
    .wOKColorSet(DialogColor(0xff709a))
    .wCancelColorSet(DialogColor(0x666666))
    .wStart();
}


//饿了么  //固定高度
- (void)elementDialog{
    @DialogWeakify(self)
    myAlert =
    Dialog()
    //重设frame 如果需要改变frame
    .wCustomMainViewSet(^(UIView *mainView) {
//        CGRect rect = mainView.frame;
//        rect.origin.x+=30;
//        rect.size.height+=30;
//        mainView.frame = rect;
    })
    //固定高度
    .wHeightSet(350)
    .wTypeSet(DialogTypeMyView)
    .wWidthSet(DialogScreenW*0.8)
    .wShowAnimationSet(AninatonZoomInCombin)
    .wHideAnimationSet(AninatonZoomOut)
    .wMyDiaLogViewSet(^UIView *(UIView *mainView) {
        @DialogStrongify(self)
        UIImageView *image = [UIImageView new];
        image.image = [UIImage imageNamed:@"down_tyx"];
        image.frame = CGRectMake((mainView.frame.size.width-70)/2, 15, 70, 70);
        [mainView addSubview:image];
        
        UILabel *la = [UILabel new];
        la.font = [UIFont systemFontOfSize:17.0f];
        la.text = @"新版本抢先体验";
        la.textAlignment = NSTextAlignmentCenter;
        la.frame = CGRectMake(20, CGRectGetMaxY(image.frame)+15, mainView.frame.size.width-40, 40);
        [mainView addSubview:la];
        
        UILabel *text = [UILabel new];
        text.numberOfLines = 0;
        text.font = [UIFont systemFontOfSize:15.0f];
        text.text = @"1.首页改版升级,找到心仪的频道更健康。(逐步开放中)\n2.订单页视觉升级,新增附近常卖模块。(大量开放中)";
        text.textAlignment = NSTextAlignmentCenter;
        text.frame = CGRectMake(20, CGRectGetMaxY(la.frame)+15, mainView.frame.size.width-40, 100);
        [mainView addSubview:text];
        
        UIButton *know = [UIButton buttonWithType:UIButtonTypeCustom];
        [mainView addSubview:know];
        know.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        know.frame = CGRectMake(20, CGRectGetMaxY(text.frame)+15, mainView.frame.size.width-40, 44);
        [know setTitle:@"参加内侧" forState:UIControlStateNormal];
        know.backgroundColor = DialogColor(0x108ee9);
        [know addTarget:self action:@selector(elementAction:) forControlEvents:UIControlEventTouchUpInside];
        
        mainView.layer.masksToBounds = YES;
        mainView.layer.cornerRadius = 10;
        return know;
    })
    .wStart();
}


- (void)elementAction:(UIButton*)sender{
    NSLog(@"饿了么点击");
     [myAlert closeView];
}


@end

