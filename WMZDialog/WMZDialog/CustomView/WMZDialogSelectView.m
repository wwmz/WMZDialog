//
//  WMZDialogSelectView.m
//  WMZDialog
//
//  Created by wmz on 2021/7/21.
//  Copyright © 2021 wmz. All rights reserved.
//

#import "WMZDialogSelectView.h"
#import "WMZDialog.h"
@interface WMZDialogSelectView()
/// pop点击的frame 如果pop位置不准确可以改变此
@property (nonatomic, assign) CGRect tapRect;
/// 最后的位置
@property (nonatomic, assign) CGRect finalRect;
/// 加锁
@property (nonatomic, strong) NSConditionLock *theLock;
/// 中心点
@property (nonatomic, assign) CGPoint normalPoint;

@end

@implementation WMZDialogSelectView

- (void)mz_setupView{
    if (!self.param) return;
    switch (self.param.wType) {
            
#pragma -mark DialogTypeSelect
        case DialogTypeSelect:{
            NSArray *dataArr = (NSArray*)self.param.wData;
            if (!DialogIsArray(dataArr)) {
                NSLog(@"Please Input Array"); return;
            }
            CGFloat top = [self addTopTitleView];
            [self addSubview:self.tableView];
            self.tableView.frame = CGRectMake(0, top + (top ? self.param.wMainOffsetY : 0), self.param.wWidth, self.param.wCellHeight * MIN(self.param.wListScrollCount, dataArr.count));
            if (self.param.wAddBottomView ||
               self.param.wMultipleSelection) {
               [self addBottomView:CGRectGetMaxY(self.tableView.frame)];
            }
        }
            break;
            
#pragma -mark DialogTypeSheet
        case DialogTypeSheet:{
            NSArray *dataArr = (NSArray*)self.param.wData;
            if (!DialogIsArray(dataArr)) {
                NSLog(@"Please Input Array"); return;
            }
            if (!self.param.wBottomLineColor) self.param.wBottomLineColor = self.param.wLineColor;
            if (self.param.wMultipleSelection) {
                [self addTopView];
            }else{
                if (DialogStrIsNotEmpty(self.param.wTitle)) {
                    [self addSubview:self.titleLabel];
                    self.titleLabel.frame = CGRectMake(self.param.wMainOffsetX,self.param.wTitle ? self.param.wMainOffsetY:0, self.param.wWidth-self.param.wMainOffsetX * 2, [WMZDialogUntils sizeForTextView:CGSizeMake(self.param.wWidth - self.param.wMainOffsetX * 2, CGFLOAT_MAX) text:self.param.wTitle font:self.titleLabel.font].height);
                }
            }
            self.tableView.frame = CGRectMake(0, self.param.wMultipleSelection?CGRectGetMaxY(self.headView.frame) : (DialogStrIsNotEmpty(self.param.wTitle) ? (CGRectGetMaxY(self.titleLabel.frame) + self.param.wMainOffsetY) : 0), self.param.wWidth, self.param.wCellHeight * MIN(self.param.wListScrollCount, dataArr.count));
            [self addSubview:self.tableView];
              
            if (!self.param.wMultipleSelection || self.param.wEventCancelFinish) {
                if (DialogStrIsNotEmpty(self.param.wCancelTitle)) {
                    UIView *emptyView =  [UIView new];
                    emptyView.backgroundColor =  self.param.wBottomLineColor;
                    emptyView.frame = CGRectMake(0, CGRectGetMaxY(self.tableView.frame), self.param.wWidth, DialogRealW(10));
                    [self addSubview:emptyView];
                      
                    [self addSubview:self.cancelBtn];
                    self.cancelBtn.frame = CGRectMake(0, CGRectGetMaxY(emptyView.frame), self.param.wWidth, self.param.wMainBtnHeight);
                    self.cancelBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
                }
            }
         }
            break;
            
#pragma -mark DialogTypePop
        case DialogTypePop:{
            NSArray *dataArr = (NSArray*)self.param.wData;
            if (!DialogIsArray(dataArr) && self.param.wPopStyleType != DialogPopTypeCustom) {
                NSLog(@"Please Input Array"); return;
            }
            [self.param.wTapView setNeedsLayout];
            [self.param.wTapView layoutIfNeeded];
            self.tapRect = self.param.wTapView.frame;
            UIScrollView *popInScrollView = nil;
            if (self.param.wTapView) {
                if (self.param.wTapViewType == DiaPopInViewNormal) {
                   [self dealNested:@"UIViewControllerWrapperView"];
                }
                 /// 获取导航栏的真实frame
                if (self.param.wTapViewType == DiaPopInViewNavi||
                    self.param.wNavigationItem) {
                    self.tapRect = [[WMZDialogUntils getCurrentVC].navigationController.view convertRect:self.param.wTapView.frame fromView:self.param.wTapView.superview];
                }
                if (self.param.wTapViewType == DiaPopInViewTableView ||
                    self.param.wTapViewType == DiaPopInViewCollectionView ||
                    self.param.wTapViewType == DiaPopInViewScrollView) {
                    UIView *otherView = nil;
                    UIScrollView *ta = nil;
                    NSMutableArray *arr = [NSMutableArray new];
                    [arr addObject:self.param.wTapView];
                    while (arr.count) {
                       UIView *view = arr.lastObject;
                       [arr removeLastObject];
                       if ([view isKindOfClass:[UITableViewCell class]] && !otherView) otherView = (UITableViewCell*)view;
                       if ([view isKindOfClass:[UICollectionViewCell class]] && !otherView) otherView = (UICollectionViewCell*)view;
                       if ([view isKindOfClass:[UICollectionReusableView class]] && !otherView) otherView = (UICollectionReusableView*)view;
                       if ([view isKindOfClass:[UITableView class]] && !ta) ta = (UITableView*)view;
                       if ([view isKindOfClass:[UICollectionView class]] && !ta) ta = (UICollectionView*)view;
                       if ([view isKindOfClass:[UIScrollView class]] && !ta) ta = (UIScrollView*)view;
                       if (view.superview) [arr addObject:view.superview];
                     }
                     
                     if (ta) {
                         popInScrollView = ta;
                         [popInScrollView layoutIfNeeded];
                         [popInScrollView layoutSubviews];
                         CGRect rectInTableView = CGRectZero;
                         CGRect rect = CGRectZero;
                        if ([ta isKindOfClass:[UITableView class]]) {
                            [self dealNested:@"UITableView"];
                            if (otherView&&[otherView isKindOfClass:[UITableViewCell class]]){
                                NSIndexPath *indexPath = [(UITableView*)popInScrollView indexPathForCell:(UITableViewCell*)otherView];
                                 rectInTableView = [(UITableView*)popInScrollView rectForRowAtIndexPath:indexPath];
                                 if (![self.param.wTapView isKindOfClass:[UITableViewCell class]]) {
                                     rectInTableView.origin.x = self.tapRect.origin.x;
                                     rectInTableView.origin.y += self.tapRect.origin.y;
                                     rectInTableView.size = self.tapRect.size;
                                 }
                            }else if([self.param.wTapView.superview isKindOfClass:[UITableView class]]){
                                 rectInTableView = self.tapRect;
                            }else{
                                 if (self.param.wTapViewTableViewFoot) {
                                     rectInTableView = [(UITableView*)popInScrollView rectForFooterInSection:self.param.wTableViewSectionHead];
                                 }else{
                                     rectInTableView = [(UITableView*)popInScrollView rectForHeaderInSection:self.param.wTableViewSectionHead];
                                 }
                                                  
                                 if (![self.param.wTapView.superview isKindOfClass:[UITableView class]]) {
                                     rectInTableView.origin.x = self.tapRect.origin.x;
                                     rectInTableView.origin.y += self.tapRect.origin.y;
                                     rectInTableView.size = self.tapRect.size;
                                 }
                            }
                             rect = [popInScrollView convertRect:rectInTableView toView:[popInScrollView superview]];
                         }else if ([ta isKindOfClass:[UICollectionView class]]){
                             [self dealNested:@"UICollectionView"];
                             if ([otherView isKindOfClass:[UICollectionViewCell class]]) {
                                 NSIndexPath *indexPath = [(UICollectionView*)popInScrollView indexPathForCell:(UICollectionViewCell*)otherView];
                                 UICollectionViewLayoutAttributes*attributes = [(UICollectionView*)popInScrollView layoutAttributesForItemAtIndexPath:indexPath];
                                 rectInTableView = attributes.frame;
                                 
                                 if (![self.param.wTapView isKindOfClass:[UICollectionViewCell class]]) {
                                     rectInTableView.origin.x += self.tapRect.origin.x;
                                     rectInTableView.origin.y += self.tapRect.origin.y;
                                     rectInTableView.size = self.tapRect.size;
                                 }
                             }else if([self.param.wTapView.superview isKindOfClass:[UICollectionView class]]){
                                 rectInTableView = self.tapRect;
                             }else{
                                 rectInTableView = otherView.frame;
                                 if (![self.param.wTapView.superview isKindOfClass:[UICollectionView class]]) {
                                     rectInTableView.origin.x = self.tapRect.origin.x;
                                     rectInTableView.origin.y += self.tapRect.origin.y;
                                     rectInTableView.size = self.tapRect.size;
                                 }
                             }
                             rect = [popInScrollView convertRect:rectInTableView toView:[popInScrollView superview]];
                         }else if ([ta isKindOfClass:[UIScrollView class]]){
                             [self dealNested:@"UIScrollView"];
                             rectInTableView = self.tapRect;
                             rect = [popInScrollView convertRect:rectInTableView toView:[popInScrollView superview]];
                             
                         }
                         if (popInScrollView.superview.frame.origin.y!=0)
                             rect.origin.y+=popInScrollView.superview.frame.origin.y;
                         self.tapRect = rect;
                    }
                     
                }
            }
            /// 外部传入
            if(!CGRectEqualToRect(self.param.wTapRect, CGRectZero)) {// 两个区域不相等
                self.tapRect = self.param.wTapRect;
            }
            
            
            UIView *contenView = nil;
            if (self.param.wPopStyleType == DialogPopTypeTable) {
                self.tableView.frame = CGRectMake(0, 0, self.param.wWidth, self.param.wCellHeight * MIN(self.param.wListScrollCount, dataArr.count));
                contenView = self.tableView;
            }else if (self.param.wPopStyleType == DialogPopTypeShare) {
                self.shareView.scrollEnabled = NO;
                self.shareView.backgroundColor = UIColor.clearColor;
                @DialogWeakify(self)
                CGFloat itemWidth = self.param.wCellHeight;
                CGFloat itemHeight = self.param.wCellHeight;
                for (int i = 0; i< dataArr.count; i++) {
                    NSDictionary *dic = dataArr[i];
                    NSInteger row = i / self.param.wColumnCount % self.param.wRowCount;
                    NSInteger loc = i % self.param.wColumnCount ;
                    if ([dic isKindOfClass:[NSDictionary class]] ){
                        WMZDialogShareView *iconView = [[WMZDialogShareView alloc] initWithText:dic[@"name"] image:dic[@"image"]  block:^(NSInteger index,id anyId) {
                            @DialogStrongify(self)
                            if (!anyId) return;
                            @DialogWeakify(self)
                            [[WMZDialogManage.shareInstance currentDialog:self] closeView:^{
                                @DialogStrongify(self)
                                if (self.param.wEventFinish)
                                    self.param.wEventFinish(anyId,[NSIndexPath indexPathForRow:index inSection:0], self.param.wType);
                            }];
                            
                        } tag: i + 1000];
                        iconView.model = dic;
                        iconView.changeFrame = YES;
                        iconView.titleLB.textColor = self.param.wMessageColor;
                        iconView.titleLB.font = [UIFont systemFontOfSize:self.param.wMessageFont];
                        iconView.frame = CGRectMake(loc * itemWidth, row * itemHeight, itemWidth, itemHeight);
                        CGFloat percentImage = 0.4;
                        if(DialogStrIsEmpty(dic[@"name"])){
                            iconView.imageIV.frame = CGRectMake(iconView.bounds.size.width * 0.15, iconView.bounds.size.height * 0.15, iconView.bounds.size.width * 0.7, iconView.bounds.size.height * 0.7);
                        }else if(DialogStrIsEmpty(dic[@"image"])){
                            iconView.titleLB.frame =  CGRectMake(5, 0, iconView.bounds.size.width - 10, iconView.bounds.size.height);
                        }else if (!DialogStrIsEmpty(dic[@"name"]) && !DialogStrIsEmpty(dic[@"image"])){
                            iconView.imageIV.frame = CGRectMake((itemWidth - itemWidth * percentImage)/2, 5, itemWidth * percentImage,itemHeight * percentImage);
                            iconView.titleLB.frame = CGRectMake(2, CGRectGetMaxY(iconView.imageIV.frame) + 2, itemWidth - 4,20);
                        }
                        [self.shareView addSubview:iconView];
                        self.shareView.frame = CGRectMake(0, 0, MIN(dataArr.count, self.param.wColumnCount) * itemWidth ,  ceil(dataArr.count/(self.param.wColumnCount * 1.0)) * itemHeight );
                    }else if ([dic isKindOfClass:NSString.class]){
                        UILabel *label = UILabel.new;
                        label.textColor = self.param.wMessageColor;
                        label.font = [UIFont systemFontOfSize:self.param.wMessageFont];
                        label.text = (NSString*)dic;
                        label.textAlignment = NSTextAlignmentCenter;
                        label.frame = CGRectMake(loc * itemWidth , row * itemHeight * 0.7, itemWidth , itemHeight * 0.7);
                        label.tag = i;
                        label.userInteractionEnabled = YES;
                        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
                        [label addGestureRecognizer:tap];
                        [self.shareView addSubview:label];
                        self.shareView.frame = CGRectMake(0, 0, MIN(dataArr.count, self.param.wColumnCount) * itemWidth ,  ceil(dataArr.count/(self.param.wColumnCount * 1.0)) * itemHeight * 0.7);
                    }
                }
                if(self.param.wCustomShareView) self.param.wCustomShareView(self.shareView);
                contenView = self.shareView;
            }else if (self.param.wPopStyleType == DialogPopTypeCustom) {
                contenView = self.param.wPopCustomView();
            }
            if (!contenView) {
                NSLog(@"请传入内容视图"); return;
            }
            CGRect tableViewRect = contenView.frame;
            if (contenView.frame.size.height == 0 &&[(NSArray*)self.param.wData count]) {
                tableViewRect.size.height = self.param.wHeight;
            }
            [self addSubview:contenView];
            CGFloat offsetY =  self.param.wAngleSize.height;
            DiaDirection direction = self.param.wDirection;
            CGRect rect = CGRectZero;
            /// 箭头位置
            DiaDirection headType = 0;
            CGFloat offset = 0;
            switch (direction) {
                case directionDowm:{
                    rect.size.width = tableViewRect.size.width;
                    tableViewRect.origin.y = offsetY;
                    rect.size.height = offsetY + tableViewRect.size.height;
                    if (self.param.wNavigationItem||
                    self.param.wTapViewType == DiaPopInViewNavi) {
                        rect.origin.x = self.tapRect.origin.x*self.param.wPercentOrginX;
                    }else{
                        rect.origin.x = (self.tapRect.origin.x-(rect.size.width-self.tapRect.size.width)/2)*self.param.wPercentOrginX;
                    }
                    if (rect.size.height + self.param.wMainOffsetY +CGRectGetMaxY(self.tapRect) > DialogScreenH) {
                        direction = directionUp;
                        tableViewRect.origin.y = 0;
                        rect.size.height = tableViewRect.size.height + offsetY;
                        rect.origin.y = CGRectGetMinY(self.tapRect) - self.param.wMainOffsetY - rect.size.height;
                        headType = directionDowm;
                    }else{
                        rect.origin.y = self.param.wMainOffsetY + CGRectGetMaxY(self.tapRect);
                        headType = directionUp;
                    }
                    
                    offset = rect.size.width * self.param.wPercentAngle;
                }
                    break;
                case directionUp:{
                    rect.size.width = tableViewRect.size.width;
                    tableViewRect.origin.y = 0;
                    rect.size.height = offsetY + tableViewRect.size.height ;
                    
                    rect.origin.x = (self.tapRect.origin.x-(rect.size.width-self.tapRect.size.width)/2)*self.param.wPercentOrginX;
                    if (CGRectGetMinY(self.tapRect) - self.param.wMainOffsetY - rect.size.height < DialogSafeBottomHeight) {
                        direction = directionDowm;
                        tableViewRect.origin.y = offsetY;
                        rect.size.height = offsetY + tableViewRect.size.height;
                        rect.origin.y = self.param.wMainOffsetY + CGRectGetMaxY(self.tapRect);
                        headType = directionUp;
                    }else{
                        rect.origin.y = CGRectGetMinY(self.tapRect) - self.param.wMainOffsetY - rect.size.height;
                        headType = directionDowm;
                    }

                    offset = rect.size.width * self.param.wPercentAngle;
                }
                        
                    break;
                case directionright:{
                    rect.size.height = tableViewRect.size.height;
                    tableViewRect.origin.x = offsetY;
                    rect.size.width = tableViewRect.size.width + offsetY;
                    rect.origin.y = (self.tapRect.origin.y - (rect.size.height-self.tapRect.size.height)/2)*self.param.wPercentOrginX;
                    if (rect.size.width + self.param.wMainOffsetY + CGRectGetMaxX(self.tapRect) > DialogScreenW) {
                        direction = directionLeft;
                        tableViewRect.origin.x = 0;
                        rect.size.width = tableViewRect.size.width + offsetY;
                        rect.origin.x = CGRectGetMinX(self.tapRect) - self.param.wMainOffsetY - rect.size.width;
                        headType = directionright;
                    }else{
                        rect.origin.x = CGRectGetMaxX(self.tapRect) + self.param.wMainOffsetY;
                        headType = directionLeft;
                    }
                    offset = rect.size.height*self.param.wPercentAngle;
                }
                            
                    break;
                case directionLeft:{
                    rect.size.height = tableViewRect.size.height;
                    tableViewRect.origin.x = 0;
                    rect.size.width = tableViewRect.size.width + offsetY;
                    rect.origin.y = (self.tapRect.origin.y - (rect.size.height-self.tapRect.size.height)/2) *self.param.wPercentOrginX;
                    if (CGRectGetMinX(self.tapRect) - self.param.wMainOffsetY - rect.size.width < 0) {
                        direction = directionright;
                        tableViewRect.origin.x = offsetY;
                        rect.size.width = tableViewRect.size.width + offsetY;
                        rect.origin.x = self.param.wMainOffsetY + CGRectGetMaxX(self.tapRect);
                        headType = directionLeft;
                    }else{
                        rect.origin.x = CGRectGetMinX(self.tapRect) - self.param.wMainOffsetY - rect.size.width;
                        headType = directionright;
                    }
                    offset = rect.size.height*self.param.wPercentAngle;
                }
                        
                    break;
                default:
                    break;
            }
            if (self.param.wNavigationItem||
                self.param.wTapViewType == DiaPopInViewNavi) {
                if (CGRectGetMaxX(rect) > DialogScreenW) rect.origin.x = CGRectGetMaxX(self.tapRect)- rect.size.width;
                if (CGRectGetMinX(rect) < 0) rect.origin.x = 0;
            }else{
                if (CGRectGetMaxX(rect) > DialogScreenW) rect.origin.x = DialogScreenW - rect.size.width;
                if (CGRectGetMinX(rect) < 0) rect.origin.x = 0;
                if (CGRectGetMaxY(rect) > (DialogScreenH - DialogSafeBottomHeight))
                    rect.origin.y = (DialogScreenH - DialogSafeBottomHeight) - rect.size.height;
                if (CGRectGetMinY(rect) < DialogStatusH) rect.origin.y = DialogStatusH;
            }
            self.frame = rect;
            contenView.frame = tableViewRect;
            [self addArrowBorderAt:headType offset:offset rectCorner:self.param.wPopViewRectCorner width:self.param.wAngleSize.width height:self.param.wAngleSize.height cornerRadius:self.param.wMainRadius borderWidth:self.param.wPopViewBorderWidth borderColor:self.param.wPopViewBorderColor angleRadio:self.param.wAngleRadio];
        }
            break;
            
#pragma -mark DialogTypePickSelect
        case DialogTypePickSelect:{
            
            if (DialogIsArray(self.param.wData)) {
               [(NSArray*)self.param.wData enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                   if (![obj isKindOfClass:[NSArray class]]) {
                       self.nest = YES;
                       *stop = YES;return;
                   }
               }];
            }
            
            [self addTopView];
            self.pickView.frame =  CGRectMake(0, self.headView?CGRectGetMaxY(self.headView.frame):0, self.param.wWidth, self.param.wHeight);
            [self addSubview:self.pickView];
            
            if (self.param.wListDefaultValue) {
                if ([self.param.wData isKindOfClass:[NSArray class]]) {
                    NSArray *arr = (NSArray*)self.param.wData;
                    if (self.nest) {
                        [self setDefaultWithRow:(NSArray*)self.param.wData defaultIndex:0];
                    }else{
                        [arr enumerateObjectsUsingBlock:^(NSArray*  _Nonnull sonArr, NSUInteger idx, BOOL * _Nonnull stop) {
                            if ([sonArr isKindOfClass:[NSArray class]]) {
                                [self setDefaultWithRow:sonArr defaultIndex:idx];
                            }
                        }];
                    }
                }
            }
        }break;
            
#pragma -mark DialogTypeLocation
        case DialogTypeLocation:{
            if (self.param.wData&&
                [self.param.wData isKindOfClass:[WMZDialogTree class]]) {
                self.tree = (WMZDialogTree*)self.param.wData;
                self.depth = self.param.wLocationType;
            }else{
                self.tree = [WMZDialogTree new];
                self.tree.depth = 0;
                NSXMLParser *parser = [[NSXMLParser alloc] initWithData:[NSData dataWithContentsOfFile:self.param.wXMLPathName]];
                parser.delegate = self;
                [self.theLock lock];
                [parser parse];
            }
            //添加UI
            if (self.param.wChainType == ChainTableView) {
                CGFloat y = [self addTopTitleView];
                for (int i = 0; i<self.depth; i++) {
                    WMZDialogTableView *tableView = [[WMZDialogTableView alloc]initWithFrame:CGRectMake((i == 0)?0:CGRectGetMaxX(self.tableView.frame), y ? (y + self.param.wMainOffsetY) : 0, self.param.wWidth/self.depth, self.param.wHeight) style:UITableViewStyleGrouped];
                    if (self.param.wTableViewColor && i < self.param.wTableViewColor.count) {
                        tableView.backgroundColor = self.param.wTableViewColor[i];
                    }
                    tableView.delegate = self;
                    tableView.dataSource = self;
                    tableView.rowHeight = self.param.wMainBtnHeight;
                    tableView.tag = 100+i;
                    self.tableView = tableView;
                    [self addSubview:tableView];
                    if (!self.param.wListDefaultValue) {
                        if (i > 0) tableView.hidden = YES;
                    }
                }
            }else{
                self.param.wPickRepeat = NO;
                self.headView = [self addTopView];
                self.pickView.frame =  CGRectMake(0, self.headView?CGRectGetMaxY(self.headView.frame):0, self.param.wWidth, self.param.wHeight);
                [self addSubview:self.pickView];
            }
            if (self.param.wListDefaultValue) {
                [self.param.wListDefaultValue enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger component, BOOL * _Nonnull stop) {
                    if (self.param.wLocationType>component) {
                        NSMutableArray *dataArr = [self getMyDataArr:component+100 withType:0];
                        NSInteger row = NSNotFound;
                        if ([obj isKindOfClass:[NSNumber class]]) {
                               NSInteger num = [obj intValue];
                            if (dataArr.count>num) {
                                row = num;
                            }
                        }else if([obj isKindOfClass:[NSString class]]){
                            for (int i = 0 ; i<dataArr.count; i++) {
                                WMZDialogTree *tree = dataArr[i];
                                if ([tree.name isEqualToString:obj]||
                                    [tree.ID isEqualToString:obj]) {
                                    row = i;
                                    break;
                                }
                            }
                        }else{
                            row = [dataArr indexOfObject:obj];
                        }
                        for (int i = 0 ; i<dataArr.count; i++) {
                            WMZDialogTree *tree = dataArr[i];
                            tree.isSelected = (i == row);
                        }
                        if (component<self.depth-1) {
                            WMZDialogTree *selectTree =  dataArr[self.param.wPickRepeat?row%dataArr.count:row];
                            for (WMZDialogTree *tree in selectTree.children) {
                                tree.isSelected = NO;
                            }
                        }
                        if (self.param.wChainType == ChainPickView) {
                            if (row!=NSNotFound)
                                [self.pickView selectRow:row inComponent:component animated:YES];
                        }else{
                            if (row!=NSNotFound) {
                                UITableView *ta  = [self viewWithTag:component+100];
                                if ([ta isKindOfClass:[UITableView class]]) {
                                    [ta scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:NO];
                                    [ta selectRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
                                }
                            }
                        }
                    }
                }];
            }
        }
            break;
            
#pragma -mark DialogTypeCardPresent
        case DialogTypeCardPresent:{
            UIView *headView = nil;
            self.frame = CGRectMake(0, 0, self.param.wWidth, MIN(DialogScreenH - DialogNaviH, self.param.wHeight));
            if (self.param.wParentHeadView) {
                headView =  self.param.wParentHeadView(self,self.tableView);
                if (headView != self)  [self addSubview:headView];
            }
            
            UIView *bottomView = nil;
            if (self.param.wParentBottomView) {
                bottomView =  self.param.wParentBottomView(self,self.tableView);
                if (bottomView != self){
                    CGRect rect = CGRectZero;
                    rect.origin.x = 0;
                    rect.origin.y = 0;
                    if (headView) rect.origin.y = CGRectGetMaxY(headView.frame);
                    rect.size.width = self.param.wWidth;
                    rect.size.height = bottomView.frame.size.height;
                    bottomView.frame = rect;
                    [self addSubview:bottomView];
                    self.finalRect = CGRectMake(0, 0, self.param.wWidth, MIN(DialogScreenH - DialogNaviH, CGRectGetMaxY(bottomView.frame)));
                }
            }else{
                if (!self.param.wParentHeadView) {
                    self.finalRect = CGRectMake(0, 0, self.param.wWidth,MIN(DialogScreenH - DialogNaviH, self.param.wHeight));
                }else{
                    self.finalRect = CGRectMake(0, 0, self.param.wWidth,MIN(DialogScreenH - DialogNaviH, CGRectGetMaxY(headView.frame)));
                }
            }
            
            if (self.param.wOpenDragging) {
                UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panAction:)];
                self.userInteractionEnabled = YES;
                [self addGestureRecognizer:pan];
            }
        }
            break;
#pragma -mark DialogTypeMenusSelect
        case DialogTypeMenusSelect:{
            NSArray *dataArr = (NSArray*)self.param.wData;
            if (!DialogIsArray(dataArr)) {
                NSLog(@"Please Input Array"); return;
            }
            CGFloat y = [self addTopTitleView];
            /// 递归计算深度
            self.depth = 0;
            if (dataArr.count) {
                self.depth = 1;
                self.tree = [WMZDialogTree new];
                self.tree.depth = 0;
                for (NSDictionary *dic in self.param.wData) {
                    WMZDialogTree *tree = [[WMZDialogTree alloc]initWithDetpth:1 withName:dic[@"name"]?:@"" withID:dic[@"id"]?:@""];
                    [self.tree.children addObject:tree];
                    if (dic[@"children"])
                        [self getDepth:dic[@"children"] withTree:tree withDepth:1];
                }
            }
            /// 添加UI
            WMZDialogTableView *temp = nil;
            for (int i = 0; i < self.depth; i++) {
                WMZDialogTableView *ta = [[WMZDialogTableView alloc]initWithFrame:CGRectMake(!temp?0:CGRectGetMaxX(temp.frame), y ? (y + self.param.wMainOffsetY) : 0, self.param.wWidth / self.depth, self.param.wHeight) style:UITableViewStyleGrouped];
                if (self.param.wTableViewColor &&i <self.param.wTableViewColor.count) {
                    ta.backgroundColor = self.param.wTableViewColor[i];
                }
                ta.delegate = self;
                ta.dataSource = self;
                ta.rowHeight = self.param.wCellHeight;
                ta.tag = 100 + i;
                temp = ta;
                [self addSubview:ta];
                self.tableView = ta;
                if (!self.param.wListDefaultValue) {
                    if (i > 0) ta.hidden = YES;
                }
            }
        }
            break;
            
        default:
            break;
    }
}

- (CGRect)mz_setupRect{
    NSDictionary *rectInfo = @{
        @(DialogTypeSelect):[NSValue valueWithCGRect:CGRectMake(0, 0, self.param.wWidth, (self.param.wAddBottomView || self.param.wMultipleSelection) ? CGRectGetMaxY(self.bottomView.frame) : CGRectGetMaxY(self.tableView.frame))],
        @(DialogTypeSheet):[NSValue valueWithCGRect: CGRectMake(0, 0, self.param.wWidth, ((!self.param.wMultipleSelection || self.param.wEventCancelFinish) && DialogStrIsNotEmpty(self.param.wCancelTitle)) ? CGRectGetMaxY(self.cancelBtn.frame) : CGRectGetMaxY(self.tableView.frame))],
        @(DialogTypePickSelect):[NSValue valueWithCGRect: CGRectMake(0, 0, self.param.wWidth, CGRectGetMaxY(self.pickView.frame))],
        @(DialogTypeLocation):[NSValue valueWithCGRect: CGRectMake(0, self.param.wChainType == ChainTableView ? (self.param.wTapView? CGRectGetMaxY(self.param.wTapView.frame):0):0, self.param.wWidth, self.param.wChainType == ChainTableView ? CGRectGetMaxY(self.tableView.frame) : CGRectGetMaxY(self.pickView.frame))],
        @(DialogTypeMenusSelect):[NSValue valueWithCGRect: CGRectMake(0, 0, self.param.wWidth, CGRectGetMaxY(self.tableView.frame))],
        @(DialogTypeCardPresent):[NSValue valueWithCGRect: self.finalRect],
    };
    NSValue *value = rectInfo[@(self.param.wType)];
    if (value) {
        self.frame = value.CGRectValue;
        return value.CGRectValue;
    }
    return CGRectZero;
}

- (UIRectCorner)mz_setupCorner{
    switch (self.param.wType) {
        case DialogTypeSelect:return UIRectCornerAllCorners;
        case DialogTypeSheet:
        case DialogTypeMenusSelect:
        case DialogTypePickSelect:
        case DialogTypeCardPresent:
            return UIRectCornerTopLeft |UIRectCornerTopRight;
        case DialogTypeLocation:{
            if (self.param.wChainType == ChainPickView) return UIRectCornerTopLeft |UIRectCornerTopRight;
        }
        case DialogTypePop: return -99999;
        default:return UIRectCornerAllCorners;
    }
}

- (void)mz_changeFrame:(NSValue *)value{
    if (self.param.wType == DialogTypeCardPresent) {
        self.normalPoint = [value CGPointValue];
    }
}

- (BOOL)mz_centerView{
    if (self.param.wType == DialogTypePop) return NO;
    return YES;
}

/// 确定事件
- (void)confirmAction:(WMZDialogButton*)sender{
    @DialogWeakify(self)
    if (self.param.wType == DialogTypeLocation) {
        [[WMZDialogManage.shareInstance currentDialog:self] closeView:^{
            @DialogStrongify(self)
            if (self.param.wEventOKFinish) {
                NSArray *arr = [self getTreeSelectDataArr:(self.param.wChainType == ChainTableView)?NO:YES];
                NSMutableString *string = [NSMutableString stringWithString:@""];
                for (WMZDialogTree *tree in arr) {
                    if (!string.length) {
                        [string appendString:tree.name];
                    }else{
                        [string appendFormat:@"%@", [NSString stringWithFormat:@"%@%@",self.param.wSeparator,tree.name]];
                    }
                }
                self.param.wEventOKFinish(arr, string);
            }
        }];
    }else if (self.param.wType == DialogTypePickSelect){
        [[WMZDialogManage.shareInstance currentDialog:self] closeView:^{
            @DialogStrongify(self)
            if (self.param.wEventOKFinish) {
                if (self.tree) {
                    NSArray *arr = [self getTreeSelectDataArr:YES];
                    NSMutableArray *nameArr = [NSMutableArray new];
                    for (WMZDialogTree *tree in arr) {
                        [nameArr addObject:tree.name];
                    }
                    self.param.wEventOKFinish(arr, nameArr);
                }else{
                    NSMutableArray *mStr = [NSMutableArray new];
                    if (!self.nest) {
                        if (DialogIsArray(self.param.wData)) {
                            for (int i = 0; i<[(NSArray*)self.param.wData count]; i++) {
                                NSArray *arr = [(NSArray*)self.param.wData objectAtIndex:i];
                                if (DialogIsArray(arr)) {
                                    NSString *str = arr [self.param.wPickRepeat?[self.pickView selectedRowInComponent:i]%arr.count:[self.pickView selectedRowInComponent:i]];
                                    [mStr addObject:str];
                                }
                            }
                            self.param.wEventOKFinish(mStr, nil);
                        }
                    }else{
                        NSInteger index = self.param.wPickRepeat?[self.pickView selectedRowInComponent:0]%[(NSArray*)self.param.wData count]:[self.pickView selectedRowInComponent:0];
                        NSString *str = [(NSArray*)self.param.wData objectAtIndex:index];
                        self.param.wEventOKFinish(str, nil);
                    }
                }
            }
        }];
    }else if (self.param.wType == DialogTypeSheet || self.param.wType == DialogTypeSelect){
        [[[WMZDialogManage shareInstance] currentDialog:self] closeView:^{
            @DialogStrongify(self)
            if (self.param.wEventOKFinish)
                self.param.wEventOKFinish(self.selectArr, self.pathArr);
        }];
    }
}

- (void)tapAction:(UITapGestureRecognizer*)tap{
    UIView *view = tap.view;
    id anyId = self.param.wData[view.tag];
    @DialogWeakify(self)
    [[WMZDialogManage.shareInstance currentDialog:self] closeView:^{
        @DialogStrongify(self)
        if (self.param.wEventFinish)
            self.param.wEventFinish(anyId,[NSIndexPath indexPathForRow:view.tag inSection:0], self.param.wType);
    }];
}

/// 处理嵌套问题
- (void)dealNested:(NSString*)stopView{
    NSMutableArray *arr = [NSMutableArray new];
    [arr addObject:self.param.wTapView];
    /// 父视图
    NSMutableArray *superViewArr = [NSMutableArray new];
    while (arr.count) {
        UIView *view = arr.lastObject;
        [arr removeLastObject];
        if ([NSStringFromClass([view class]) isEqualToString:self.param.wPopNestStopView ? : stopView]) {
            /// 取消最后一个
            [superViewArr removeLastObject];
            break;
        }else{
            if (view != self.param.wTapView) {
                [superViewArr addObject:view];
            }
        }
        if (view.superview) [arr addObject:view.superview];
            
    }
    if (superViewArr.count) {
        __block CGFloat y = 0;
        __block CGFloat x = 0;
        [superViewArr enumerateObjectsUsingBlock:^(UIView *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            y += obj.frame.origin.y;
            x += obj.frame.origin.x;
        }];
            
        CGRect rect = self.tapRect;
        rect.origin.y += y;
        rect.origin.x += x;
        self.tapRect = rect;
    }
}

#pragma -mark pickView默认值处理
- (void)setDefaultWithRow:(NSArray*)arr defaultIndex:(NSInteger)compom{
    if (arr&&
        [arr isKindOfClass:[NSArray class]]&&
        arr.count) {
        id defaultValue = nil;
        if ([self.param.wListDefaultValue isKindOfClass:[NSArray class]] &&
            self.param.wListDefaultValue.count > compom) {
            defaultValue = self.param.wListDefaultValue[compom];
        }
        if (defaultValue) {
            NSInteger index = NSNotFound;
            if ([defaultValue isKindOfClass:[NSNumber class]]) {
                NSInteger num = [defaultValue intValue];
                if (arr.count>num) {
                    index = num;
                }
            }else if ([defaultValue isKindOfClass:[NSString class]]){
                int i = 0;
                for (id sonData in arr) {
                    i++;
                    if ([sonData isKindOfClass:[NSString class]]) {
                        if ([sonData isEqualToString:defaultValue]) {
                            index = [arr indexOfObject:sonData];break;
                        }
                    }else if ([sonData isKindOfClass:[NSDictionary class]]){
                        NSString *name = sonData[@"name"];
                        if (name && [name isKindOfClass:[NSString class]]) {
                            if ([name isEqualToString:defaultValue]) {
                                index = [arr indexOfObject:sonData];break;
                            }
                        }
                    }
                }
            }else{
                index = [arr indexOfObject:defaultValue];
            }
            
            if (index != NSNotFound)
               [self.pickView selectRow:index inComponent:compom animated:NO];
        }
    }
}

#pragma -mark 处理地址
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    NSDictionary *dic = @{
                          @"province":@(1),
                          @"city":@(2),
                          @"district":@(3),
                          };
    WMZDialogTree *tree = [[WMZDialogTree alloc]initWithDetpth:[[dic objectForKey:elementName] integerValue] withName:attributeDict[@"name"]?:@"" withID:attributeDict[@"zipcode"]?:@""];
    NSInteger num = [[dic objectForKey:elementName] integerValue];
    if ([elementName isEqualToString:@"province"] && self.param.wLocationType >= num) {
        [self.tree.children addObject:tree];
         self.depth = num;
    } else if ([elementName isEqualToString:@"city"] && self.param.wLocationType >= num) {
        WMZDialogTree *parentTree = self.tree.children.lastObject;
        [parentTree.children addObject:tree];
         self.depth = num;
    } else if ([elementName isEqualToString:@"district"] && self.param.wLocationType >= num) {
        WMZDialogTree *parentTree = self.tree.children.lastObject;
        WMZDialogTree *p_parentTree = parentTree.children.lastObject;
        [p_parentTree.children addObject:tree];
        self.depth = num;
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    [self.theLock unlock];
}

/// 滑动手势监听事件
- (void)panAction:(UIPanGestureRecognizer*)pan{
    if (!self.param.wOpenDragging) return;
    CGPoint transP = [pan translationInView:pan.view];
    CGPoint center =  pan.view.center;
    CGFloat scale = 0;
    CGFloat alpha = 0;
    if (center.x<=self.normalPoint.x) {
        center.y += transP.y;
        scale = (0.1 * fabs(center.y-self.normalPoint.y)) / pan.view.frame.size.height;
        alpha = (self.param.wShadowAlpha* fabs(center.y - self.normalPoint.y)) / pan.view.frame.size.height;
    }
    if (center.y <= self.normalPoint.y && self.param.wLeftScrollClose) {
        center.x += transP.x;
        scale = (0.1 * fabs(center.x - self.normalPoint.x)) / pan.view.frame.size.width;
        alpha = (self.param.wShadowAlpha * fabs(center.x-self.normalPoint.x))/pan.view.frame.size.width;
    }
    [pan setTranslation:CGPointZero inView:pan.view];
    switch (pan.state) {
        case UIGestureRecognizerStateEnded:
        {
            self.tableView.scrollEnabled = YES;
            if (center.x <= self.normalPoint.x) {
                if (center.y < self.normalPoint.y + pan.view.frame.size.height / 2) {
                    center = self.normalPoint;
                    scale = 0;
                    alpha = 0;
                }
                if (center.y >= self.normalPoint.y + pan.view.frame.size.height / 2) {
                    self.param.wHideAnimation = AninatonHideTop;
                    [[WMZDialogManage.shareInstance currentDialog:self] closeView]; return;
                }
            }
            
            if (center.y <= self.normalPoint.y && self.param.wLeftScrollClose) {
                if (center.x < self.normalPoint.x + pan.view.frame.size.width / 2) {
                    scale = 0;
                    alpha = 0;
                    center = self.normalPoint;
                }
                if (center.x >= self.normalPoint.x + pan.view.frame.size.width / 2) {
                     self.param.wHideAnimation = AninatonHideRight;
                    [[WMZDialogManage.shareInstance currentDialog:self] closeView]; return;
                }
            }
        }
            break;
        case UIGestureRecognizerStateBegan:{
            if (center.y<self.normalPoint.y) return;
            if (center.x<self.normalPoint.x) return;
            if (self.tableView.contentOffset.y <= 0) self.tableView.scrollEnabled = NO;
            
        }
            break;
        case UIGestureRecognizerStateChanged:{
            if (center.y<self.normalPoint.y) return;
            if (center.x<self.normalPoint.x) return;
            if (self.tableView.contentOffset.y <= 0) self.tableView.scrollEnabled = NO;
        }
            break;
        default:
            break;
    }
    scale = MIN(0.1, MAX(0,scale));
    alpha = MIN(self.param.wShadowAlpha, MAX(0,alpha));
    [UIView animateWithDuration:0.1 animations:^{
        pan.view.center = center;
        [[WMZDialogManage.shareInstance currentDialog:self] shadowView].alpha = self.param.wShadowAlpha - alpha;
        if (self.param.wScaleParentVC) {
            UIViewController *VC = [WMZDialogUntils getCurrentVC];
            if (VC.navigationController) {
                VC.navigationController.view.transform = CGAffineTransformMakeScale(0.9+scale, 0.9+scale);
            }else{
                VC.view.transform = CGAffineTransformMakeScale(0.9+scale, 0.9+scale);
            }
        }
    }];
}

/// 获取深度
- (void)getDepth:(NSArray*)arr withTree:(WMZDialogTree*)treePoint withDepth:(NSInteger)depth{
    if (DialogArrayNotEmpty(arr)){
        self.depth = MAX(self.depth, depth + 1);
        for (NSDictionary *dic in arr) {
            WMZDialogTree *tree = [[WMZDialogTree alloc]initWithDetpth:depth+1 withName:dic[@"name"]?:@"" withID:dic[@"id"]?:@""];
            [treePoint.children addObject:tree];
            NSArray *dicArr = dic[@"children"];
            if (DialogArrayNotEmpty(dicArr))
                [self getDepth:dicArr withTree:tree withDepth:depth+1];
        }
    }
}

/// 点击处理
- (void)selectWithTableView:(UITableView *)tableView withIndexPath:(NSIndexPath*)indexPath{
    NSMutableArray <WMZDialogTree*>* dataArr = [self getMyDataArr:tableView.tag withType:0];
    for (int i = 0 ; i< dataArr.count; i++) {
        dataArr[i].isSelected = (i == indexPath.row);
    }
    WMZDialogTree *selectTree =  dataArr[indexPath.row];
    //下一级选中全变为NO
    for (WMZDialogTree *tree in selectTree.children) {
        tree.isSelected = NO;
    }
    [tableView reloadData];
    if (tableView.tag < self.depth+99) {
        NSInteger num = tableView.tag+1;
        while (num < self.depth + 100) {
            UITableView *ta = [self viewWithTag:num];
            if (num == tableView.tag+1) {
                ta.hidden = NO;
                [ta reloadData];
            }else{
                ta.hidden = YES;
            }
            num++;
        }
    }else{
        [[WMZDialogManage.shareInstance currentDialog:self] closeView];
    }

    if (self.param.wEventMenuClick)
        self.param.wEventMenuClick([self getTreeSelectDataArr:NO], tableView.tag-99,indexPath.row+1);
}

/// 更新下拉菜单数据 用于外部传入数据 只更新下一列的数据 下下列的数据不变
/// @param  section  列
/// @param  update  是否更新子列表数组
/// @param  data   数据
- (void)updateMenuChildrenDataWithSection:(NSInteger)section  withUpdateChildren:(BOOL)update withData:(NSArray*)data{
    if (section > 0 && section <= self.depth) {
        WMZDialogTree *tree = [self getMyDataArr:section+99 withType:1];
        if (data.count <= tree.children.count) {
            NSMutableArray *arr = [NSMutableArray arrayWithArray:tree.children];
            for (int i = (int)arr.count-1; i >= 0; i--) {
                WMZDialogTree *tempTree = arr[i];
                if (i >= data.count) {
                    [arr removeObject:tempTree];
                    continue;
                }
                NSDictionary *dic = data[i];
                tempTree.name = dic[@"name"];
                tempTree.ID = dic[@"id"];
                tempTree.isSelected = NO;
                if (update) tempTree.children = dic[@"children"];
            }
            tree.children = arr;
        }else{
            for (int i = 0; i < data.count; i++) {
                NSDictionary *dic = data[i];
                if (i >= tree.children.count) {
                    WMZDialogTree *tempTree = [[WMZDialogTree alloc]initWithDetpth:tree.depth + 1 withName:dic[@"name"]?:@"name" withID:dic[@"id"]?:@"id"];
                    [tree.children addObject:tempTree];
                }else{
                    WMZDialogTree *tempTree = tree.children[i];
                    if (update) tempTree.children = dic[@"children"];
                    tempTree.name = dic[@"name"];
                    tempTree.ID = dic[@"id"];
                    tempTree.isSelected = NO;
                }
            }
        }
        UITableView *ta = [self viewWithTag:99+section];
        [ta reloadData];
    }
}

@end
