//
//  WMZDialogShareView.h
//  WMZDialog
//
//  Created by wmz on 2019/9/12.
//  Copyright © 2019 wmz. All rights reserved.
//

#import <UIKit/UIKit.h>
#define percentImage 0.5
NS_ASSUME_NONNULL_BEGIN

typedef void (^shareViewSelect)(NSInteger index,id anyId);

@interface WMZDialogShareView : UIView

@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UILabel *la;

- (instancetype)initWithText:(NSString*)text withImage:(NSString*)image withBlock:(shareViewSelect)block withTag:(NSInteger)tag;
@end

NS_ASSUME_NONNULL_END
