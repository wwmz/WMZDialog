

//
//  WMZTagParam.m
//  WMZTags
//
//  Created by wmz on 2019/5/23.
//  Copyright © 2019年 wmz. All rights reserved.
//

#import "WMZTagParam.h"
@implementation WMZTagParam

WMZPropSetFuncImplementation(WMZTagParam, TagColorType ,    wType)
WMZPropSetFuncImplementation(WMZTagParam, Boolean ,         wClosable)
WMZPropSetFuncImplementation(WMZTagParam, Boolean,          wInsertaBle)
WMZPropSetFuncImplementation(WMZTagParam, NSString*,        wInsertPlaceholder)
WMZPropSetFuncImplementation(WMZTagParam, Boolean,          wSelectOne)
WMZPropSetFuncImplementation(WMZTagParam, Boolean,          wSelectMore)
WMZPropSetFuncImplementation(WMZTagParam, TagAlign,         wTagAlign)
WMZPropSetFuncImplementation(WMZTagParam, Boolean ,         wHit)
WMZPropSetFuncImplementation(WMZTagParam, CGFloat,          wRadius)
WMZPropSetFuncImplementation(WMZTagParam, CGFloat,          wBoderWidth)
WMZPropSetFuncImplementation(WMZTagParam, UIColor*,         wBoderColor)
WMZPropSetFuncImplementation(WMZTagParam, UIColor* ,        wColor)
WMZPropSetFuncImplementation(WMZTagParam, UIColor* ,        wInnerColor)
WMZPropSetFuncImplementation(WMZTagParam, UIColor*,         wSelectBoderColor)
WMZPropSetFuncImplementation(WMZTagParam, UIColor*,         wSelectInnerColor)
WMZPropSetFuncImplementation(WMZTagParam, UIColor*,         wSelectColor)
WMZPropSetFuncImplementation(WMZTagParam, UIColor* ,        wBackGroundColor)
WMZPropSetFuncImplementation(WMZTagParam, CGFloat ,         wFont)
WMZPropSetFuncImplementation(WMZTagParam, NSArray*,         wData)
WMZPropSetFuncImplementation(WMZTagParam, NSArray*,         wSelectIndexData)
WMZPropSetFuncImplementation(WMZTagParam, TagSizeType ,     wSize)
WMZPropSetFuncImplementation(WMZTagParam, CGRect,           wFrame)
WMZPropSetFuncImplementation(WMZTagParam, TagConstraint,    wMasonry)
WMZPropSetFuncImplementation(WMZTagParam, CGFloat,          marginLeft)
WMZPropSetFuncImplementation(WMZTagParam, CGFloat,          marginRight)
WMZPropSetFuncImplementation(WMZTagParam, CGFloat,          marginTop)
WMZPropSetFuncImplementation(WMZTagParam, CGFloat,          marginBottom)
WMZPropSetFuncImplementation(WMZTagParam, CGFloat,          paddingLeft)
WMZPropSetFuncImplementation(WMZTagParam, CGFloat,          paddingTop)
WMZPropSetFuncImplementation(WMZTagParam, CGFloat,          btnLeft)
WMZPropSetFuncImplementation(WMZTagParam, CGFloat,          btnTop)
WMZPropSetFuncImplementation(WMZTagParam, CGFloat,          btnPaddingLeft)
WMZPropSetFuncImplementation(WMZTagParam, TagImagePosition, imagePosition)
WMZPropSetFuncImplementation(WMZTagParam, NSString*,        textImageName)
WMZPropSetFuncImplementation(WMZTagParam, NSString*,        imageName)
WMZPropSetFuncImplementation(WMZTagParam, NSString*,        selecTextImageName)
WMZPropSetFuncImplementation(WMZTagParam, NSString*,        selectImageName)

- (instancetype)init{
    if (self = [super init]) {
        _wFont = 14;
        _marginTop = 10;
        _marginLeft = 10;
        _marginBottom = 10;
        _marginRight = 10;
        _paddingTop = 10;
        _paddingLeft = 10;
        _btnTop = 30;
        _btnLeft = 30;
        _btnPaddingLeft = 5;
        _wColor = MColor;
        _wInnerColor = MInnerColor;
        _imagePosition = TagImagePositionRight;
        _wBoderColor = MBoderColor;
        _wBackGroundColor = [WMZTagsTool stringTOColor:@"#eeeeee"];
        _wBoderWidth = 1;
        _wRadius = 5;
        _wInsertPlaceholder = MInsertPlaceholder;
        _wSelectBoderColor = MSelectBoderColor;
        _wSelectColor = MSelectColor;
        _wSelectInnerColor = MSelectInnerColor;
    }
    return self;
}


- (NSMutableArray *)selectBtnArr{
    if (!_selectBtnArr) {
        _selectBtnArr = [NSMutableArray new];
    }
    return _selectBtnArr;
}

- (NSMutableArray *)cancelSelectDefaultBtnArr{
    if (!_cancelSelectDefaultBtnArr) {
        _cancelSelectDefaultBtnArr = [NSMutableArray new];
    }
    return _cancelSelectDefaultBtnArr;
}

WMZTagParam * TagParam(void){
    return  [WMZTagParam new];
}

- (WMZTagParam *(^)(TagClick))wTapClick{
    return ^WMZTagParam*(TagClick wTapClick){
        self.tapClick = wTapClick;
        return self;
    };
}

- (WMZTagParam *(^)(TagMoreClick))wMoreTapClick{
    return ^WMZTagParam*(TagMoreClick wMoreTapClick){
        self.tagMoreClick  = wMoreTapClick;
        return self;
    };
}

- (WMZTagParam *(^)(CloseClick))wCloseClick{
    return ^WMZTagParam*(CloseClick wCloseClick){
        self.closeClick = wCloseClick;
        return self;
    };
}

- (WMZTagParam *(^)(InsertClick))wInsertClick{
    return ^WMZTagParam*(InsertClick wCloseClick){
        self.insertClick = wCloseClick;
        return self;
    };
}

- (WMZTagParam *(^)(InsertTextAndDataBlock))wInsertTextClick{
    return ^WMZTagParam*(InsertTextAndDataBlock wInsertTextClick){
        self.insertTextClick = wInsertTextClick;
        return self;
    };
}

@end
