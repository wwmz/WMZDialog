//
//  WMZDialogDateView.h
//  WMZDialog
//
//  Created by wmz on 2021/7/28.
//  Copyright © 2021 wmz. All rights reserved.
//

#import "WMZDialogTable.h"

NS_ASSUME_NONNULL_BEGIN

@interface WMZDialogCollectionCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *dateLable;

@property (nonatomic, strong) UILabel *chineseLable;

@property (nonatomic, strong) UILabel *circleLabel;

@end

@interface WMZDialogCollectionNormalCell : UICollectionViewCell

@property (nonatomic,strong) UILabel *dateLable;

@property (nonatomic,strong) UILabel *circleLabel;

@end


@interface WMZDialogCalanderCell : WMZDialogCollectionCell

@end


@interface WMZDialogDateView : WMZDialogTable

@end

NS_ASSUME_NONNULL_END
