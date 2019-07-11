//
//  WMZDiaLogBase.m
//  WMZDialog
//
//  Created by wmz on 2019/6/21.
//  Copyright © 2019年 wmz. All rights reserved.
//

#import "WMZDiaLogBase.h"

@interface WMZDiaLogBase ()
@end

@implementation WMZDiaLogBase

- (BOOL)updateAlertTypeDownProgress:(CGFloat)value{return YES;}
- (void)closeView{}
- (UIView*)addBottomView:(CGFloat)maxY{return [UIView new];}
- (void)reSetMainViewFrame:(CGRect)frame{}
- (void)getDepth:(NSArray*)arr withTree:(WMZTree*)treePoint withDepth:(NSInteger)depth{}
- (id)getMyDataArr:(NSInteger )tableViewTag withType:(NSInteger)type{return @[];}
- (void)selectWithTableView:(UITableView *)tableView withIndexPath:(NSIndexPath*)indexPath{}
- (void)updateMenuChildrenDataWithSection:(NSInteger)section  withUpdateChildren:(BOOL)update withData:(NSArray*)data{}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

- (UILabel *)textLabel{
    if (!_textLabel) {
        _textLabel = [UILabel new];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.numberOfLines = 0;
    }
    return _textLabel;
}

-(UIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _cancelBtn;
}

-(UIButton *)OKBtn{
    if (!_OKBtn) {
        _OKBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _OKBtn;
}

- (UIView *)mainView{
    if (!_mainView) {
        _mainView = [UIView new];
    }
    return _mainView;
}


- (UIView *)shadowView{
    if (!_shadowView) {
        _shadowView = [UIView new];
        _shadowView.frame = self.view.bounds;
    }
    return _shadowView;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView =  [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
    }
    return _tableView;
}

- (UIPickerView *)pickView{
    if (!_pickView) {
        _pickView = [UIPickerView new];
    }
    return _pickView;
}

- (UIButton *)wCloseBtn{
    if (!_wCloseBtn) {
        _wCloseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _wCloseBtn;
}

- (NSMutableArray *)selectArr{
    if (!_selectArr) {
        _selectArr = [NSMutableArray new];
    }
    return _selectArr;
}
@end

@implementation WMZTree
- (instancetype)initWithDetpth:(NSInteger)depth withName:(NSString*)name  withID:(NSString*)ID{
    if (self = [super init]) {
        _depth = depth;
        _name = name;
        _ID = ID;
    }
    return self;
}

- (NSMutableArray<WMZTree *> *)children{
    if (!_children) {
        _children = [NSMutableArray new];
    }
    return _children;
}

@end
