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
    self.dataArr = @[@"普通日历",@"纵向滚动",@"显示操作",@"隐藏农历",@"显示圆点",@"显示自定义颜色圆点",@"多选",@"显示在底部",@"自定义(设置不可选)",@"最大值最小值"];
}

- (void)action:(UIButton*)sender{
    
    //最大值最小值
    if (sender.tag == 9) {
        
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
        [dateComponents setMonth:-1];
        NSDate *minDate = [gregorian dateByAddingComponents:dateComponents toDate:[NSDate date] options:0];
        
        Dialog()
        .wMaxDateSet([NSDate date])
        .wMinDateSet(minDate)
        .wTypeSet(DialogTypeCalander)
        .wHideCalanderBtnSet(NO)
        .wStart();
        return;
    }
    
    
    WMZDialog *alert =
    Dialog()
    .wTypeSet(DialogTypeCalander);

    if (sender.tag == 2) {  //显示操作
        //隐藏日历上的按钮
        alert.wHideCalanderBtnSet(NO);
    }else if (sender.tag == 3) { //隐藏农历
        alert.wOpenChineseDateSet(NO);
    }else if (sender.tag == 1) { //纵向滚动
        alert.wDirectionVerticalSet(YES);
    }else if (sender.tag == 4) { //默认带圆点
        alert.wDateShowCircleSet(@[[NSDate dateWithTimeIntervalSinceNow:-3*24*60*60],[NSDate date],[NSDate dateWithTimeIntervalSinceNow:24*60*60],[NSDate dateWithTimeIntervalSinceNow:3*24*60*60]]);
    }else if (sender.tag == 5) { //显示自定义颜色圆点
        alert.wDateShowCircleSet(@[
        @{@"date":[NSDate dateWithTimeIntervalSinceNow:-3*24*60*60],@"color":[UIColor redColor]},
        @{@"date":[NSDate date]},
        @{@"date":[NSDate dateWithTimeIntervalSinceNow:24*60*60],@"color":[UIColor greenColor]},
        @{@"date":[NSDate dateWithTimeIntervalSinceNow:3*24*60*60],@"color":[UIColor cyanColor]},
        ]);
    }else if (sender.tag ==6) { //多选
        alert.wMultipleSelectionSet(YES);
    }else if (sender.tag ==7) { //显示在底部
        alert.wMainToBottomSet(YES);
    }else if (sender.tag ==8) { //显示在底部
        alert
        //自定义宽度
        .wWidthSet(320)
        //注册cell
        .wReginerCollectionCellSet(@"MyCalanderCell")
        //自定义cell
        .wCalanderCellSet(^UICollectionViewCell *(NSIndexPath *indexPath, UICollectionView *collection, CalanderModel* model) {
            MyCalanderCell *cell = [collection dequeueReusableCellWithReuseIdentifier:@"MyCalanderCell" forIndexPath:indexPath];
            cell.dateLable.text = [NSString stringWithFormat:@"%ld",model.wDay];
            cell.dateLable.backgroundColor = [UIColor whiteColor];
            //上个月和下个月的数据
            if (model.wLastMonth||model.wNextMonth) {
                cell.dateLable.textColor = DialogColor(0x999999);
            }else{
                //选中改变背景颜色
                if (model.wSelected) {
                    cell.dateLable.backgroundColor = DialogColor(0x0096ff);
                }
                cell.dateLable.textColor = DialogColor(0x333333);
            }
            int maxResult = [NSDate compareOneDay:model.wDate withAnotherDay:[NSDate date]];
            if (maxResult == 1) {
                cell.dateLable.textColor = [UIColor lightGrayColor];
            }
            return cell;
        })
        //自定义点击方法
        .wCalanderCellClickSet(^(NSIndexPath *indexPath, UICollectionView *collection, id model) {})
        .wMaxDateSet([NSDate date])
        .wStart();
        return;
    }
    
    alert
    .wTitleSet(@"日历")
    //确定的点击方法
    .wEventOKFinishSet(^(id anyID, id otherData) {
        NSLog(@"%@ %@",anyID,otherData);
    })
    //开启滚动 default YES
    .wCalanderCanScrollSet(YES)
    //标题颜色
    .wMessageColorSet(DialogColor(0x0096ff))
    //改变主题色
    .wOKColorSet(DialogColor(0x0096ff))
    .wStart();

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
