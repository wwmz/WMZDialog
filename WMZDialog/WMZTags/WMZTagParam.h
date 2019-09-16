//
//  WMZTagParam.h
//  WMZTags
//
//  Created by wmz on 2019/5/23.
//  Copyright © 2019年 wmz. All rights reserved.
//

#import "WMZTagsTool.h"
NS_ASSUME_NONNULL_BEGIN

/*
 * 布局
 */
typedef void(^TagConstraint) (MASConstraintMaker *make);

/*
 * 单点
 */
typedef void(^TagClick)(NSInteger index,id model,BOOL isSelected);

/*
 * 多选
 */
typedef void(^TagMoreClick)(NSArray *indexArr,NSArray* modelArr);

/*
 * 关闭
 */
typedef void(^CloseClick)(NSInteger index,id model,NSArray* modelArr);

/*
 * 自定义添加的文本
 */
typedef void(^InsertTextBlock)(NSString *text);

/*
 * 自定义添加的文本和添加后总的数据
 */
typedef void(^InsertTextAndDataBlock)(NSString *text,NSArray* modelArr);

/*
 * 自定义添加
 */
typedef void(^InsertClick)(NSInteger index,id model,InsertTextBlock block);



/*
 *主题色
 */
typedef enum : NSUInteger{
    success = 1,
    info,
    warning,
    danger
}TagColorType;

/*
 *尺寸
 */
typedef enum : NSUInteger{
    medium = 1,
    small,
    mini,
}TagSizeType;


typedef enum :NSInteger{
    TagImagePositionLeft     = 0,            //图片在左，文字在右，默认
    TagImagePositionRight    = 1,            //图片在右，文字在左  
    TagImagePositionTop      = 2,            //图片在上，文字在下
    TagImagePositionBottom   = 3,            //图片在下，文字在上
}TagImagePosition;


typedef enum :NSInteger{
    TagAlignLeft     = 0,            //左对齐
    TagAlignRight    = 1,            //右对齐

}TagAlign;

@interface WMZTagParam : NSObject

/* =========================================Attributes==========================================
 参数                 说明              类型                      可选值                默认值        是否必传
 wFrame              frame布局        CGRect                       —                   -            是（和maronsy二选一）
 wMasonry            masonry布局      TagConstraint                —                   -            是（和wFrame二选一）
 wData               数据源            NSArray                     —                    -           是
 wSelectIndexData    默认选中的数据源(传下标)NSArray                  —                    -           是
 wType               主题             TagColorType    success/info/warning/danger      —            否
 wInsertaBle         是否可增加        Boolean                     _                  false          否
 wClosable           是否可删除        Boolean                     —                  false          否
 wSelectOne          是否可单选        Boolean                     —                  false          否
 wSelectMore         是否可多选        Boolean                     —                  false          否
 wTagAlign           标签对齐模式       TagAlign       TagAlignLeft/TagAlignRight   TagAlignLeft     否
 wHit                是否有边框描边     Boolean                     —                  false          否
 wRadius             圆角             CGFloat                     —              5(最大为高度的一半)   否
 wBoderWidth         边框宽度          CGFloat                     _                    1            否
 wBoderColor         边框颜色          UIColor                     —                  #5297E1        否
 wColor              字体颜色          UIColor                     —                  #5297E1        否
 wBackGroundColor    外部背景色        UIColor                     —                  #ffffff        否
 wInnerColor         内部背景色        UIColor                     —                  #CEE1F7        否
 wSelectBoderColor   选中边框颜色      UIColor                     —                   #ED4985        否
 wSelectColor        选中字体颜色      UIColor                     —                   #ED4985        否
 wSelectInnerColor   选中内部背景色    UIColor                      —                  #F4C4C4        否
 wSize               尺寸             TagSizeType        medium / small / mini         —            否
 wFont               字体大小          CGFloat                   —                      14            否
 marginLeft          外左边距          CGFloat                     _                    5            否
 marginRight         外右边距          CGFloat                     _                    0            否
 marginTop           外上边距          CGFloat                     _                   10            否
 marginBottom        外下边距          CGFloat                     _                   10            否
 paddingLeft         内左边距          CGFloat                     _                   10            否
 paddingTop          内上边距          CGFloat                     _                   10            否
 btnLeft             按钮上边距        CGFloat                      _                   20           否
 btnTop              按钮上边距        CGFloat                      _                   20           否
 btnPaddingLeft      图文间距          CGFloat                     _                    5            否
 textImageName       文本图片          NSString                    _                    _            否
 imageName           纯图片            NSString                    _                    _            否
 selecTextImageName  选中的纯图片       NSString                    _                    _            否
 selectImageName     选中的文本图片     NSString                     _                    _           否
 imagePosition       图文位置         TagImagePosition     top/left/bottom/right       right         否
 wInsertPlaceholder  插入标签提示语     NSString                     _                  +New tag       否
 =========================================Attributes==========================================*/
WMZPropStatementAndPropSetFuncStatement(assign, WMZTagParam, TagColorType,      wType)
WMZPropStatementAndPropSetFuncStatement(assign, WMZTagParam, Boolean,           wClosable)
WMZPropStatementAndPropSetFuncStatement(assign, WMZTagParam, Boolean,           wInsertaBle)
WMZPropStatementAndPropSetFuncStatement(copy,   WMZTagParam, NSString*,         wInsertPlaceholder)
WMZPropStatementAndPropSetFuncStatement(assign, WMZTagParam, Boolean,           wSelectOne)
WMZPropStatementAndPropSetFuncStatement(assign, WMZTagParam, Boolean,           wSelectMore)
WMZPropStatementAndPropSetFuncStatement(assign, WMZTagParam, Boolean,           wHit)
WMZPropStatementAndPropSetFuncStatement(assign, WMZTagParam, TagAlign,          wTagAlign)
WMZPropStatementAndPropSetFuncStatement(assign, WMZTagParam, CGFloat,           wBoderWidth)
WMZPropStatementAndPropSetFuncStatement(assign, WMZTagParam, CGFloat,           wRadius)
WMZPropStatementAndPropSetFuncStatement(strong, WMZTagParam, UIColor*,          wBoderColor)
WMZPropStatementAndPropSetFuncStatement(strong, WMZTagParam, NSArray*,          wData)
WMZPropStatementAndPropSetFuncStatement(strong, WMZTagParam, NSArray*,          wSelectIndexData)
WMZPropStatementAndPropSetFuncStatement(strong, WMZTagParam, UIColor*,          wInnerColor)
WMZPropStatementAndPropSetFuncStatement(strong, WMZTagParam, UIColor*,          wColor)
WMZPropStatementAndPropSetFuncStatement(strong, WMZTagParam, UIColor*,          wSelectBoderColor)
WMZPropStatementAndPropSetFuncStatement(strong, WMZTagParam, UIColor*,          wSelectInnerColor)
WMZPropStatementAndPropSetFuncStatement(strong, WMZTagParam, UIColor*,          wSelectColor)
WMZPropStatementAndPropSetFuncStatement(strong, WMZTagParam, UIColor*,          wBackGroundColor)
WMZPropStatementAndPropSetFuncStatement(assign, WMZTagParam, CGFloat,           wFont)
WMZPropStatementAndPropSetFuncStatement(assign, WMZTagParam, TagSizeType,       wSize)
WMZPropStatementAndPropSetFuncStatement(assign, WMZTagParam, CGRect,            wFrame)
WMZPropStatementAndPropSetFuncStatement(copy,   WMZTagParam, TagConstraint,     wMasonry)
WMZPropStatementAndPropSetFuncStatement(assign, WMZTagParam, CGFloat,           marginLeft)
WMZPropStatementAndPropSetFuncStatement(assign, WMZTagParam, CGFloat,           marginRight)
WMZPropStatementAndPropSetFuncStatement(assign, WMZTagParam, CGFloat,           marginTop)
WMZPropStatementAndPropSetFuncStatement(assign, WMZTagParam, CGFloat,           marginBottom)
WMZPropStatementAndPropSetFuncStatement(assign, WMZTagParam, CGFloat,           paddingLeft)
WMZPropStatementAndPropSetFuncStatement(assign, WMZTagParam, CGFloat,           paddingTop)
WMZPropStatementAndPropSetFuncStatement(assign, WMZTagParam, CGFloat,           btnLeft)
WMZPropStatementAndPropSetFuncStatement(assign, WMZTagParam, CGFloat,           btnTop)
WMZPropStatementAndPropSetFuncStatement(assign, WMZTagParam, CGFloat,           btnPaddingLeft)
WMZPropStatementAndPropSetFuncStatement(assign, WMZTagParam, TagImagePosition,  imagePosition)
WMZPropStatementAndPropSetFuncStatement(copy,   WMZTagParam, NSString*,         textImageName)
WMZPropStatementAndPropSetFuncStatement(copy,   WMZTagParam, NSString*,         selecTextImageName)
WMZPropStatementAndPropSetFuncStatement(copy,   WMZTagParam, NSString*,         imageName)
WMZPropStatementAndPropSetFuncStatement(copy,   WMZTagParam, NSString*,         selectImageName)


/* =========================================Attributes==========================================*/

/* =========================================myProperty==========================================*/
@property(nonatomic,strong,nullable)NSMutableArray *selectBtnArr;
@property(nonatomic,strong)NSIndexPath *path;
@property(nonatomic,strong)NSMutableArray *cancelSelectDefaultBtnArr;
/* =========================================myProperty==========================================*/

/* =========================================Events==============================================*/
WMZTagParam * TagParam(void);
/*
 * 单点的方法
 */
@property(nonatomic,copy,readonly) WMZTagParam *(^wTapClick)(TagClick block);

@property(nonatomic,copy) TagClick tapClick;
/*
 * 多点的方法
 */
@property(nonatomic,copy,readonly) WMZTagParam *(^wMoreTapClick)(TagMoreClick block);

@property(nonatomic,copy) TagMoreClick tagMoreClick;
/*
 * 关闭的方法
 */
@property(nonatomic,copy,readonly) WMZTagParam *(^wCloseClick)(CloseClick block);

@property(nonatomic,copy) CloseClick closeClick;

/*
 * 自定义点击添加后的事件
 */
@property(nonatomic,copy,readonly) WMZTagParam *(^wInsertClick)(InsertClick block);

@property(nonatomic,copy) InsertClick insertClick;


/*
 * 点击添加回调的方法
 */
@property(nonatomic,copy,readonly) WMZTagParam *(^wInsertTextClick)(InsertTextAndDataBlock block);

@property(nonatomic,copy) InsertTextAndDataBlock insertTextClick;

/* =========================================Events==============================================*/

@end

NS_ASSUME_NONNULL_END
