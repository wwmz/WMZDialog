
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
    
    if (self.wWirteTextMaxLine<=0) {
        self.wWirteTextMaxLine = 7;
    }
    [self.mainView addSubview:self.titleLabel];
    self.titleLabel.frame = CGRectMake(self.wMainOffsetX, self.wTitle.length?self.wMainOffsetY:0, self.wWidth-self.wMainOffsetX*2, [WMZDialogTool sizeForTextView:CGSizeMake(self.wWidth-self.wMainOffsetX*2, CGFLOAT_MAX) text:self.titleLabel.text font:self.titleLabel.font.pointSize].height);
    
    [self.mainView addSubview:self.textLabel];
    self.textLabel.frame =  CGRectMake(self.wMainOffsetX,CGRectGetMaxY(self.titleLabel.frame)+ ( self.wMessage.length?self.wMainOffsetY:0), self.wWidth-self.wMainOffsetX*2, [WMZDialogTool sizeForTextView:CGSizeMake(self.wWidth-self.wMainOffsetX*2, CGFLOAT_MAX) text:self.textLabel.text font:self.textLabel.font.pointSize].height);
    
    
    [self.mainView addSubview:self.writeView];
    self.writeView.frame = CGRectMake(self.wMainOffsetX,CGRectGetMaxY(self.textLabel.frame)+self.wMainOffsetY, self.wWidth-self.wMainOffsetX*2, [WMZDialogTool sizeForTextView:CGSizeMake(self.wWidth-self.wMainOffsetX*2, CGFLOAT_MAX) text:self.wWriteDefaultText?:@"占位" font:self.writeView.font.pointSize].height+22.0);
    if (self.wWriteDefaultText) {
        self.writeView.text = self.wWriteDefaultText;
    }
    
    self.oneLineHeight = @([self sizeForTextView:CGSizeMake(self.writeView.contentSize.width , CGFLOAT_MAX) WithText:@"测试"]);
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(3, 4, self.wWidth-self.wMainOffsetX*2-6, [WMZDialogTool sizeForTextView:CGSizeMake(self.wWidth-self.wMainOffsetX*2, CGFLOAT_MAX) text:@"占位" font:self.writeView.font.pointSize].height+10)];
    label.enabled = NO;
    label.tag = 999;
    label.text = self.wPlaceholder;
    label.font =  [UIFont systemFontOfSize:self.wMessageFont];
    label.textColor = [UIColor lightGrayColor];
    [self.writeView addSubview:label];
    label.hidden = (self.wWriteDefaultText&&[self.wWriteDefaultText isKindOfClass:[NSString class]]&&self.wWriteDefaultText.length)?YES:NO;

    UIView *view =  [self addBottomView:CGRectGetMaxY(self.writeView.frame)+self.wMainOffsetY];
    [self.OKBtn removeTarget:self action:NSSelectorFromString(@"OKAction:") forControlEvents:UIControlEventTouchUpInside];
    [self.OKBtn addTarget:self action:@selector(writeOKAction:) forControlEvents:UIControlEventTouchUpInside];
    if (self.wCustomTextView) {
        self.wCustomTextView(self.writeView);
    }
    [self reSetMainViewFrame:CGRectMake(0, 0, self.wWidth, CGRectGetMaxY(view.frame))];
    
    return self.mainView;
}

- (void)textViewDidChange:(UITextView *)textView{
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
    
    float fPadding = 10;
    CGSize constraint = CGSizeMake(textView.contentSize.width - fPadding, CGFLOAT_MAX);
    height = [WMZDialogTool sizeForTextView:constraint text:mainText font:self.writeView.font.pointSize].height+22.0;
    
    if (!mainText.length) {
        height =  [WMZDialogTool sizeForTextView:CGSizeMake(self.wWidth-self.wMainOffsetX*2, CGFLOAT_MAX) text:@"占位" font:self.writeView.font.pointSize].height+22.0;
    }

    line = (height-22.0)/self.oneLineHeight.floatValue;
    if (self.wWirteTextMaxLine == 1) {
        if ([text isEqualToString:@"\n"]||line>1) {
            [textView resignFirstResponder];
            [self writeOKAction:nil];
            return NO;
        }
    }
    //最大行数
    if (line>self.wWirteTextMaxLine) {
        height = self.wWirteTextMaxLine*self.oneLineHeight.floatValue+22.0;
    }
    
    frame.size.height = height;
    [UIView animateWithDuration:0.3 animations:^{
        textView.frame = frame;
        UIView *view =  [self addBottomView:CGRectGetMaxY(self.writeView.frame)+self.wMainOffsetY];
        CGRect rect = self.mainView.frame;
        rect.size.height = CGRectGetMaxY(view.frame);
        rect.origin.y = Device_Dialog_Height-(self.keyBoardHeight+rect.size.height+0.5+self.wKeyBoardMarginY);
        self.mainView.frame = rect;
    } completion:nil];
    return YES;
}

//点击Return键键盘退出
- (void)textViewDidEndEditing:(UITextView *)textView {
    if (textView == self.writeView) {
        if (self.wWirteTextMaxLine == 1) {
            [self.writeView resignFirstResponder];
            [self closeView];
        }
    }
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
/*
 *确定的点击事件
 */
- (void)writeOKAction:(UIButton*)btn{
    [self.writeView resignFirstResponder];
    DialogWeakSelf(self)
    [self closeView:^{
        if (weakObject.wEventOKFinish) {
            weakObject.wEventOKFinish(weakObject.writeView.text,nil);
        }
    }];
}
#pragma clang diagnostic pop

- (float)sizeForTextView:(CGSize)constraint WithText: (NSString *) strText{
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
        if (self.wWirteTextMaxLine == 1) {
            writeView.returnKeyType = UIReturnKeyDone;
        } else {
            writeView.returnKeyType = UIReturnKeyDefault;
        }
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
