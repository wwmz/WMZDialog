//
//  WMZDiaLogBase.m
//  WMZDialog
//
//  Created by wmz on 2019/6/21.
//  Copyright © 2019年 wmz. All rights reserved.
//

#import "WMZDiaLogBase.h"

@interface WMZDiaLogBase ()<CAAnimationDelegate>
@end

@implementation WMZDiaLogBase


- (void)dealAnamtionShowWithView:(UIView*)view withType:(DialogShowAnination)type withTime:(NSTimeInterval)time block:(animalBlock)block{
    WMZDialogAnimation *animal = [WMZDialogAnimation new];
    if (type == AninatonCurverOn) {
        [animal curverOnAnimationWithView:view duration:time];
    }else if (type == AninatonZoomIn) {
        [animal zoomInAnimationWithView:view duration:time];
    }else if (type == AninatonCounterclockwise) {
        [animal rotationClockwiseAnimationWithView:view duration:time];
    }else if (type == AninationCombineOne) {
        [animal combineShowOneAnimationWithView:view duration:time];
    }else if (type == AninationCombineTwo) {
        [animal combineShowTwoAnimationWithView:view duration:time];
    }else if (type == AninatonShowTop) {
        [animal verticalMoveShowAnimationWithView:view duration:time top:YES];
    }else if (type == AninatonShowBottom) {
        [animal verticalMoveShowAnimationWithView:view duration:time top:NO];
    }else if (type == AninatonShowLeft) {
        [animal landscapeMoveShowAnimationWithView:view duration:time right:NO];
    }else if (type == AninatonShowRight) {
        [animal landscapeMoveShowAnimationWithView:view duration:time right:YES];
    }
    if (block) {
        animal.block = ^{
            block();
        };
    }
}

- (void)dealAnamtionHideWithView:(UIView*)view withType:(DialogHideAnination)type withTime:(NSTimeInterval)time block:(animalBlock)block{
    WMZDialogAnimation *animal = [WMZDialogAnimation new];
    if (type == AninatonCurverOff) {
        [animal curverOffAnimationWithView:view duration:time];
    }else if (type == AninatonZoomOut) {
        [animal zoomOutAnimationWithView:view duration:time];
    }else if (type == AninatonClockwise) {
        [animal rotationCounterclockwiseAnimationWithView:view duration:time];
    }else if (type == AninationHideCombineOne) {
        [animal combineHideOneAnimationWithView:view duration:time];
    }else if (type == AninatonHideTop) {
        [animal verticalMoveHideAnimationWithView:view duration:time top:YES];
    }else if (type == AninatonHideBottom) {
        [animal verticalMoveHideAnimationWithView:view duration:time top:NO];
    }else if (type == AninatonHideLeft) {
        [animal landscapeMoveHideAnimationWithView:view duration:time right:NO];
    }else if (type == AninatonHideRight) {
        [animal landscapeMoveHideAnimationWithView:view duration:time right:YES];
    }
    if (block) {
        animal.block = ^{
            block();
        };
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
- (BOOL)updateAlertTypeDownProgress:(CGFloat)value{return YES;}
- (void)closeView{}
- (void)closeView:(nullable animalBlock)block{}
- (UIView*)addBottomView:(CGFloat)maxY{return [UIView new];}
- (void)reSetMainViewFrame:(CGRect)frame{};
- (void)getDepth:(NSArray*)arr withTree:(WMZTree*)treePoint withDepth:(NSInteger)depth{}
- (void)selectWithTableView:(UITableView *)tableView withIndexPath:(NSIndexPath*)indexPath{}
- (void)updateMenuChildrenDataWithSection:(NSInteger)section  withUpdateChildren:(BOOL)update withData:(NSArray*)data{}
- (UIView*)addTopView{return [UIView new];}
- (void)scrollToToday{};
- (void)showView:(nullable UIView*)showView{};
- (id)getMyDataArr:(NSInteger )tableViewTag withType:(NSInteger)type{return  nil;}


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
    }
    return _shadowView;
}

- (WMZDialogTableView *)tableView{
    if (!_tableView) {
        _tableView =  [[WMZDialogTableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.scrollsToTop = NO;
        [_tableView setSeparatorColor:DialogLineColor];
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
        _effectView.frame = self.bounds;
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

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray new];
    }
    return _dataArr;
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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

@implementation DialogCell
@end
