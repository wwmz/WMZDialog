
//
//  WMZDialog+Write.m
//  WMZDialog
//
//  Created by wmz on 2019/6/19.
//  Copyright © 2019年 wmz. All rights reserved.
//

#import "WMZDialog+Write.h"
static NSString *writeViewKey = @"writeView"; //passView的key
static NSString *oneLineHeightKey = @"oneLineHeight"; //oneLineHeight的key
@interface WMZDialog()<UITextViewDelegate>
@property (nonatomic, retain) NSNumber *oneLineHeight;
@property (nonatomic, retain) UITextView *writeView;
@end
@implementation WMZDialog (Write)
- (UIView*)writeAction{
    
    [self.mainView addSubview:self.titleLabel];
    self.titleLabel.frame = CGRectMake(self.wMainOffsetX, self.wTitle.length?self.wMainOffsetY:0, self.wWidth-self.wMainOffsetX*2, [WMZDialogTool heightForTextView:CGSizeMake(self.wWidth-self.wMainOffsetX*2, CGFLOAT_MAX) WithText:self.titleLabel.text WithFont:self.titleLabel.font.pointSize]);
    
    [self.mainView addSubview:self.writeView];
    self.writeView.frame = CGRectMake(self.wMainOffsetX,CGRectGetMaxY(self.titleLabel.frame)+self.wMainOffsetY, self.wWidth-self.wMainOffsetX*2, [WMZDialogTool heightForTextView:CGSizeMake(self.wWidth-self.wMainOffsetX*2, CGFLOAT_MAX) WithText:@"占位" WithFont:self.writeView.font.pointSize]+22.0);
    self.oneLineHeight = @([self heightForTextView:CGSizeMake(self.writeView.contentSize.width , CGFLOAT_MAX) WithText:@"测试"]);
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(3, 6, self.wWidth-self.wMainOffsetX*2-6, [WMZDialogTool heightForTextView:CGSizeMake(self.wWidth-self.wMainOffsetX*2, CGFLOAT_MAX) WithText:@"占位" WithFont:self.writeView.font.pointSize]+10)];
    label.enabled = NO;
    label.tag = 999;
    label.text = self.wPlaceholder;
    label.font =  [UIFont systemFontOfSize:self.wMessageFont];
    label.textColor = [UIColor lightGrayColor];
    [self.writeView addSubview:label];

    UIView *view =  [self addBottomView:CGRectGetMaxY(self.writeView.frame)+self.wMainOffsetY];
    [self.OKBtn removeTarget:self action:NSSelectorFromString(@"OKAction:") forControlEvents:UIControlEventTouchUpInside];
    [self.OKBtn addTarget:self action:@selector(writeOKAction:) forControlEvents:UIControlEventTouchUpInside];
    [self reSetMainViewFrame:CGRectMake(0, 0, self.wWidth, CGRectGetMaxY(view.frame))];
    
    
    
    return self.mainView;
}

- (void) textViewDidChange:(UITextView *)textView{
    UILabel *label = [textView viewWithTag:999];
    if ([textView.text length] == 0) {
        [label setHidden:NO];
    }else{
        [label setHidden:YES];
        
    }
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    CGRect frame = textView.frame;
    float height;
    
    //行数
    NSInteger line = 1;
    NSString *mainText = @"";
    if ([text isEqual:@""]) {
        if (![textView.text isEqualToString:@""]) {
            mainText = [textView.text substringToIndex:[textView.text length] - 1];
        }else{
            mainText = textView.text;
        }
    }else{
        mainText = [NSString stringWithFormat:@"%@%@",textView.text,text];
    }
    
    //最大文本长度
    if (self.wWirteTextMaxNum!=-1&&mainText.length>self.wWirteTextMaxNum) {
        return NO;
    }

    height = [WMZDialogTool heightForTextView:CGSizeMake(textView.contentSize.width , CGFLOAT_MAX) WithText:mainText WithFont:self.wMessageFont];
    
    line = height/self.oneLineHeight.floatValue;
    //最大行数
    if (line>self.wWirteTextMaxLine) {
        height = self.wWirteTextMaxLine*self.oneLineHeight.floatValue;
    }

    if (height==0) {
        height = [WMZDialogTool heightForTextView:CGSizeMake(self.wWidth-self.wMainOffsetX*2, CGFLOAT_MAX) WithText:@"占位" WithFont:self.writeView.font.pointSize];
    }
    frame.size.height = height+22.0;
    [UIView animateWithDuration:0.3 animations:^{
        textView.frame = frame;
        UIView *view =  [self addBottomView:CGRectGetMaxY(self.writeView.frame)+self.wMainOffsetY];
        CGRect rect = self.mainView.frame;
        rect.size.height = CGRectGetMaxY(view.frame);
        rect.origin.y = Device_Dialog_Height-(self.keyBoardHeight+rect.size.height+0.5+self.wKeyBoardMarginY);
        
        self.mainView.frame = rect;
    } completion:nil];
    
//    if (self.wEventFinish) {
//        self.wEventFinish(mainText,self.wType);
//    }
    return YES;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
/*
 *确定的点击事件
 */
- (void)writeOKAction:(UIButton*)btn{
    [self.writeView resignFirstResponder];
    [self closeView];
    if (self.wEventOKFinish) {
        self.wEventOKFinish(self.writeView.text,nil);
    }
}
#pragma clang diagnostic pop

- (float)heightForTextView:(CGSize)constraint WithText: (NSString *) strText{
    CGRect size = [strText boundingRectWithSize:constraint
                                        options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                     attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:self.wMessageFont]}
                                        context:nil];
    float textHeight = size.size.height;
    return textHeight;
}


- (void)setWriteView:(UITextView *)writeView{
    objc_setAssociatedObject(self, &writeViewKey, writeView, OBJC_ASSOCIATION_RETAIN);
}

- (UITextView *)writeView{
    
    UITextView* writeView = objc_getAssociatedObject(self, &writeViewKey);
    if (!writeView) {
        writeView = [UITextView new];
        writeView.delegate = self;
        writeView.layer.borderWidth = 1.0f;
        writeView.layer.cornerRadius = 5;
        writeView.keyboardType = self.wWirteKeyBoardType;
        writeView.layer.masksToBounds = YES;
        [writeView becomeFirstResponder];
        writeView.font = [UIFont systemFontOfSize:self.wMessageFont];
        writeView.layer.borderColor = DialogColor(0xeeeeee).CGColor;
        objc_setAssociatedObject(self, &writeViewKey, writeView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return writeView;
}

- (NSNumber*)oneLineHeight{
    return  objc_getAssociatedObject(self, &oneLineHeightKey);
}

- (void)setOneLineHeight:(NSNumber*)oneLineHeight{
     objc_setAssociatedObject(self, &oneLineHeightKey, oneLineHeight, OBJC_ASSOCIATION_RETAIN);
}

@end
