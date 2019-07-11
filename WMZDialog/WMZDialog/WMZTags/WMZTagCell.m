//
//  WMZTagCell.m
//  WMZTags
//
//  Created by wmz on 2019/5/24.
//  Copyright © 2019年 wmz. All rights reserved.
//

#import "WMZTagCell.h"
#import "WMZTags.h"
@interface WMZTagCell()
//tag
@property(nonatomic,strong)WMZTags *myTag;
@end
@implementation WMZTagCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //不设置的话 会固定拿到320的宽度
        self.contentView.frame = CGRectMake(0, 0, TagWitdh, self.contentView.frame.size.height);
        self.param =
        TagParam()
        .wMasonrySet(^(MASConstraintMaker * _Nonnull make) {
            make.left.top.mas_equalTo(10);
            make.bottom.right.mas_equalTo(-10);
        })
        .wParentViewSet(self.contentView);
        self.myTag = [[WMZTags alloc]initConfigureWithModel:_param];
    }
    return self;
}


- (void)setModel:(NSArray *)model{
    _model = model;
    self.param.wDataSet(model);
    [self updateInnerData:self.param];
    
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
