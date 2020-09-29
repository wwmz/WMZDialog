//
//  WMZDialog+Location.m
//  WMZDialog
//
//  Created by wmz on 2019/8/14.
//  Copyright © 2019年 wmz. All rights reserved.
//

#import "WMZDialog+Location.h"
@interface WMZDialog()<NSXMLParserDelegate>
@end
@implementation WMZDialog (Location)

- (UIView*)locationAction{
    self.tree = [WMZTree new];
    self.tree.depth = 0;


    NSString *path = [self.dialogBundle pathForResource:@"province_data" ofType:@"xml"];
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:[NSData dataWithContentsOfFile:path]];
    parser.delegate = self;
    
    [self.theLock lock];
    [parser parse];
    //添加UI
    if (self.wChainType == ChainTableView) {
            UITableView *temp = nil;
            for (int i = 0; i<self.depth; i++) {
                UITableView *ta = [[UITableView alloc]initWithFrame:CGRectMake(!temp?0:CGRectGetMaxX(temp.frame), 0, self.wWidth/self.depth, self.wHeight) style:UITableViewStyleGrouped];
                if (self.wTableViewColor&&i<self.wTableViewColor.count) {
                    ta.backgroundColor = self.wTableViewColor[i];
                }
                ta.delegate = self;
                ta.dataSource = self;
                ta.rowHeight = self.wMainBtnHeight;
                ta.tag = 100+i;
                ta.separatorStyle = UITableViewCellSeparatorStyleNone;
                ta.estimatedRowHeight = 100;
                if (@available(iOS 11.0, *)) {
                    ta.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
                    ta.estimatedSectionFooterHeight = 0.01;
                    ta.estimatedSectionHeaderHeight = 0.01;
                }
                temp = ta;
                [self.mainView addSubview:ta];
                if (!self.wListDefaultValue) {
                    if (i>0) ta.hidden = YES;
                }
            }
            [self reSetMainViewFrame:CGRectMake(0,self.wTapView?CGRectGetMaxY(self.wTapView.frame):0,self.wWidth, CGRectGetMaxY(temp.frame))];
    }else{
        self.wPickRepeat = NO;
        
        self.diaLogHeadView = [self addTopView];
        [self.OKBtn addTarget:self action:@selector(locationPickOKAction:) forControlEvents:UIControlEventTouchUpInside];
        
        self.pickView.frame =  CGRectMake(0, CGRectGetMaxY(self.diaLogHeadView.frame), self.wWidth, self.wHeight);
        [self.mainView addSubview:self.pickView];
        [self reSetMainViewFrame:CGRectMake(0,0,self.wWidth, CGRectGetMaxY(self.pickView.frame))];
        //设置只有一半圆角
        [WMZDialogTool setView:self.mainView radio:CGSizeMake(self.wMainRadius,self.wMainRadius) roundingCorners:UIRectCornerTopLeft |UIRectCornerTopRight];
        
    }
    
    if (self.wListDefaultValue) {
        [self.wListDefaultValue enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger component, BOOL * _Nonnull stop) {
            if (self.wLocationType>component) {
                NSMutableArray *dataArr = [self getMyDataArr:component+100 withType:0];
                 NSInteger row = NSNotFound;
                 if ([obj isKindOfClass:[NSNumber class]]) {
                     NSInteger num = [obj intValue];
                     if (dataArr.count>num) {
                         row = num;
                     }
                 }else if([obj isKindOfClass:[NSString class]]){
                     for (int i = 0 ; i<dataArr.count; i++) {
                         WMZTree *tree = dataArr[i];
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
                      WMZTree *tree = dataArr[i];
                      if (i == row) {
                          tree.isSelected = YES;
                      }else{
                          tree.isSelected = NO;
                      }
                  }
                 if (component<self.depth-1) {
                     WMZTree *selectTree =  dataArr[self.wPickRepeat?row%dataArr.count:row];
                     for (WMZTree *tree in selectTree.children) {
                         tree.isSelected = NO;
                     }
                 }
                 if (self.wChainType == ChainPickView) {
                     if (row!=NSNotFound) {
                        [self.pickView selectRow:row inComponent:component animated:YES];
                     }
                 }else{
                     if (row!=NSNotFound) {
                         UITableView *ta  = [self.mainView viewWithTag:component+100];
                         if ([ta isKindOfClass:[UITableView class]]) {
                             [ta scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:NO];
                             [ta selectRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
                         }
                     }
                 }
            }
        }];
    }
    return self.mainView;
}
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    NSDictionary *dic = @{
                          @"province":@(1),
                          @"city":@(2),
                          @"district":@(3),
                          };
    WMZTree *tree = [[WMZTree alloc]initWithDetpth:[[dic objectForKey:elementName] integerValue] withName:attributeDict[@"name"]?:@"" withID:attributeDict[@"zipcode"]?:@""];
    NSInteger num = [[dic objectForKey:elementName] integerValue];
    if ([elementName isEqualToString:@"province"]&&self.wLocationType >= num) {
        [self.tree.children addObject:tree];
         self.depth = num;
    } else if ([elementName isEqualToString:@"city"]&&self.wLocationType >= num) {
        WMZTree *parentTree = self.tree.children.lastObject;
        [parentTree.children addObject:tree];
         self.depth = num;
    } else if ([elementName isEqualToString:@"district"]&&self.wLocationType >= num) {
        WMZTree *parentTree = self.tree.children.lastObject;
        WMZTree *p_parentTree = parentTree.children.lastObject;
        [p_parentTree.children addObject:tree];
        self.depth = num;
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    [self.theLock unlock];
}


//重设确定的方法
- (void)locationPickOKAction:(UIButton*)btn{
    DialogWeakSelf(self)
    [weakObject closeView:^{
        if (weakObject.wEventOKFinish) {
            NSArray *arr = [weakObject getTreeSelectDataArr:(weakObject.wChainType == ChainTableView)?NO:YES];
            NSMutableString *string = [NSMutableString stringWithString:@""];
            for (WMZTree *tree in arr) {
                if (!string.length) {
                    [string appendString:tree.name];
                }else{
                    [string appendFormat:@"%@", [NSString stringWithFormat:@"%@%@",weakObject.wSeparator,tree.name]];
                }
            }
           weakObject.wEventOKFinish(arr, string);
        }
    }];
}

@end
