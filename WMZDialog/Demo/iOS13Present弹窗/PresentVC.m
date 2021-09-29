//
//  PresentVC.m
//  WMZDialog
//
//  Created by wmz on 2020/4/10.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "PresentVC.h"
#import "Masonry.h"
@interface PresentVC ()
{
    WMZDialog *myAlert;
}
@end

@implementation PresentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArr = @[@"无样式",@"样式1",@"评论列表"];
}

-(void)action:(UIButton*)sender{
    @DialogWeakify(self)
    switch (sender.tag) {
        case 0:{
            Dialog()
            .wTypeSet(DialogTypeCardPresent)
            //关闭圆角 默认有圆角
            .wMainRadiusSet(0)
            //开启则滑动到顶部继续滑动可关闭 default YES
            .wOpenScrollCloseSet(YES)
            //开启侧滑 default YES
            .wLeftScrollCloseSet(NO)
            //开启拖动 default YES
            .wOpenDraggingSet(YES)
            //开启底部缩放 default YES
            .wScaleParentVCSet(NO)
            //自定义底部
            .wParentBottomViewSet(^UIView *(UIView *mainView,UITableView *tableView) {
                UILabel *la = [UILabel new];
                la.textAlignment = NSTextAlignmentCenter;
                la.frame = CGRectMake(0, 0, mainView.frame.size.width, DialogScreenH-88);
                la.text = @"这是一个空视图,可自定义任何视图";
                return la;
            })
            .wStart();
        }
        break;
        case 1:{
           Dialog().wTypeSet(DialogTypeCardPresent)
         //自定义头部
          .wParentHeadViewSet(^UIView *(UIView *mainView,UITableView *tableView) {
             UIView *headView = [UIView new];
             headView.frame = CGRectMake(0, 0, mainView.frame.size.width, 50);

             UILabel *la = [UILabel new];
             la.textAlignment = NSTextAlignmentCenter;
             la.frame = CGRectMake(10, 0, mainView.frame.size.width-10*2, headView.frame.size.height);
             la.text = @"Message";
             [headView addSubview:la];
             
             UIView *line = [UIView new];
             line.backgroundColor =  DialogColor(0xeeeeee) ;
             line.frame = CGRectMake(0, headView.frame.size.height, headView.frame.size.width, 0.3);
             [headView addSubview:line];
             
             return headView;
         })
         //自定义底部
         .wParentBottomViewSet(^UIView *(UIView *mainView,UITableView *tableView) {
             @DialogStrongify(self)
             UIView *bottomView = [UIView new];
             bottomView.frame = CGRectMake(0, 0, mainView.frame.size.width, DialogScreenH-100);
             
             UILabel *la = [UILabel new];
             la.textAlignment = NSTextAlignmentCenter;
             la.frame = CGRectMake(10, 100, mainView.frame.size.width-10*2, 50);
             la.text = @"A unKnown Title";
             la.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
             [bottomView addSubview:la];
             
             UILabel *text = [UILabel new];
             text.textAlignment = NSTextAlignmentCenter;
             text.numberOfLines = 0;
             text.frame = CGRectMake(10, CGRectGetMaxY(la.frame)+50, mainView.frame.size.width-10*2,150);
             text.numberOfLines = 0;
             text.text = @"Always live to see for yourself, and smiles should be particularly splendid, don't care about other people's finger pointing, do yourself, let people who look down on you can't afford it, and people who can see you more like you.";
             text.font = [UIFont systemFontOfSize:17];
             [bottomView addSubview:text];
             
             UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
             [btn addTarget:self action:@selector(youkuAction:) forControlEvents:UIControlEventTouchUpInside];
             btn.layer.cornerRadius = 5;
             btn.layer.masksToBounds = YES;
             [btn setTitle:@"OK" forState:UIControlStateNormal];
             [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
             btn.backgroundColor = [UIColor orangeColor];
             btn.frame = CGRectMake(mainView.frame.size.width*0.2, bottomView.frame.size.height-100, mainView.frame.size.width*0.6, 50);
             [bottomView addSubview:btn];
             
             return bottomView;
         })
         .wStart();
        }
        break;
        case 2:{
           Dialog().wTypeSet(DialogTypeCardPresent)
         //自定义头部
         .wParentHeadViewSet(^UIView *(UIView *mainView,UITableView *tableView) {
             @DialogStrongify(self)
            UIView *headView = [UIView new];
            headView.frame = CGRectMake(0, 0, mainView.frame.size.width, 50);
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn addTarget:self action:@selector(youkuAction:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTitle:@"X" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            btn.frame = CGRectMake(10, headView.frame.size.height*0.15, headView.frame.size.height*0.7, headView.frame.size.height*0.7);
            [headView addSubview:btn];

            UILabel *la = [UILabel new];
            la.textAlignment = NSTextAlignmentCenter;
            la.frame = CGRectMake(CGRectGetMaxY(btn.frame), 0, mainView.frame.size.width-10*2-headView.frame.size.height*1.4, headView.frame.size.height);
            la.text = @"评论列表";
            [headView addSubview:la];
            
            UIView *line = [UIView new];
            line.backgroundColor =  DialogColor(0xeeeeee) ;
            line.frame = CGRectMake(0, headView.frame.size.height, headView.frame.size.width, 0.3);
            [headView addSubview:line];
            
            return headView;
        })
         //自定义底部
          .wParentBottomViewSet(^UIView *(UIView *mainView,UITableView *tableView) {
              tableView.frame = CGRectMake(0, 0, mainView.frame.size.width, DialogScreenH - 200);
              
              UIView *headView = [UIView new];
              headView.backgroundColor = DialogDarkColor(DialogColor(0xeeeeee),DialogColor(0x363536));
              headView.frame = CGRectMake(0, 0, mainView.frame.size.width, 35);
              UILabel *la = [UILabel new];
              la.frame = CGRectMake(15, 0, mainView.frame.size.width-30, 35);
              la.text = @"精彩评论";
              [headView addSubview:la];
              
              tableView.tableHeaderView = headView;
              return tableView;
          })
         //自定义cell
        .wCustomCellSet(^UITableViewCell *(NSIndexPath *indexPath, UITableView *tableView, id model, BOOL isSelected){
             commentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commentCell"];
             if (!cell) {
                 cell =  [[commentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"commentCell"];
             }
             cell.selectionStyle= UITableViewCellSelectionStyleNone;
             cell.model = model;
             return cell;
         })
         //自定义cell高度
         .wCellHeightSet(UITableViewAutomaticDimension)
         .wDataSet([self getData]).wStart();
        }
        break;
    }
}

//点击方法
- (void)youkuAction:(UIButton*)sender{
    NSLog(@"点击方法");
    //关闭
    [myAlert closeView];
}

- (NSArray*)getData{
    
    NSArray *arr = @[
        @"This scarce antiquarian book is a facsimile reprint of the original. Due to its age, it may contain imperfections such as marks, notations, marginalia and flawed pages. Because we believe this work is culturally important, we have made it available as part of our commitment for protecting, preserving, and promoting the world's literature in affordable, high quality, modern editions that are true to the original work.",
        @"Always live to see for yourself, and smiles should be particularly splendid, don't care about other people's finger pointing, do yourself, let people who look down on you can't afford it, and people who can see you more like you.",
        @"Some things are clear in your heart, you don't have to write your emotions on your face, you don't have to talk about dissatisfaction with others, and don't be as serious as a stubborn fool.",
        @"This scarce antiquarian book is a facsimile reprint of the original. Due to its age, it may contain imperfections such as marks, notations, marginalia and flawed pages. Because we believe this work is culturally important, we have made it available as part of our commitment for protecting, preserving, and promoting the world's literature in affordable, high quality, modern editions that are true to the original work.",
        @"Always live to see for yourself, and smiles should be particularly splendid, don't care about other people's finger pointing, do yourself, let people who look down on you can't afford it, and people who can see you more like you.",
        @"Some things are clear in your heart, you don't have to write your emotions on your face, you don't have to talk about dissatisfaction with others, and don't be as serious as a stubborn fool.",
        @"This scarce antiquarian book is a facsimile reprint of the original. Due to its age, it may contain imperfections such as marks, notations, marginalia and flawed pages. Because we believe this work is culturally important, we have made it available as part of our commitment for protecting, preserving, and promoting the world's literature in affordable, high quality, modern editions that are true to the original work.",
        @"Always live to see for yourself, and smiles should be particularly splendid, don't care about other people's finger pointing, do yourself, let people who look down on you can't afford it, and people who can see you more like you.",
        @"Some things are clear in your heart, you don't have to write your emotions on your face, you don't have to talk about dissatisfaction with others, and don't be as serious as a stubborn fool.",
        
    ];
    NSMutableArray *tmpArr = [NSMutableArray new];
    for (int i = 0; i<arr.count; i++) {
        commentModel *model = [commentModel new];
        model.content = arr[i];
        [tmpArr addObject:model];
    }
    return [NSArray arrayWithArray:tmpArr];
}


@end


@implementation commentCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self UI];
    }
    return self;
}

- (void)UI{
    self.icon = [UIImageView new];
    self.icon.image = [UIImage imageNamed:@"advise"];
    [self.contentView addSubview:self.icon];
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(40);
        make.left.top.mas_equalTo(15);
    }];
    self.icon.layer.masksToBounds = YES;
    self.icon.layer.cornerRadius = 20;
    
    self.name = [UILabel new];
    self.name.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
    [self.contentView addSubview:self.name];
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icon.mas_right).offset(10);
        make.right.mas_equalTo(-10);
        make.top.equalTo(self.icon.mas_top);
    }];
    
    self.mainText = [UILabel new];
    self.mainText.font = [UIFont systemFontOfSize:15];
    self.mainText.numberOfLines = 0;
    [self.contentView addSubview:self.mainText];
    [self.mainText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.name.mas_left);
        make.right.mas_equalTo(-10);
        make.top.equalTo(self.name.mas_bottom).offset(3);
    }];
    
    self.prise = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.prise setImage:[UIImage imageNamed:@"prise"] forState:UIControlStateNormal];
    [self.prise setImage:[UIImage imageNamed:@"prise1"] forState:UIControlStateSelected];
    [self.prise addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.prise];
    [self.prise mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.width.height.mas_equalTo(25);
        make.top.equalTo(self.mainText.mas_bottom).offset(10);
        make.bottom.mas_equalTo(-10);
    }];
    
    self.time = [UILabel new];
    self.time.text = @"2019/10/10";
    self.time.font = [UIFont systemFontOfSize:14];
    self.time.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.time];
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.name.mas_left);
        make.right.equalTo(self.prise.mas_left).offset(-10);
        make.top.equalTo(self.prise.mas_top);
    }];
}

- (void)setModel:(commentModel *)model{
    _model  = model;
    self.name.text = @"Reprint";
    self.mainText.text = model.content;
    self.prise.selected = model.check;
}

- (void)tapAction:(UIButton*)btn{
    self.model.check = !self.model.check ;
    btn.selected = self.model.check;
}
@end

@implementation commentModel
@end
