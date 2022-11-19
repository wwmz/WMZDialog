//
//  WMZDialogCell.m
//  WMZDialog
//
//  Created by wmz on 2022/11/19.
//  Copyright © 2022 wmz. All rights reserved.
//

#import "WMZDialogCell.h"

@interface WMZDialogCell ()
///title
@property (strong, nonatomic, readwrite) UILabel *textLa;
///icon
@property (strong, nonatomic, readwrite) UIImageView *iconImage;
///line
@property (strong, nonatomic, readwrite) UIView *lineView;
///checkBTN
@property (strong, nonatomic, readwrite) UIImageView *button;
/// params
@property (strong, nonatomic, readwrite) WMZDialogParam *params;
///bgView
@property (strong, nonatomic, readwrite) UIView *bgView;

@end

@implementation WMZDialogCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier param:(WMZDialogParam*)params{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.params = params;
        if([reuseIdentifier isEqualToString:DialogCellTextReuseIdentifier]){
            [self.contentView addSubview:self.textLa];
        }
        else if([reuseIdentifier isEqualToString:DialogCellImageTextReuseIdentifier]){
            [self.contentView addSubview:self.bgView];
            [self.bgView addSubview:self.textLa];
            [self.bgView addSubview:self.iconImage];
        }
        [self.contentView addSubview:self.button];
        [self.contentView addSubview:self.lineView];
    }
    return self;
}

- (void)updateConstraints{
    [super updateConstraints];
    [self.contentView removeConstraints:self.contentView.constraints];
    [self.contentView addConstraints:@[
        [NSLayoutConstraint constraintWithItem:self.button attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1 constant:-3],
        [NSLayoutConstraint constraintWithItem:self.button attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0],
        [NSLayoutConstraint constraintWithItem:self.button attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1 constant:DialogRealW(36)],
        [NSLayoutConstraint constraintWithItem:self.button attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:DialogRealW(36)]
    ]];

    if([self.reuseIdentifier isEqualToString:DialogCellTextReuseIdentifier]){
        self.textLa.numberOfLines = 0;
        if(!self.params.wSelectShowChecked){
            [self.contentView addConstraints:@[
                [NSLayoutConstraint constraintWithItem:self.textLa attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual  toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1 constant: -self.params.wMainOffsetX],
                [NSLayoutConstraint constraintWithItem:self.textLa attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual  toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1 constant: self.params.wMainOffsetX],
            ]];
        }else{
            [self.contentView addConstraints:@[
                [NSLayoutConstraint constraintWithItem:self.textLa attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual  toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1 constant:- DialogRealW(36) - 3],
                [NSLayoutConstraint constraintWithItem:self.textLa attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual  toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1 constant: DialogRealW(36) + 3],
            ]];
        }
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.textLa attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual  toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    }else if ([self.reuseIdentifier isEqualToString:DialogCellImageTextReuseIdentifier]){
        self.textLa.numberOfLines = 0;
        [self.contentView addConstraints:@[
            [NSLayoutConstraint constraintWithItem:self.bgView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1 constant:0],
            [NSLayoutConstraint constraintWithItem:self.bgView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1 constant:0],
            [NSLayoutConstraint constraintWithItem:self.bgView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationLessThanOrEqual toItem:self.contentView attribute:NSLayoutAttributeWidth multiplier:1 constant:0],
        ]];
        if(self.params.wCellAlignType == DialogCellAlignCenter){
            [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.bgView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
        }
        else if(self.params.wCellAlignType == DialogCellAlignLeft){
            [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.bgView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1 constant:self.params.wMainOffsetX]];
        }
        else if(self.params.wCellAlignType == DialogCellAlignRight){
            [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.bgView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1 constant:-self.params.wMainOffsetX]];
        }
        
        if(!self.iconImage.isHidden){
            [self.bgView addConstraints:@[
                [NSLayoutConstraint constraintWithItem:self.iconImage attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.bgView attribute:NSLayoutAttributeLeft multiplier:1 constant:self.params.wMainOffsetX],
                [NSLayoutConstraint constraintWithItem:self.iconImage attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.bgView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0],
                [NSLayoutConstraint constraintWithItem:self.iconImage attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1 constant:self.params.wCellIconSize.width],
                [NSLayoutConstraint constraintWithItem:self.iconImage attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:self.params.wCellIconSize.height],
            ]];
        }
        
        if(!self.textLa.isHidden){
            [self.bgView addConstraints:@[
                [NSLayoutConstraint constraintWithItem:self.textLa attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.bgView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0],
                [NSLayoutConstraint constraintWithItem:self.textLa attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.bgView attribute:NSLayoutAttributeRight multiplier:1 constant:0]
            ]];
            if(self.iconImage.isHidden){
                [self.bgView addConstraint:[NSLayoutConstraint constraintWithItem:self.textLa attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.bgView attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
            }else{
                [self.bgView addConstraint:[NSLayoutConstraint constraintWithItem:self.textLa attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.iconImage attribute:NSLayoutAttributeRight multiplier:1 constant:self.params.wMainOffsetX]];
            }
        }else{
            [self.bgView addConstraint:[NSLayoutConstraint constraintWithItem:self.iconImage attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.bgView attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
        }
    }
    
    [self.contentView addConstraints:@[
        [NSLayoutConstraint constraintWithItem:self.lineView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1 constant:0],
        [NSLayoutConstraint constraintWithItem:self.lineView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1 constant:0],
        [NSLayoutConstraint constraintWithItem:self.lineView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1 constant:0],
        [NSLayoutConstraint constraintWithItem:self.lineView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:0.7]
    ]];
}

- (UILabel *)textLa{
    if(!_textLa){
        _textLa = UILabel.new;
        _textLa.translatesAutoresizingMaskIntoConstraints = NO;
        _textLa.numberOfLines = 0;
    }
    return _textLa;
}

- (UIImageView *)button{
    if(!_button){
        _button = UIImageView.new;
        _button.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _button;
}

- (UIView *)lineView{
    if(!_lineView){
        _lineView = UIView.new;
        _lineView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _lineView;
}

- (UIImageView *)iconImage{
    if(!_iconImage){
        _iconImage = UIImageView.new;
        _iconImage.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _iconImage;
}

- (UIView *)bgView{
    if(!_bgView){
        _bgView = UIView.new;
        _bgView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _bgView;
}
@end
