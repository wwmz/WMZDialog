//
//  WMZDialogShareView.m
//  WMZDialog
//
//  Created by wmz on 2019/9/12.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "WMZDialogShareView.h"
@interface WMZDialogShareView()
@property(nonatomic,copy)shareViewSelect block;
@end
@implementation WMZDialogShareView

- (instancetype)initWithText:(NSString*)text withImage:(NSString*)image withBlock:(shareViewSelect)block withTag:(NSInteger)tag{
    if (self = [super init]) {
        self.block = block;
        self.layer.masksToBounds = YES;
        self.userInteractionEnabled = YES;
        self.tag = tag;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageAction:)];
        [self addGestureRecognizer:tap];
        
        [self addSubview:self.imageView];
        self.imageView.image = [UIImage imageNamed:image];
        
        [self addSubview:self.la];
        self.la.text = text;
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted {
    
}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [UIImageView new];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.layer.masksToBounds = YES;
    }
    return _imageView;
}

- (UILabel *)la{
    if (!_la) {
        _la = [UILabel new];
        _la.textAlignment = NSTextAlignmentCenter;
        _la.font = [UIFont systemFontOfSize:15.0f];
    }
    return _la;
}

- (void)imageAction:(UITapGestureRecognizer*)tap{
    if (self.block) {
        self.block(self.tag,self.la.text);
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.imageView.frame = CGRectMake((self.frame.size.width-self.frame.size.height*percentImage)/2,5, self.frame.size.height*percentImage, self.frame.size.height*percentImage);
    self.imageView.layer.cornerRadius = (self.frame.size.height*0.5)/2;
    self.la.frame = CGRectMake(10*0.5, CGRectGetMaxY(self.imageView.frame)+5, self.frame.size.width-10, self.frame.size.height*(1-percentImage)-10*2);
    
}
@end
