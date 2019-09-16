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
                ta.estimatedSectionFooterHeight = 0.01;
                ta.estimatedSectionHeaderHeight = 0.01;
                ta.rowHeight = self.wMainBtnHeight;
                ta.tag = 100+i;
                ta.separatorStyle = UITableViewCellSeparatorStyleNone;
                ta.estimatedRowHeight = 100.0f;
                if (@available(iOS 11.0, *)) {
                    ta.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
                }
                temp = ta;
                [self.mainView addSubview:ta];
                if (i>0) ta.hidden = YES;
            }
        
            [self reSetMainViewFrame:CGRectMake(0,self.wTapView?CGRectGetMaxY(self.wTapView.frame):0,self.wWidth, CGRectGetMaxY(temp.frame))];
            self.mainView.center = CGPointMake(self.view.center.x, self.mainView.center.y);
    }else{
        self.wPickRepeat = NO;
        UIView *headView = [UIView new];
        headView.backgroundColor = self.wMainBackColor;
        headView.frame = CGRectMake(0, 0, self.wWidth, self.wMainBtnHeight);
        [self.mainView addSubview:headView];
        
        [self.mainView addSubview:self.cancelBtn];
        self.cancelBtn.frame = CGRectMake(self.wMainOffsetX, 0, self.wWidth/2-self.wMainOffsetX, self.wMainBtnHeight);
        self.cancelBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        [self.mainView addSubview:self.OKBtn];
        [self.OKBtn removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
        [self.OKBtn addTarget:self action:@selector(locationPickOKAction:) forControlEvents:UIControlEventTouchUpInside];
        self.OKBtn.frame = CGRectMake(self.wWidth/2, 0,self.wWidth/2-self.wMainOffsetX, self.wMainBtnHeight);
        self.OKBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        
        
        self.pickView.frame =  CGRectMake(0, CGRectGetMaxY(headView.frame), self.wWidth, self.wHeight);
        [self.mainView addSubview:self.pickView];
        
        [self reSetMainViewFrame:CGRectMake(0,0,self.wWidth, CGRectGetMaxY(self.pickView.frame))];
        //设置只有一半圆角
        [WMZDialogTool setView:self.mainView Radii:CGSizeMake(self.wMainRadius,self.wMainRadius) RoundingCorners:UIRectCornerTopLeft |UIRectCornerTopRight];
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
    [self closeView];
    if (self.wEventOKFinish) {
        NSArray *arr = [self getTreeSelectDataArr:(self.wChainType == ChainTableView)?NO:YES];
        NSMutableString *string = [NSMutableString stringWithString:@""];
        for (WMZTree *tree in arr) {
            if (!string.length) {
                [string appendString:tree.name];
            }else{
                [string appendFormat:@"%@", [NSString stringWithFormat:@"%@%@",self.wSeparator,tree.name]];
            }
        }
       self.wEventOKFinish(arr, string);
    }
}

@end
