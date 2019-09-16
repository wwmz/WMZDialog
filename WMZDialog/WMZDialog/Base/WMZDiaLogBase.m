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
- (void)reSetMainViewFrame:(CGRect)frame{};
- (void)getDepth:(NSArray*)arr withTree:(WMZTree*)treePoint withDepth:(NSInteger)depth{}
- (void)selectWithTableView:(UITableView *)tableView withIndexPath:(NSIndexPath*)indexPath{}
- (void)updateMenuChildrenDataWithSection:(NSInteger)section  withUpdateChildren:(BOOL)update withData:(NSArray*)data{}

- (void)dealAnamtionShowWithView:(UIView*)view withType:(DialogShowAnination)type withTime:(NSTimeInterval)time{

//    if (type == AninatonShaker) {
//        shakerAnimation(view, time, 20);
//    }else
    if (type == AninatonCurverOn) {
        curverOnAnimation(view, time);
    }else if (type == AninatonZoomIn) {
        zoomInAnimation(view, time);
    }else if (type == AninatonCounterclockwise) {
        rotationClockwiseAnimation(view, time);
    }else if (type == AninationCombineOne) {
        combineShowOneAnimation(view, time);
    }else if (type == AninationCombineTwo) {
        combineShowTwoAnimation(view, time);
    }
}

- (void)dealAnamtionHideWithView:(UIView*)view withType:(DialogHideAnination)type withTime:(NSTimeInterval)time{
    if (type == AninatonCurverOff) {
        curverOffAnimation(view, time);
    }else if (type == AninatonZoomOut) {
        zoomOutAnimation(view, time);
    }else if (type == AninatonClockwise) {
        rotationCounterclockwiseAnimation(view, time);
    }else if (type == AninationHideCombineOne) {
        combineHideOneAnimation(view, time);
    }
}


//数据处理  type 1返回tree对象
- (id)getMyDataArr:(NSInteger )tableViewTag withType:(NSInteger)type{
    if (tableViewTag==100) {
        return type?self.tree:self.tree.children;
    }else{
        NSInteger taNum = 100;
        WMZTree *resultDic = nil;
        while (taNum < tableViewTag) {
            NSMutableArray *arr = (taNum == 100?self.tree.children:resultDic.children);
            int selectLastIndex = 0;
            for (int i = 0; i<arr.count; i++) {
                WMZTree *tree = arr[i];
                if (tree.isSelected) {
                    selectLastIndex = i;
                    break;
                }
            }
            resultDic = arr[selectLastIndex];
            taNum++;
        }
        return  type?resultDic:resultDic.children;
    }
}

//获取tree选中的数据
- (NSArray*)getTreeSelectDataArr:(BOOL)first{
    self.selectArr = [NSMutableArray new];
    WMZTree *forTree = self.tree;
    
    while (forTree.children.count) {
        forTree = [self getTreeData:forTree first:first];
        if (forTree) {
            [self.selectArr addObject:forTree];
        }
    }
    
    return self.selectArr;
}


- (WMZTree*)getTreeData:(WMZTree*)tree first:(BOOL)first{
    WMZTree *firstSelectTree = nil;
    for (int i = 0; i<tree.children.count; i++) {
        WMZTree *sonTree = tree.children[i];
        //默认第一个
        if (i == 0) {
            firstSelectTree = sonTree;
        }
        if (sonTree.isSelected) {
            firstSelectTree = sonTree;
            break;
        }
    }
    return firstSelectTree;
}

- (NSArray*)timeDayWithArr:(NSArray*)arr withName:(NSString*)name {
    NSInteger day = 0 ;
    NSMutableArray *dayArr = [NSMutableArray new];
    if (!arr||arr.count<1) {
        //数据不规范的当做30天处理
        day = 30;
    }else{
        NSString *year = arr[0];
        NSString *month = arr[1];
        BOOL isLeapYear = false;
        NSInteger yearInfo = year.integerValue;
        if((yearInfo % 400 == 0) || ((yearInfo % 4 == 0) && (yearInfo % 100 != 0))){
            isLeapYear = true ;
        }
        
        NSArray *dayCountArr = @[@"31",isLeapYear?@"29":@"28",@"31",@"30",@"31",@"30",@"31",@"31",@"30",@"31",@"30",@"31"];
        day = [dayCountArr[month.integerValue-1] integerValue];
        
    }
    
    for (int i = 1; i< day+1;i++ ) {
        [dayArr addObject:[NSString stringWithFormat:@"%d%@",i,name]];
    }
    return [NSArray arrayWithArray:dayArr];
}

- (NSBundle *)dialogBundle{
    if (!_dialogBundle) {
        _dialogBundle = [NSBundle bundleWithPath:[[NSBundle bundleForClass:[WMZDiaLogBase class]] pathForResource:@"WMZDialog" ofType:@"bundle"]];
        
    }
    return _dialogBundle;
}

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

- (UIVisualEffectView *)effectView{
    if (!_effectView) {
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        _effectView= [[UIVisualEffectView alloc] initWithEffect:effect];
        _effectView.frame = self.view.bounds;
    }
    return _effectView;
}

- (NSMutableArray *)selectArr{
    if (!_selectArr) {
        _selectArr = [NSMutableArray new];
    }
    return _selectArr;
}

- (NSMutableArray *)pathArr{
    if (!_pathArr) {
        _pathArr = [NSMutableArray new];
    }
    return _pathArr;
}

- (NSMutableArray *)tempArr{
    if (!_tempArr) {
        _tempArr = [NSMutableArray new];
    }
    return _tempArr;
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
