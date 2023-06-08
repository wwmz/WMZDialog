//
//  WMZDialogNormal.m
//  WMZDialog
//
//  Created by wmz on 2021/7/17.
//  Copyright © 2021 wmz. All rights reserved.
//

#import "WMZDialogNormal.h"
#import "WMZDialog.h"
@implementation WMZDialogNormal
@synthesize cancelBtn = _cancelBtn ;
@synthesize OKBtn = _OKBtn;
@synthesize textLabel = _textLabel;
@synthesize titleLabel = _titleLabel;
@synthesize closeBtn = _closeBtn;
@synthesize bottomView = _bottomView;
@synthesize headView = _headView;
@synthesize iconIV = _iconIV;
@synthesize shareView = _shareView;

- (void)setParam:(WMZDialogParam *)param{
    if (param) {
        self.titleLabel.textColor =  param.wTitleColor;
        self.titleLabel.font = [UIFont systemFontOfSize:param.wTitleFont];
        if([param.wTitle isKindOfClass:NSAttributedString.class]){
            self.titleLabel.attributedText = (NSAttributedString*)param.wTitle;
        }else{
            self.titleLabel.text = param.wTitle;
        }
        self.titleLabel.textAlignment = param.wTextAlignment;

        self.textLabel.font = [UIFont systemFontOfSize:param.wMessageFont];
        self.textLabel.textColor = param.wMessageColor;
        if([param.wMessage isKindOfClass:NSAttributedString.class]){
            self.textLabel.attributedText = (NSAttributedString*)param.wMessage;
        }else{
            self.textLabel.text = param.wMessage;
        }
        self.textLabel.textAlignment = param.wTextAlignment;
           
        self.cancelBtn.titleLabel.font = [UIFont systemFontOfSize:param.wCancelFont];
        [self.cancelBtn setTitleColor:param.wCancelColor forState:UIControlStateNormal];
        [self.cancelBtn addTarget:self action:@selector(cancelAction:)forControlEvents:UIControlEventTouchUpInside];
        self.cancelBtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.cancelBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        if([param.wCancelTitle isKindOfClass:NSAttributedString.class]){
            [self.cancelBtn setAttributedTitle:param.wCancelTitle forState:UIControlStateNormal];
        }else{
            [self.cancelBtn setTitle:param.wCancelTitle forState:UIControlStateNormal];
        }
        self.cancelBtn.backgroundColor = param.wMainBackColor;
        
        [self.OKBtn setTitleColor:param.wOKColor forState:UIControlStateNormal];
        self.OKBtn.titleLabel.font = [UIFont systemFontOfSize:param.wOKFont];
        self.OKBtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.OKBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        if([param.wOKTitle isKindOfClass:NSAttributedString.class]){
            [self.OKBtn setAttributedTitle:param.wOKTitle forState:UIControlStateNormal];
        }else{
            [self.OKBtn setTitle:param.wOKTitle forState:UIControlStateNormal];
        }
        self.OKBtn.backgroundColor = param.wMainBackColor;
        [self.OKBtn addTarget:self action:@selector(confirmAction:) forControlEvents:UIControlEventTouchUpInside];
           
        [self.closeBtn addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.closeBtn setTitle:@"X" forState:UIControlStateNormal];
        [self.closeBtn setTitleColor:param.wCancelColor forState:UIControlStateNormal];
        self.closeBtn.backgroundColor = param.wMainBackColor;
        self.closeBtn.tag = 666;
        self.closeBtn.layer.borderWidth = DialogK1px;
        self.closeBtn.layer.borderColor = param.wCancelColor.CGColor;
    }
    [super setParam:param];
}

- (UIView*)addBottomView:(CGFloat)maxY{
    if (self.bottomView) {
        CGRect rect = self.bottomView.frame;
        rect.origin.y = maxY;
        self.bottomView.frame = rect;
        return self.bottomView;
    }
    
    self.bottomView = [UIView new];
    [self addSubview:self.bottomView];
    
    CGSize OKSize = [WMZDialogUntils sizeForTextView:CGSizeMake(self.param.wWidth, CGFLOAT_MAX) text:self.param.wOKTitle font:[UIFont systemFontOfSize:self.param.wOKFont]];
    CGSize cancelSize ;
    if (self.param.wEventCancelFinish)
        cancelSize = [WMZDialogUntils sizeForTextView:CGSizeMake(self.param.wWidth, CGFLOAT_MAX) text:self.param.wCancelTitle font:[UIFont systemFontOfSize:self.param.wCancelFont]];
    
    UIView *upLine = [UIView new];
    upLine.alpha = self.param.wLineAlpha;
    [self.bottomView addSubview:upLine];
    upLine.backgroundColor = self.param.wLineColor;
    upLine.frame = CGRectMake(0, 0, self.param.wWidth, DialogK1px);
    if (self.param.wEventCancelFinish) {
        [self.bottomView addSubview:self.cancelBtn];
        self.cancelBtn.frame = CGRectMake(0, CGRectGetMaxY(upLine.frame)+self.param.wMainOffsetX, self.param.wWidth/2-DialogK1px/2, MAX(self.param.wMainBtnHeight, cancelSize.height));
        
        UIView *Line = [UIView new];
        Line.alpha = self.param.wLineAlpha;
        Line.tag = 11111;
        [self.bottomView addSubview:Line];
        Line.backgroundColor = self.param.wLineColor;
        Line.frame = CGRectMake(CGRectGetMaxX(self.cancelBtn.frame),  self.param.wFillBottomLine?CGRectGetMaxY(upLine.frame): self.cancelBtn.frame.origin.y, DialogK1px, MAX(CGRectGetHeight(self.OKBtn.frame), CGRectGetHeight(self.cancelBtn.frame)) + (self.param.wFillBottomLine?self.param.wMainOffsetX * 2:0));
    }
    
    [self.bottomView addSubview:self.OKBtn];
    self.OKBtn.frame = CGRectMake(self.param.wEventCancelFinish? CGRectGetMaxX(self.cancelBtn.frame) + DialogK1px:0, CGRectGetMaxY(upLine.frame)+self.param.wMainOffsetX,self.param.wEventCancelFinish?self.param.wWidth/2-DialogK1px/2:self.param.wWidth, MAX(self.param.wMainBtnHeight, OKSize.height));

    if (OKSize.width > (self.OKBtn.frame.size.width - self.param.wMainOffsetX * 2) ||
        cancelSize.width > (self.OKBtn.frame.size.width - self.param.wMainOffsetX * 2)) {
        UIView *line = [self.bottomView viewWithTag:11111];
        if (self.param.wEventCancelFinish) {
            self.cancelBtn.frame = CGRectMake(self.param.wMainOffsetX, CGRectGetMaxY(upLine.frame)+self.param.wMainOffsetX, self.param.wWidth  - self.param.wMainOffsetX*2, cancelSize.height);
            if (line) {
                line.frame = CGRectMake(0, CGRectGetMaxY(self.cancelBtn.frame) + (self.param.wFillBottomLine?0:self.param.wMainOffsetX), self.param.wWidth, DialogK1px);
            }
        }
        self.OKBtn.frame = CGRectMake(self.param.wMainOffsetX, self.param.wEventCancelFinish?(CGRectGetMaxY(line.frame) + self.param.wMainOffsetX): (CGRectGetMaxY(upLine.frame)+self.param.wMainOffsetX),self.param.wWidth - self.param.wMainOffsetX*2, OKSize.height);
    }

    self.bottomView.frame = CGRectMake(0, maxY, self.param.wWidth, MAX(CGRectGetMaxY(self.OKBtn.frame), CGRectGetMaxY(self.cancelBtn.frame)) + self.param.wMainOffsetX);
    
    return self.bottomView;
}

- (UIView*)addTopView{
    if (self.param.wHideExistTop) {
       self.headView = nil; return self.headView;
    }
    if (self.headView) return self.headView;
    CGFloat btnWidth = 50;
    self.headView = [UIView new];
    self.headView.backgroundColor = self.param.wMainBackColor;
    self.headView.frame = CGRectMake(0, 0, self.param.wWidth, self.param.wMainBtnHeight+self.param.wMainOffsetY);
    [self addSubview:self.headView];
        
    [self.headView addSubview:self.cancelBtn];
    self.cancelBtn.frame = CGRectMake(self.param.wMainOffsetX, self.param.wMainOffsetY / 2, btnWidth, self.param.wMainBtnHeight);
    self.cancelBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
          
    [self.headView addSubview:self.OKBtn];
    self.OKBtn.frame = CGRectMake(self.param.wWidth- btnWidth - self.param.wMainOffsetX, self.param.wMainOffsetY / 2,btnWidth, self.param.wMainBtnHeight);
    self.OKBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
          
    [self.headView addSubview:self.titleLabel];
    self.titleLabel.frame = CGRectMake(btnWidth + 2 * self.param.wMainOffsetX, self.param.wMainOffsetY / 2, self.param.wWidth - 2 * btnWidth - 4 * self.param.wMainOffsetX, self.param.wMainBtnHeight);
    
    UIView *line = [UIView new];
    line.backgroundColor = self.param.wLineColor;
    line.frame = CGRectMake(0, self.headView.frame.size.height - DialogK1px, self.headView.frame.size.width, DialogK1px );
    [self.headView addSubview:line];
    return self.headView;
}

- (CGFloat)addTopTitleView{
    [self addSubview:self.titleLabel];
    self.titleLabel.frame = CGRectMake(self.param.wMainOffsetX, self.param.wTitle ? self.param.wMainOffsetY:0, self.param.wWidth - self.param.wMainOffsetX * 2, [WMZDialogUntils sizeForTextView:CGSizeMake(self.param.wWidth - self.param.wMainOffsetX * 2, CGFLOAT_MAX) text:self.param.wTitle font:self.titleLabel.font].height);
    [self addSubview:self.textLabel];
    self.textLabel.frame = CGRectMake(self.param.wMainOffsetX, CGRectGetMaxY(self.titleLabel.frame) + (self.param.wMessage ? self.param.wMainOffsetY : 0), self.param.wWidth - self.param.wMainOffsetX * 2, [WMZDialogUntils sizeForTextView:CGSizeMake(self.param.wWidth-self.param.wMainOffsetX * 2, CGFLOAT_MAX) text:self.param.wMessage font:self.textLabel.font].height);
    return CGRectGetMaxY(self.textLabel.frame);
}

/// 取消事件
- (void)cancelAction:(WMZDialogButton*)sender{
    @DialogWeakify(self)
    [[WMZDialogManage.shareInstance currentDialog:self]  closeView:^{
        @DialogStrongify(self)
        if (self.param.wEventCancelFinish)
            self.param.wEventCancelFinish([WMZDialogManage.shareInstance currentDialog:self],sender);
    }];
}

/// 确定事件
- (void)confirmAction:(WMZDialogButton*)sender{
    @DialogWeakify(self)
    [[WMZDialogManage.shareInstance currentDialog:self] closeView:^{
        @DialogStrongify(self)
        if (self.param.wEventOKFinish)
            self.param.wEventOKFinish([WMZDialogManage.shareInstance currentDialog:self],sender);
    }];
}

///关闭事件
- (void)closeAction:(WMZDialogButton*)sender{
    [[WMZDialogManage.shareInstance currentDialog:self] closeView];
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

- (UILabel *)textLabel{
    if (!_textLabel) {
        _textLabel = [UILabel new];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.numberOfLines = 0;
    }
    return _textLabel;
}

-(WMZDialogButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn = [WMZDialogButton buttonWithType:UIButtonTypeCustom];
    }
    return _cancelBtn;
}

-(WMZDialogButton *)OKBtn{
    if (!_OKBtn) {
        _OKBtn = [WMZDialogButton buttonWithType:UIButtonTypeCustom];
    }
    return _OKBtn;
}

- (WMZDialogButton *)closeBtn{
    if (!_closeBtn) {
         _closeBtn = [WMZDialogButton buttonWithType:UIButtonTypeCustom];
     }
     return _closeBtn;
}

- (UIImageView *)iconIV{
    if (!_iconIV) {
        _iconIV = UIImageView.new;
    }
    return _iconIV;
}

- (UIScrollView *)shareView{
    if (!_shareView) {
        UIScrollView *shareView = [UIScrollView new];
        shareView.tag = 10086;
        shareView.showsVerticalScrollIndicator = NO;
        shareView.showsHorizontalScrollIndicator = NO;
        shareView.pagingEnabled = YES;
        shareView.bounces = NO;
        shareView.backgroundColor = DialogDarkOpenColor(UIColor.whiteColor, WMZDialogManage.shareInstance.darkColorInfo[DialogDarkMainColor],self.param.wOpenDark);
        _shareView =  shareView;
    }
    return _shareView;
}

@end
