//
//  CalanderVC.m
//  WMZDialog
//
//  Created by wmz on 2019/11/8.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "CalanderVC.h"
#import "WMZDialog.h"
@interface CalanderVC ()

@end

@implementation CalanderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArr = @[@"普通日历",@"纵向滚动",@"显示操作",@"隐藏农历",@"显示圆点自定义颜色",@"多选",@"多选(多块区域)",@"显示在底部",@"自定义",@"最大值最小值"];
}

- (void)action:(UIButton*)sender{
    
    switch (sender.tag) {
        case 0:{
            Dialog().wTypeSet(DialogTypeCalander).wStart();
        }
            break;
        case 1:{
            Dialog()
            /// 纵向滚动
            .wDirectionVerticalSet(YES)
            .wTypeSet(DialogTypeCalander)
            .wStart();
        }
            break;
        case 2:{
            Dialog()
            ///自定义周期
            .wCalanderWeekTitleArrSet(@[@"日",@"一",@"二",@"三",@"四",@"五",@"六"])
            ///自定义Size
            .wCalanderCellSizeSet(CGSizeMake(45 , 45))
            /// 显示操作
            .wHideCalanderBtnSet(NO)
            .wTypeSet(DialogTypeCalander)
            .wStart();
        }
            break;
        case 3:{
            Dialog()
            /// 隐藏农历
            .wOpenChineseDateSet(NO)
            .wTypeSet(DialogTypeCalander)
            .wStart();
        }
            break;
        case 4:{
            Dialog()
            .wTypeSet(DialogTypeCalander)
            .wDateShowCircleSet(@[
            @{@"date":[NSDate dateWithTimeIntervalSinceNow:-3*24*60*60],@"color":[UIColor redColor]},
            @{@"date":[NSDate date]},
            @{@"date":[NSDate dateWithTimeIntervalSinceNow:24*60*60],@"color":[UIColor greenColor]},
            @{@"date":[NSDate dateWithTimeIntervalSinceNow:3*24*60*60],@"color":[UIColor cyanColor]},
            ])
            .wStart();
        }
            break;
        case 5:{
            Dialog()
            .wTypeSet(DialogTypeCalander)
            .wEventOKFinishSet(^(id anyID, id otherData) {
                
            })
            /// 多选
            .wMultipleSelectionSet(YES)
            /// 关闭多选多块区域 有连续性 
            .wOpenMultiZoneSet(NO)
            /// 主题色
            .wOKColorSet(DialogColor(0x0096ff))
            /// 默认选中
            .wListDefaultValueSet(@[
                [NSDate dateWithTimeIntervalSinceNow:-3*24*60*60],
                [NSDate date],
                [NSDate dateWithTimeIntervalSinceNow:24*60*60],
                [NSDate dateWithTimeIntervalSinceNow:3*24*60*60],
                ])
            .wStart();
        }
            break;
        case 6:{
            Dialog()
            .wTypeSet(DialogTypeCalander)
            /// 多选
            .wMultipleSelectionSet(YES)
            /// 开启多选多块区域
            .wOpenMultiZoneSet(YES)
            /// 中间区域透明度0.4 默认为1 不透明
            .wLimitAlphaSet(0.4)
            /// 主题色
            .wOKColorSet(DialogColor(0x0096ff))
            /// 默认选中
            .wListDefaultValueSet(@[
                [NSDate dateWithTimeIntervalSinceNow:-3*24*60*60],
                [NSDate date],
                [NSDate dateWithTimeIntervalSinceNow:24*60*60],
                [NSDate dateWithTimeIntervalSinceNow:2*24*60*60],
                [NSDate dateWithTimeIntervalSinceNow:3*24*60*60],
                [NSDate dateWithTimeIntervalSinceNow:6*24*60*60],
                ])
            .wStart();
        }
            break;
        case 7:{
            Dialog()
            /// 显示在底部
            .wMainToBottomSet(YES)
            .wTypeSet(DialogTypeCalander)
            .wStart();
        }
            break;
        case 8:{
            Dialog()
            .wTypeSet(DialogTypeCalander)
            //自定义宽度
            .wWidthSet(320)
            //注册cell
            .wReginerCollectionCellSet(@"MyCalanderCell")
            //自定义cell
            .wCalanderCellSet(^UICollectionViewCell *(NSIndexPath *indexPath, UICollectionView *collection, WMZCalanderModel* model) {
                MyCalanderCell *cell = [collection dequeueReusableCellWithReuseIdentifier:@"MyCalanderCell" forIndexPath:indexPath];
                cell.dateLable.text = [NSString stringWithFormat:@"%ld",(long)model.wDay];
                cell.dateLable.backgroundColor = [UIColor clearColor];
                //上个月和下个月的数据
                if (model.wLastMonth||model.wNextMonth) {
                    cell.dateLable.textColor = DialogDarkColor(DialogColor(0x999999), DialogColor(0x333333));
                }else{
                    //选中改变背景颜色
                    if (model.wSelected) {
                        cell.dateLable.backgroundColor = DialogColor(0x0096ff);
                    }
                    cell.dateLable.textColor = DialogDarkColor(DialogColor(0x333333), DialogColor(0xffffff));;
                }
                return cell;
            })
            //自定义点击方法
            .wCalanderCellClickSet(^(NSIndexPath *indexPath, UICollectionView *collection, id model) {})
            .wMaxDateSet([NSDate date])
            .wStart();
        }
            break;
        case 9:{   ///使用param 例子
            NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
            NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
            [dateComponents setMonth:+1];
            [dateComponents setYear:+1];
            NSDate *maxDate = [gregorian dateByAddingComponents:dateComponents toDate:[NSDate date] options:0];
            
            WMZDialogParam *param = WMZDialogParam.new;
            param.wDefaultDate = [NSDate date];
            param.wMaxDate = maxDate;
            param.wMinDate = [NSDate date];
            ///最大最小值效果 默认为不可点击
            param.wMinMaxResultArr = @[DialogCalanderLimitCloseClick,DialogCalanderLimitGray,DialogCalanderLimitCloseScroll];
            param.wType = DialogTypeCalander;
            param.wHideCalanderBtn = NO;
            Dialog().wStartParam(param);
        }
            break;
        default:
            break;
    }
}


@end

@implementation MyCalanderCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self UI];
    }
    return self;
}

- (void)UI{
     [self addSubview:self.dateLable];
     self.dateLable.layer.masksToBounds = YES;
     self.dateLable.frame = CGRectMake((self.frame.size.width-self.frame.size.height*0.6)/2, self.frame.size.height/4, self.frame.size.height*0.6, self.frame.size.height*0.6);
     self.dateLable.layer.cornerRadius = self.frame.size.height*0.3;
}

- (UILabel *)dateLable{
    if (!_dateLable) {
        _dateLable = [UILabel new];
        [_dateLable setTextAlignment:NSTextAlignmentCenter];
        [_dateLable setFont:[UIFont fontWithName:@"Helvetica-Bold" size:19.0]];
        _dateLable.textColor = DialogColor(0x333333);
    }
    return _dateLable;
}
@end
