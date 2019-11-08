//
//  ViewController.h
//  WMZDialog
//
//  Created by wmz on 2019/6/5.
//  Copyright © 2019年 wmz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"

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

@interface ViewController : UIViewController

@end


