
//
//  WMZDialogTableProtocol.h
//  WMZDialog
//
//  Created by wmz on 2021/7/18.
//  Copyright © 2021 wmz. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WMZDialogTableView;
NS_ASSUME_NONNULL_BEGIN

@protocol WMZDialogTableProtocol <NSObject>
/// tableView
@property (nonatomic, strong) WMZDialogTableView *tableView;
/// pickView
@property (nonatomic, strong) UIPickerView *pickView;

@end

NS_ASSUME_NONNULL_END
