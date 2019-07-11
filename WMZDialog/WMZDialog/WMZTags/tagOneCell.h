//
//  tagOneCell.h
//  WMZTags
//
//  Created by wmz on 2019/5/29.
//  Copyright © 2019年 wmz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WMZTags.h"
NS_ASSUME_NONNULL_BEGIN

@protocol WMZTagDelegate <NSObject>

@optional //非必实现的方法
//用于外部刷新
-(void)updateCell:(id)cell data:(NSArray*)data;
@end


@interface moneyCell : UITableViewCell

@end

@interface tagOneCell : UITableViewCell
//数据
@property(nonatomic,strong)id model;
//代理
@property(nonatomic,weak)id<WMZTagDelegate> delegate;
//model
@property(nonatomic,strong)WMZTagParam* param;

@property(nonatomic,assign)NSInteger row;
//用于n内部刷新
- (void)updateInnerData:(WMZTagParam*)param;
@end

NS_ASSUME_NONNULL_END
