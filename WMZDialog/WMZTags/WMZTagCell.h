//
//  WMZTagCell.h
//  WMZTags
//
//  Created by wmz on 2019/8/26.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "WMZTags.h"
NS_ASSUME_NONNULL_BEGIN
@protocol WMZTagDelegate <NSObject>

@optional //非必实现的方法
//用于外部刷新
-(void)updateCell:(id)cell data:(NSArray*)data;
@end

@interface WMZTagCell : UITableViewCell
//数据
@property(nonatomic,strong)NSArray *model;
//代理
@property(nonatomic,weak)id<WMZTagDelegate> delegate;
//model
@property(nonatomic,strong)WMZTagParam* param;
//tag
@property(nonatomic,strong)WMZTags *myTag;

@end

NS_ASSUME_NONNULL_END
