//
//  PresentVC.h
//  WMZDialog
//
//  Created by wmz on 2020/4/10.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "BaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface PresentVC : BaseVC

@end

@interface commentModel : NSObject
@property(nonatomic,strong)NSString *content;
@property(nonatomic,assign)BOOL check;
@end


@interface commentCell : UITableViewCell
@property(nonatomic,strong)commentModel *model;
@property(nonatomic,strong)UIImageView *icon;
@property(nonatomic,strong)UILabel *name;
@property(nonatomic,strong)UILabel *mainText;
@property(nonatomic,strong)UILabel *time;
@property(nonatomic,strong)UIButton *prise;
@end

NS_ASSUME_NONNULL_END
