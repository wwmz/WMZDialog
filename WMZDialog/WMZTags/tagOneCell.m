



//
//  tagOneCell.m
//  WMZTags
//
//  Created by wmz on 2019/5/29.
//  Copyright © 2019年 wmz. All rights reserved.
//

#import "tagOneCell.h"
#import "WMZTags.h"
@interface tagOneCell()
//tag
@property(nonatomic,strong)WMZTags *myTag;
@property(nonatomic,strong)NSMutableArray *selectArr;
@property(nonatomic,strong)UILabel *styleLabel;
@end
@implementation tagOneCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //不设置的话 会固定拿到320的宽度
        self.contentView.frame = CGRectMake(0, 0, TagWitdh, self.contentView.frame.size.height);
        
        self.styleLabel = [UILabel new];
        self.styleLabel.text = @"分类";
        [self.contentView addSubview:self.styleLabel];
        [self.styleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.left.mas_equalTo(20);
        }];
        
        self.param =
        TagParam()
        .wMasonrySet(^(MASConstraintMaker * _Nonnull make) {
            make.left.mas_equalTo(10);
            make.top.equalTo(self.styleLabel.mas_bottom).offset(10);
            make.bottom.right.mas_equalTo(-10);
        })
        .wBackGroundColorSet([UIColor whiteColor])
        .wSelectOneSet(YES)
        .wSizeSet(small)
        .wInnerColorSet([WMZTagsTool stringTOColor:@"#eeeeee"])
        .wSelectInnerColorSet([UIColor redColor])
        .wColorSet([UIColor blackColor])
        .wSelectColorSet([UIColor whiteColor]);
        self.myTag = [[WMZTags alloc]initConfigureWithModel:_param withView:self.contentView];
    }
    return self;
}


- (void)setModel:(id)model{
    __weak typeof(self) weakWMZSelf = self;
    _model = model;
    NSDictionary *dic = (NSDictionary*)model;
    self.styleLabel.text = dic[@"style"];
    self.param
    .wSelectOneSet(YES)
    .wTapClick(^(NSInteger index, id  _Nonnull model, BOOL isSelected) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"buyCar" object:nil userInfo:@{@"isSelected":@(isSelected),@"data":model,@"index":@(weakWMZSelf.row)}];
    })
    .wDataSet(dic[@"data"]);
    [self updateInnerData:self.param];
    
}

- (NSMutableArray *)selectArr{
    if (!_selectArr) {
        _selectArr = [NSMutableArray new];
    }
    return _selectArr;
}

- (void)updateInnerData:(WMZTagParam *)param{
    self.myTag.param = param;
    [self.myTag updateUI];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end

@interface moneyCell()
@property(nonatomic,strong)UILabel *amount;
@property(nonatomic,assign)NSInteger num;
@property(nonatomic,strong)UIButton *addBtn;
@property(nonatomic,strong)UIButton *deleteBtn;
@end
@implementation moneyCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.num = 1;
        
        UILabel *la = [UILabel new];
        la.text = @"数量";
        [self.contentView addSubview:la];
        [la mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.left.mas_equalTo(20);
        }];
        
        self.addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.addBtn addTarget:self action:@selector(addAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.addBtn setTitle:@"➕" forState:UIControlStateNormal];
        self.addBtn.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.addBtn];
        [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-20);
            make.top.mas_equalTo(20);
            make.width.mas_equalTo(30);
            make.bottom.mas_equalTo(-20);
        }];
        
        self.amount = [UILabel new];
        self.amount.text = [NSString stringWithFormat:@"%ld",self.num];
        [self.contentView addSubview:self.amount];
        [self.amount mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.right.equalTo(self.addBtn.mas_left).offset(-15);
        }];
        
        self.deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.deleteBtn addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.deleteBtn setTitle:@"➖" forState:UIControlStateNormal];
        self.deleteBtn.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.deleteBtn];
        [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.amount.mas_left).offset(-15);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.width.mas_equalTo(30);
        }];
        
        if (self.num>0) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"buyCar" object:nil userInfo:@{@"amount":[NSString stringWithFormat:@"%ld",self.num]}];
        }
    }
    return self;
}

- (void)addAction:(UIButton*)sender{
    self.num+=1;
    self.amount.text = [NSString stringWithFormat:@"%ld",self.num];
    if (self.amount>0) {
        self.deleteBtn.userInteractionEnabled = YES;
        self.deleteBtn.backgroundColor = [UIColor lightGrayColor];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"buyCar" object:nil userInfo:@{@"amount":[NSString stringWithFormat:@"%ld",self.num]}];
}

- (void)deleteAction:(UIButton*)sender{
    if (self.num>0) {
        self.num-=1;
    }
    if (self.num<=0) {
        sender.userInteractionEnabled = NO;
        sender.backgroundColor = [UIColor grayColor];
    }else{
        sender.userInteractionEnabled = YES;
        sender.backgroundColor = [UIColor lightGrayColor];
    }
    self.amount.text = [NSString stringWithFormat:@"%ld",self.num];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"buyCar" object:nil userInfo:@{@"amount":[NSString stringWithFormat:@"%ld",self.num]}];
    
}
@end
