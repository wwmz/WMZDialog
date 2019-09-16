
//
//  WMZTagBtn.m
//  WMZTags
//
//  Created by wmz on 2019/5/24.
//  Copyright © 2019年 wmz. All rights reserved.
//

#import "WMZTagBtn.h"
@interface WMZTagBtn()
@property(nonatomic,strong)WMZTagParam *param;
@end
@implementation WMZTagBtn

+ (instancetype)buttonWithType:(UIButtonType)buttonType
                     WithParam:(WMZTagParam*)param
                       withTag:(NSInteger)tag
                      withText:(NSString*)text
                       BtnType:(BtnType)type{
    WMZTagBtn *btn  = [WMZTagBtn buttonWithType:buttonType];
    btn.param = param;
    btn.text = text;
    btn.tag = tag;
    btn.type = type;
    return btn;
}

- (CGFloat)oneLineHeight{
    if (!_oneLineHeight) {
        _oneLineHeight = [self sizeWithFont:[UIFont systemFontOfSize:self.param.wFont] maxSize:CGSizeMake(_maxWidth, CGFLOAT_MAX) withText:@"one"].height;
    }
    return _oneLineHeight;
}

- (NSInteger)lineCount{
    if (!_lineCount) {
        _lineCount = self.maxSize.height / self.oneLineHeight;
    }
    if (_lineCount == 0) {
        _lineCount = 1;
    }
    return _lineCount;
}

- (CGSize)maxSize{
    if (!_maxSize.width||!_maxSize.height) {
        _maxSize = [self sizeWithFont:[UIFont systemFontOfSize:self.param.wFont] maxSize:CGSizeMake(_maxWidth, CGFLOAT_MAX) withText:self.text];
    }
    return _maxSize;
    
}

- (void)setSize{
    //定制大小
    NSDictionary *sizeDic = @{
                              @(medium):@{
                                      @"wFont":@(self.param.wFont*1.5),
                                      @"btnTop":@(self.param.btnLeft*1.5),
                                      @"btnLeft":@(self.param.btnTop*1.5),
                                      @"btnPaddingLeft":@(self.param.btnPaddingLeft*1.5)
                                      },
                              @(small):@{
                                      @"wFont":@(self.param.wFont*0.8),
                                      @"btnTop":@(self.param.btnLeft*0.8),
                                      @"btnLeft":@(self.param.btnTop*0.8),
                                      @"btnPaddingLeft":@(self.param.btnPaddingLeft*0.8)
                                      },
                              @(mini):@{
                                      @"wFont":@(self.param.wFont*0.6),
                                      @"btnTop":@(self.param.btnLeft*0.6),
                                      @"btnLeft":@(self.param.btnTop*0.6),
                                      @"btnPaddingLeft":@(self.param.btnPaddingLeft*0.6)
                                      }
                              };
    if (self.param.wSize) {
        NSDictionary *dic = sizeDic[@(self.param.wSize)];
        if (self.param.wFont && self.param.wFont == 14) {
            self.param.wFont = [dic[@"wFont"] floatValue];
        }
        if (self.param.btnTop && self.param.btnTop == 30) {
            self.param.btnTop = [dic[@"btnTop"] floatValue];
        }
        if (self.param.btnLeft && self.param.btnLeft == 30) {
            self.param.btnLeft = [dic[@"btnLeft"] floatValue];
        }
        if (self.param.btnPaddingLeft && self.param.btnPaddingLeft == 5) {
            self.param.btnPaddingLeft = [dic[@"btnPaddingLeft"] floatValue];
        }
    }
}

- (void)setUI{
    [self setTitle:self.text forState:UIControlStateNormal];
    
    
    //定制主题
    NSDictionary *typeDic= @{
                               @(success):@{
                                       @"wBoderColor":[WMZTagsTool stringTOColor:@"#0BE42B"],
                                       @"wColor":[WMZTagsTool stringTOColor:@"#0BE42B"],
                                       @"wInnerColor":[WMZTagsTool stringTOColor:@"#CFF7D5"],
                                       @"wSelectBoderColor":[WMZTagsTool stringTOColor:@"#605C5C"],
                                       @"wSelectColor":[WMZTagsTool stringTOColor:@"#605C5C"],
                                       @"wSelectInnerColor":[WMZTagsTool stringTOColor:@"#E1DCDC"]
                                       
                                       },
                               @(warning):@{
                                       @"wBoderColor":[WMZTagsTool stringTOColor:@"#605C5C"],
                                       @"wColor":[WMZTagsTool stringTOColor:@"#605C5C"],
                                       @"wInnerColor":[WMZTagsTool stringTOColor:@"#E1DCDC"],
                                       @"wSelectBoderColor":[WMZTagsTool stringTOColor:@"#0BE42B"],
                                       @"wSelectColor":[WMZTagsTool stringTOColor:@"#0BE42B"],
                                       @"wSelectInnerColor":[WMZTagsTool stringTOColor:@"#CFF7D5"]
                                       },
                               @(info):@{
                                       @"wBoderColor":[WMZTagsTool stringTOColor:@"#F9C006"],
                                       @"wColor":[WMZTagsTool stringTOColor:@"#F9C006"],
                                       @"wInnerColor":[WMZTagsTool stringTOColor:@"#F4E7BE"],
                                       @"wSelectBoderColor":[WMZTagsTool stringTOColor:@"#ED4985"],
                                       @"wSelectColor":[WMZTagsTool stringTOColor:@"#ED4985"],
                                       @"wSelectInnerColor":[WMZTagsTool stringTOColor:@"#F4C4C4"]
                                       },
                              @(danger):@{
                                       @"wBoderColor":[WMZTagsTool stringTOColor:@"#ED4985"],
                                       @"wColor":[WMZTagsTool stringTOColor:@"#ED4985"],
                                       @"wInnerColor":[WMZTagsTool stringTOColor:@"#F4C4C4"],
                                       @"wSelectBoderColor":[WMZTagsTool stringTOColor:@"#5297E1"],
                                       @"wSelectColor":[WMZTagsTool stringTOColor:@"#5297E1"],
                                       @"wSelectInnerColor":[WMZTagsTool stringTOColor:@"#CEE1F7"]
                                       },
                               };
    
    if (self.param.wType) {
        
        NSDictionary *dic = typeDic[@(self.param.wType)];
        if (CGColorEqualToColor(self.param.wBoderColor.CGColor, MBoderColor.CGColor)) {
            self.param.wBoderColor = dic[@"wBoderColor"];
        }
        if (CGColorEqualToColor(self.param.wColor.CGColor, MColor.CGColor)) {
            self.param.wColor = dic[@"wColor"];
        }
        if (CGColorEqualToColor(self.param.wInnerColor.CGColor, MInnerColor.CGColor)) {
            self.param.wInnerColor = dic[@"wInnerColor"];
        }
        if (CGColorEqualToColor(self.param.wSelectBoderColor.CGColor, MSelectBoderColor.CGColor)) {
            self.param.wSelectBoderColor = dic[@"wSelectBoderColor"];
        }
        if (CGColorEqualToColor(self.param.wSelectColor.CGColor, MSelectColor.CGColor)) {
            self.param.wSelectColor = dic[@"wSelectColor"];
        }
        if (CGColorEqualToColor(self.param.wSelectInnerColor.CGColor, MSelectInnerColor.CGColor)) {
            self.param.wSelectInnerColor = dic[@"wSelectInnerColor"];
        }
    }
    
    
    self.backgroundColor = self.param.wInnerColor;
    [self setTitleColor:self.param.wColor forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:self.param.wFont];

    if (self.param.wHit) {
        self.layer.borderWidth = self.param.wBoderWidth;
        self.layer.borderColor = self.param.wBoderColor.CGColor;
        self.layer.cornerRadius = self.param.wRadius;
    }
    if (self.param.wRadius) {
        CGFloat btnHeight = self.param.wMasonry? (self.maxSize.height + self.param.btnTop  +0.5):(self.maxSize.height + self.param.btnTop);
        if (self.param.wRadius >= btnHeight/2 ) {
            self.layer.cornerRadius = btnHeight/2;
        }else{
            self.layer.cornerRadius = self.param.wRadius;
        }
    }
    if (self.param.wBoderWidth>0 && self.param.wBoderWidth!=1) {
         self.layer.borderWidth = self.param.wBoderWidth;
    }
    if (self.param.wBoderColor&&self.param.wBoderColor!=MBoderColor) {
        self.layer.borderColor = self.param.wBoderColor.CGColor;
    }
    
    if (self.type == BtnNormal) {
        UIImage *image = nil;
        UIImage *selectImage = nil;
        if (self.param.imageName&&self.param.imageName.length>0) {
            image = [UIImage imageNamed:self.param.imageName];
        }
        if (self.param.selectImageName&&self.param.selectImageName.length>0) {
            selectImage = [UIImage imageNamed:self.param.selectImageName];
        }
        
        if (self.param.wClosable) {
            self.param.textImageName = @"x";
        }
        
        if (self.param.textImageName&&self.param.textImageName.length>0) {
            image = [WMZTagsTool imageWithString:self.param.textImageName font:[UIFont systemFontOfSize:self.param.wFont] width:3000 textAlignment:NSTextAlignmentCenter backColor:self.param.wInnerColor color:self.param.wColor];
        }
        
        if (self.param.selecTextImageName&&self.param.selecTextImageName.length>0) {
            selectImage = [WMZTagsTool imageWithString:self.param.selecTextImageName font:[UIFont systemFontOfSize:self.param.wFont] width:3000 textAlignment:NSTextAlignmentCenter backColor:self.param.wInnerColor color:self.param.wColor];
        }
        
        if (image) {
            [self setImage:image forState:UIControlStateNormal];
            [self TagSetImagePosition: self.param.wClosable ? TagImagePositionRight:self.param.imagePosition spacing:self.param.btnPaddingLeft];
        }
        if (selectImage) {
            [self setImage:selectImage forState:UIControlStateSelected];
            [self TagSetImagePosition: self.param.wClosable ? TagImagePositionRight:self.param.imagePosition spacing:self.param.btnPaddingLeft];
        }
    }
}



- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize withText:(NSString*)text
{
    
    NSDictionary *attrs = @{NSFontAttributeName : font};
    CGSize size = [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    return CGSizeMake(size.width, size.height);
}


//设置按钮样式
- (void)setUpBtnStyle{
    if (!self.selected) {
        self.backgroundColor = self.param.wInnerColor;
        [self setTitleColor:self.param.wColor forState:UIControlStateNormal];
        self.layer.borderColor = self.param.wBoderColor.CGColor;
    }else{
        self.backgroundColor = self.param.wSelectInnerColor;
        [self setTitleColor:self.param.wSelectColor forState:UIControlStateNormal];
        self.layer.borderColor = self.param.wSelectBoderColor.CGColor;
    }
}

@end


@implementation WMZTagBtn (TagImagePosition)

- (void)TagSetImagePosition:(TagImagePosition)postion spacing:(CGFloat)spacing {
    CGFloat imgW = self.imageView.image.size.width;
    CGFloat imgH = self.imageView.image.size.height;
    CGSize trueSize = CGSizeMake(self.maxSize.width, self.maxSize.height);
    
    CGFloat trueLabW = trueSize.width;
    CGFloat trueLabH = trueSize.height;
    if (self.max) {
         trueLabW -= (imgW+spacing+spacing);
    }
    //image中心移动的x距离
    CGFloat imageOffsetX = trueLabW/2 ;
    //image中心移动的y距离
    CGFloat imageOffsetY = trueLabH/2 + spacing/2;
    //label左边缘移动的x距离
    CGFloat labelOffsetX1 = imgW/2 - trueLabW/2 + trueLabW/2;
    //label右边缘移动的x距离
    CGFloat labelOffsetX2 = imgW/2 + trueLabW/2 - trueLabW/2;
    //label中心移动的y距离
    CGFloat labelOffsetY = imgH/2 + spacing/2;
    switch (postion) {
        case TagImagePositionLeft:
            self.imageEdgeInsets = UIEdgeInsetsMake(0, -spacing/2, 0, spacing/2);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, spacing/2, 0, -spacing/2);
            break;
            
        case TagImagePositionRight:
            self.imageEdgeInsets = UIEdgeInsetsMake(0, trueLabW + spacing/2, 0, -(trueLabW + spacing/2));
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -(imgW + spacing/2), 0, imgW + spacing/2);
            break;
            
        case TagImagePositionTop:
            self.imageEdgeInsets = UIEdgeInsetsMake(-imageOffsetY, imageOffsetX, imageOffsetY, -imageOffsetX);
            self.titleEdgeInsets = UIEdgeInsetsMake(labelOffsetY, -labelOffsetX1, -labelOffsetY, labelOffsetX2);
            break;
            
        case TagImagePositionBottom:
            self.imageEdgeInsets = UIEdgeInsetsMake(imageOffsetY, imageOffsetX, -imageOffsetY, -imageOffsetX);
            self.titleEdgeInsets = UIEdgeInsetsMake(-labelOffsetY, -labelOffsetX1, labelOffsetY, labelOffsetX2);
            break;
            
        default:
            break;
    }
}

@end
