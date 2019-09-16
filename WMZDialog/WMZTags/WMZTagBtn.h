//
//  WMZTagBtn.h
//  WMZTags
//
//  Created by wmz on 2019/5/24.
//  Copyright © 2019年 wmz. All rights reserved.
//

#import "WMZTagParam.h"
#import "WMZTagsTool.h"
NS_ASSUME_NONNULL_BEGIN

/*
 *按钮样式
 */
typedef enum : NSUInteger{
    BtnNormal = 0,
    BtnInsert,
}BtnType;

@interface WMZTagBtn : UIButton

//最大size
@property(nonatomic,assign)CGSize maxSize;
//是否超出最大宽度
@property(nonatomic,assign)BOOL max;
//行数
@property(nonatomic,assign)NSInteger lineCount;
//一行的高度
@property(nonatomic,assign)CGFloat oneLineHeight;
//最大宽度
@property(nonatomic,assign)CGFloat maxWidth;
//文本
@property(nonatomic,copy)NSString *text;
//type
@property(nonatomic,assign)BtnType type;

+ (instancetype)buttonWithType:(UIButtonType)buttonType
                     WithParam:(WMZTagParam*)param
                       withTag:(NSInteger)tag
                      withText:(NSString*)text
                       BtnType:(BtnType)type;

/**
 *  设置按钮样式
 */
- (void)setUpBtnStyle;

/**
 *  设置按钮UI
 */
- (void)setUI;
/**
 * 定制大小
 */
- (void)setSize;

@end

@interface WMZTagBtn (TagImagePosition)

/**
 *  利用UIButton的titleEdgeInsets和imageEdgeInsets来实现文字和图片的自由排列
 *  注意：这个方法需要在设置图片和文字之后才可以调用，且button的大小要大于 图片大小+文字大小+spacing
 *
 *  @param spacing 图片和文字的间隔
 */
- (void)TagSetImagePosition:(TagImagePosition)postion spacing:(CGFloat)spacing;

@end

NS_ASSUME_NONNULL_END
