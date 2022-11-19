
//
//  WMZDialogTable.m
//  WMZDialog
//
//  Created by wmz on 2021/7/18.
//  Copyright © 2021 wmz. All rights reserved.
//

#import "WMZDialogTable.h"
#import "WMZDialog.h"

@implementation WMZDialogTable
@synthesize tableView = _tableView;
@synthesize pickView = _pickView;

- (void)setParam:(WMZDialogParam *)param{
    if (DialogIsArray(param.wListDefaultValue)) {
        self.tempArr = [NSMutableArray arrayWithArray:param.wListDefaultValue];
        if (self.tempArr.count>1 &&
            !param.wMultipleSelection) {
            NSMutableArray *temp = [NSMutableArray arrayWithObject:self.tempArr[0]];
            self.tempArr = [NSMutableArray arrayWithArray:temp];
        }
    }
    self.tableView.wOpenScrollClose = param.wOpenScrollClose;
    self.tableView.wCardPresent = (param.wType == DialogTypeCardPresent);
    
    if (DialogIsArray(param.wData))
        self.tableView.scrollEnabled = [(NSArray*)param.wData count] > param.wListScrollCount;
                                        
    [super setParam:param];
}

# pragma  mark tableView 代理
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{return nil;}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{return nil;}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{return 0.01;}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{return 0.01;}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.param.wType == DialogTypeMenusSelect || self.param.wType == DialogTypeLocation?[(NSArray*)[self getMyDataArr:tableView.tag withType:0] count]:[(NSArray*)self.param.wData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    id data = (self.param.wType == DialogTypeMenusSelect || self.param.wType == DialogTypeLocation?[self getMyDataArr:tableView.tag withType:0]:self.param.wData)[indexPath.row];
    BOOL isSelect = NO;
    if (![data isKindOfClass:[WMZDialogTree class]]) {
        for (int i = 0; i<self.tempArr.count; i++) {
            id obj = self.tempArr[i];
            if (([obj isKindOfClass:[NSNumber class]] && ([obj intValue] == indexPath.row))||
                ([obj isKindOfClass:[NSIndexPath class]] && indexPath.row == [(NSIndexPath*)obj row])||
                ([obj isKindOfClass:[NSString class]] && [data isKindOfClass:[NSDictionary class]]&&
                [data[@"id"] isEqualToString:obj])||
                (([data isEqual:obj]))) {
                isSelect = YES;
                if ([self.selectArr indexOfObject:data] == NSNotFound)
                    [self.selectArr addObject:data];
                
                if ([self.pathArr indexOfObject:indexPath] == NSNotFound)
                    [self.pathArr addObject:indexPath];
                
                break;
             }
        }
    }
    if (self.param.wCustomCell) {
        return self.param.wCustomCell(indexPath,self.tableView,data,isSelect);
    }
    NSString *cellID = DialogCellTextReuseIdentifier;
    if ([data isKindOfClass:[NSDictionary class]] && data[@"image"]) {
        cellID = DialogCellImageTextReuseIdentifier;
    }
    WMZDialogCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DialogCell"];
    if (!cell) {
        cell = [[WMZDialogCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID param:self.param];
    }
    UIColor *normalColor = self.param.wCellBackgroundColor;
    cell.contentView.backgroundColor = DialogDarkOpenColor(normalColor,        WMZDialogManage.shareInstance.darkColorInfo[DialogDarkMainColor],self.param.wOpenDark);
    cell.textLa.textAlignment = self.param.wTextAlignment;
    cell.textLa.font = [UIFont systemFontOfSize:self.param.wMessageFont];
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    [cell.button setTintColor:self.param.wThemeColor];
    cell.button.image = self.param.wCheckImage;
    if (indexPath.row == [(NSArray*)self.param.wData count] - 1) {
        cell.lineView.hidden = YES;
    }else{
        cell.lineView.hidden = (self.param.wSeparatorStyle == UITableViewCellSeparatorStyleNone);
    }
    cell.lineView.backgroundColor = self.param.wLineColor;
    cell.lineView.alpha = self.param.wLineAlpha;
    if ([data isKindOfClass:[WMZDialogTree class]]) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        WMZDialogTree *selectDic = (WMZDialogTree*)data;
        cell.contentView.backgroundColor = self.param.wTableViewColor[MIN(selectDic.depth-1, self.param.wTableViewColor.count - 1)];
        cell.textLa.textColor = selectDic.isSelected?self.param.wThemeColor:self.param.wMessageColor;
        cell.button.hidden = !selectDic.isSelected;
        if([selectDic.name isKindOfClass:NSAttributedString.class]){
            cell.textLa.attributedText = (NSAttributedString*)selectDic.name;
        }else{
            cell.textLa.text = selectDic.name;
        }
    }else{
        if([data isKindOfClass:[NSDictionary class]]){
            NSString *iconStr = data[@"image"];
            NSString *nameStr = data[@"name"];
            BOOL hasImage = NO;
            if (iconStr && [iconStr isKindOfClass:[NSString class]] && iconStr.length) hasImage = YES;
            BOOL hasText = NO;
            if (nameStr && [nameStr isKindOfClass:[NSString class]] && nameStr.length) hasText = YES;
            cell.iconImage.image = [UIImage imageNamed:iconStr?:@" "];
            cell.iconImage.hidden = !hasImage;
            cell.textLa.hidden = !hasText;
            cell.textLa.textColor =  isSelect ? self.param.wThemeColor : self.param.wMessageColor;
            cell.button.hidden = !isSelect;
            if([data[@"name"] isKindOfClass:NSAttributedString.class]){
                cell.textLa.attributedText = data[@"name"];
            }else{
                cell.textLa.text = data[@"name"] ? : @" ";
            }
        }else if([data isKindOfClass:[NSString class]] || [data isKindOfClass:[NSAttributedString class]]){
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLa.textColor = isSelect ? self.param.wThemeColor : self.param.wMessageColor;
            cell.button.hidden = !isSelect;
            if([data isKindOfClass:NSAttributedString.class]){
                cell.textLa.attributedText = data;
            }else{
                cell.textLa.text = data;
            }
        }
    }
    if (!self.param.wSelectShowChecked) cell.button.hidden = YES;
    [cell setNeedsUpdateConstraints];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.param.wCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    id data = (self.param.wType == DialogTypeMenusSelect || self.param.wType == DialogTypeLocation?[self getMyDataArr:tableView.tag withType:0]:self.param.wData)[indexPath.row];
    if (self.param.wSelectCell) {
        self.param.wSelectCell(indexPath,tableView,data);return;
    }
    BOOL isSelect = NO;
    NSInteger index = NSNotFound;
    for (int i = 0; i<self.tempArr.count; i++) {
        id obj = self.tempArr[i];
        if (([obj isKindOfClass:[NSNumber class]]&&([obj intValue] == indexPath.row))||
            ([obj isKindOfClass:[NSIndexPath class]]&&indexPath.row == [(NSIndexPath*)obj row])||
            ([obj isKindOfClass:[NSString class]]&&[data isKindOfClass:[NSDictionary class]]&&
            [data[@"id"] isEqualToString:obj])||
            (([data isEqual:obj]))) {
            isSelect = YES;
            index = i;
            break;
         }
    }
    if (isSelect &&
        self.param.wMultipleSelection &&
        index != NSNotFound ) {
        if(self.tempArr.count > index)
          [self.tempArr removeObjectAtIndex:index];
        if(self.selectArr.count > index)
          [self.selectArr removeObjectAtIndex:index];
        if(self.pathArr.count > index)
          [self.pathArr removeObjectAtIndex:index];
    }
    if (!isSelect) {
        if (!self.param.wMultipleSelection) {
            [self.tempArr removeAllObjects];
            [self.selectArr removeAllObjects];
            [self.pathArr removeAllObjects];
        }
        [self.tempArr addObject:indexPath];
        [self.selectArr addObject:data];
        [self.pathArr addObject:indexPath];
    }
    if (self.param.wType == DialogTypeMenusSelect || self.param.wType == DialogTypeLocation) {
        [self selectWithTableView:tableView withIndexPath:indexPath];
    }else{
        [UIView performWithoutAnimation:^{
            [self.tableView reloadData];
        }];
        if (!self.param.wMultipleSelection) {
            if (self.param.wType != DialogTypeCardPresent) {
                @DialogWeakify(self)
                if (self.param.wAddBottomView) {
                    if (self.param.wEventFinish)
                        self.param.wEventFinish(data, indexPath , self.param.wType);
                }else{
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [[WMZDialogManage.shareInstance currentDialog:self] closeView:^{
                            @DialogStrongify(self)
                            if (self.param.wEventFinish) 
                                self.param.wEventFinish(data, indexPath,self.param.wType);
                        }];
                    });
                }
            }
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.param.wType != DialogTypeCardPresent || scrollView != self.tableView || !self.param.wOpenScrollClose) return;
    if (self.tableView.contentOffset.y <= 0) {
        scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, 0);
    }
}

/// 点击处理
- (void)selectWithTableView:(UITableView *)tableView withIndexPath:(NSIndexPath*)indexPath{
    NSMutableArray *dataArr = [self getMyDataArr:tableView.tag withType:0];
    for (int i = 0 ; i<dataArr.count; i++) {
        WMZDialogTree *tree = dataArr[i];
        tree.isSelected = (i == indexPath.row);
    }
    WMZDialogTree *selectTree =  dataArr[indexPath.row];
    /// 下一级选中全变为NO
    for (WMZDialogTree *tree in selectTree.children) {
        tree.isSelected = NO;
    }
    [tableView reloadData];
    if (tableView.tag < self.depth+99) {
        NSInteger num = tableView.tag+1;
        while (num<self.depth+100) {
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

# pragma  mark pickView 代理
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    NSInteger num = 1;
    if (self.tree) {
        num = self.depth;
    }else{
        if (!self.nest) num = [(NSArray*)self.param.wData count];
    }
    
    return num;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    NSInteger count = 0;
    if (self.tree) {
        count = [(NSArray*)[self getMyDataArr:component+100 withType:0] count] * (self.param.wPickRepeat?pickViewCount:1);
    }else{
        if (self.nest) {
            count = [(NSArray*)self.param.wData count] * (self.param.wPickRepeat ? pickViewCount : 1 );
        }else{
            count = [(NSArray*)self.param.wData[component] count] * (self.param.wPickRepeat ? pickViewCount : 1);
        }
    }
    
    return count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSArray *arr = nil;
    if (self.tree) {
        arr = [self getMyDataArr:component+100 withType:0];
    }else{
        arr = !self.nest?self.param.wData[component]:self.param.wData;
    }
    if (!DialogArrayNotEmpty(arr)) return @"";
    id data = arr[row % arr.count];
    NSString *name = @"";
    if ([data isKindOfClass:[WMZDialogTree class]]) {
        WMZDialogTree *selectDic = (WMZDialogTree*)data;
        name = selectDic.name;
    }
    else if ([data isKindOfClass:[NSDictionary class]]) {
        name = data[@"name"] ? : @"";
    }
    else if ([data isKindOfClass:[NSString class]]) {
        name = data;
    }
    return name;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = UILabel.new;
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        pickerLabel.font = [UIFont boldSystemFontOfSize:self.param.wMessageFont];
    }
    pickerLabel.textColor = self.param.wMessageColor;
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return self.param.wMainBtnHeight;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if(self.param.wType == DialogTypeDatePicker){
        NSCharacterSet* nonDigits =[[NSCharacterSet decimalDigitCharacterSet] invertedSet];
        /// 符合年月日的才改变天数
        if (component == 0) {
            if ([self.param.wDateTimeType rangeOfString:@"dd"].location != NSNotFound &&
                [self.param.wDateTimeType rangeOfString:@"yyyy"].location!= NSNotFound &&
                [self.param.wDateTimeType rangeOfString:@"MM"].location!= NSNotFound ) {
                if ([(NSArray*)self.param.wData count]>2) {
                    NSArray *yearArr = self.param.wData[component];
                    int year =[[yearArr[self.param.wPickRepeat?row%yearArr.count:row] stringByTrimmingCharactersInSet:nonDigits] intValue];
                    NSArray *monthArr = self.param.wData[component+1];
                    NSInteger monthIndex = [self.pickView selectedRowInComponent:component+1];
                    int month =[[monthArr[self.param.wPickRepeat?monthIndex%monthArr.count:monthIndex] stringByTrimmingCharactersInSet:nonDigits] intValue];
                    NSArray *arr = @[@(year),@(month)];
                    
                    SuppressPerformSelectorLeakWarning(
                        self.param.wData[2] = [self performSelector:NSSelectorFromString(@"timeDayWithArr:Data:") withObject:arr withObject:@{}];
                    );
                    [self.pickView reloadComponent:2];
                }
            }
        }
        if (component == 1) {
            if ([self.param.wDateTimeType rangeOfString:@"dd"].location != NSNotFound&&
                [self.param.wDateTimeType rangeOfString:@"yyyy"].location != NSNotFound&&
                [self.param.wDateTimeType rangeOfString:@"MM"].location != NSNotFound) {
                if ([(NSArray*)self.param.wData count]>2) {
                    NSArray *yearArr = self.param.wData[component-1];
                    NSInteger yearIndex = [self.pickView selectedRowInComponent:component-1];
                    int year =[[yearArr[self.param.wPickRepeat ? yearIndex % yearArr.count : yearIndex] stringByTrimmingCharactersInSet:nonDigits] intValue];
                    NSArray *monthArr = self.param.wData[component];
                    int month = [[monthArr[self.param.wPickRepeat ? row % monthArr.count:row] stringByTrimmingCharactersInSet:nonDigits] intValue];
                    NSArray *arr = @[@(year),@(month)];
                    SuppressPerformSelectorLeakWarning(
                        self.param.wData[2] = [self performSelector:NSSelectorFromString(@"timeDayWithArr:Data:") withObject:arr withObject:@{}];
                    );
                    [self.pickView reloadComponent:2];
                }
            }
        }
        SuppressPerformSelectorLeakWarning(
             [self performSelector:NSSelectorFromString(@"updateTime:component:") withObject:@(row) withObject:@(component)];
        );
        return;
    }
    if (self.tree) {
        NSMutableArray *dataArr = [self getMyDataArr:component+100 withType:0];
        if (component<self.depth-1) {
            for (int i = 0 ; i<dataArr.count; i++) {
                WMZDialogTree *tree = dataArr[i];
                tree.isSelected = (i == row % dataArr.count);
            }
            WMZDialogTree *selectTree =  dataArr[self.param.wPickRepeat ? row % dataArr.count : row];
            /// 下一级选中全变为NO
            for (WMZDialogTree *tree in selectTree.children) {
                tree.isSelected = NO;
            }
            [self.pickView reloadComponent:component+1];
            [pickerView selectRow:0 inComponent:component+1 animated:YES];
            if (component == 0 && self.depth >= 3 && self.param.wType == DialogTypeLocation) {
                [self.pickView reloadComponent:component+2];
                [pickerView selectRow:0 inComponent:component+2 animated:YES];
            }
        }else{
            for (int i = 0 ; i<dataArr.count; i++) {
                WMZDialogTree *tree = dataArr[i];
                tree.isSelected = (i == (self.param.wPickRepeat?row%dataArr.count:row));
            }
            [self.pickView reloadComponent:component];
        }
    }
}

/// 数据处理  type 1返回tree对象
- (id)getMyDataArr:(NSInteger )tableViewTag withType:(NSInteger)type{
    if (tableViewTag==100) {
        return type ? self.tree:self.tree.children;
    }else{
        NSInteger taNum = 100;
        WMZDialogTree *resultDic = nil;
        while (taNum < tableViewTag) {
            NSMutableArray *arr = (taNum == 100 ? self.tree.children : resultDic.children);
            NSInteger selectLastIndex = 0;
            for (int i = 0; i < arr.count; i++) {
                WMZDialogTree *tree = arr[i];
                if (tree.isSelected) {
                    selectLastIndex = i;
                    break;
                }
            }
            if (arr.count) resultDic = arr[selectLastIndex];
            taNum++;
        }
        return  type ? resultDic:resultDic.children;
    }
}

- (NSArray*)getTreeSelectDataArr:(BOOL)first{
    self.selectArr = [NSMutableArray new];
    WMZDialogTree *forTree = self.tree;
    while (forTree.children.count) {
        forTree = [self getTreeData:forTree first:first];
        if (forTree) [self.selectArr addObject:forTree];
    }
    return self.selectArr;
}

- (WMZDialogTree*)getTreeData:(WMZDialogTree*)tree first:(BOOL)first{
    WMZDialogTree *firstSelectTree = nil;
    for (int i = 0; i<tree.children.count; i++) {
        WMZDialogTree *sonTree = tree.children[i];
        /// 默认第一个
        if (i == 0) firstSelectTree = sonTree;
        if (sonTree.isSelected) {
            firstSelectTree = sonTree;
            break;
        }
    }
    return firstSelectTree;
}

- (WMZDialogTableView *)tableView{
    if (!_tableView) {
        _tableView =  [[WMZDialogTableView alloc]initWithFrame:self.bounds style:UITableViewStyleGrouped];
        [_tableView setSeparatorColor:self.param.wLineColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (UIPickerView *)pickView{
    if (!_pickView) {
        _pickView = [[UIPickerView alloc]initWithFrame:self.bounds];
        _pickView.delegate = self;
        _pickView.dataSource = self;
        _pickView.showsSelectionIndicator = YES;
    }
    return _pickView;
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
