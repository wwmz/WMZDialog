//
//  WMZDiaLogBase.h
//  WMZDialog
//
//  Created by wmz on 2019/6/21.
//  Copyright © 2019年 wmz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WMZDialogMacro.h"
#import "WMZDialogTool.h"
#import "WMZDialogAnimation.h"
#import "WMZDialogShareView.h"
#import "WMZDialogTableView.h"
#import "NSDate+WMZCalendarDate.h"
#import "CalanderModel.h"

NS_ASSUME_NONNULL_BEGIN
//树形节点model
@interface WMZTree:NSObject
//深度
@property(nonatomic,assign)NSInteger depth;
//名字
@property(nonatomic,copy)NSString *name;
//对应id 唯一
@property(nonatomic,copy)NSString *ID;
//是否选中
@property(nonatomic,assign)BOOL isSelected;
//子集
@property(nonatomic,strong)NSMutableArray<WMZTree *> *children;

- (instancetype)initWithDetpth:(NSInteger)depth withName:(NSString*)name  withID:(NSString*)ID;
@end

//defaultCell
@interface DialogCell:UITableViewCell
//是否选中
@property(nonatomic,assign)BOOL isSelected;
//是否选中
@property(nonatomic,strong)id model;
@end


@interface WMZDiaLogBase : UIView
/*
 *标题
 */
@property(nonatomic,strong)UILabel *titleLabel;
/*
 *确定按钮
 */
@property(nonatomic,strong)UIButton *OKBtn;
/*
 *取消按钮
 */
@property(nonatomic,strong)UIButton *cancelBtn;
/*
 *关闭按钮
 */
@property(nonatomic,strong)UIButton *wCloseBtn;
/*
 *主要文本
 */
@property(nonatomic,strong)UILabel *textLabel;
/*
 *主要视图
 */
@property(nonatomic,strong)UIView *mainView;
/*
 *tableView
 */
@property(nonatomic,strong)WMZDialogTableView *tableView;
/*
 *pickView
 */
@property (nonatomic, strong) UIPickerView *pickView;
/*
 *自动布局
 */
@property (nonatomic, strong)UICollectionViewFlowLayout *layout;
/*
*表格视图
*/
@property (nonatomic, strong)UICollectionView *collectionView;
/*
 *阴影
 */
@property(nonatomic,strong)UIView *shadowView;
/*
 *底部
 */
@property(nonatomic,strong)UIView *bottomView;
/*
 *顶部
 */
@property(nonatomic,strong)UIView *diaLogHeadView;
/*
 *毛玻璃
 */
@property(nonatomic,strong)UIVisualEffectView *effectView;
/*
 *键盘高度
 */
@property(nonatomic,assign)CGFloat keyBoardHeight;

/*
 *转化为树形数据
 */
@property(nonatomic,strong)WMZTree *tree;


/*
 *树形数据深度
 */
@property (nonatomic, assign) NSInteger depth;

/*
 *加锁
 */
@property(nonatomic,strong)NSConditionLock *theLock;
/*
 *已经关闭
 */
@property (nonatomic, assign) BOOL close;
/*
 *选中的数组
 */
@property (nonatomic, strong) NSMutableArray *selectArr;

/*
 *选中的path数组
 */
@property (nonatomic, strong) NSMutableArray *pathArr;

/*
 *占位数组
 */
@property (nonatomic, strong) NSMutableArray *tempArr;

/*
 *数据数组
 */
@property (nonatomic, strong) NSMutableArray *dataArr;

/*
 *bundle
 */
@property (nonatomic, strong)NSBundle *dialogBundle;
/*
*最大时间
*/
@property(nonatomic,strong)UITextField *payField;
/*
 *初始point
 */
@property (nonatomic, assign)CGPoint normalPoint;

/*
 *在可滑动视图上
 */
@property(nonatomic,strong)UIScrollView *popInScrollView;
/*
*pop点击的frame 如果pop位置不准确可以改变此
*/
@property(nonatomic,assign)CGRect tapRect;

/*
*最小时间
*/
@property(nonatomic,strong)NSMutableDictionary *minDate;
/*
*最大时间
*/
@property(nonatomic,strong)NSMutableDictionary *maxDate;
/*
 *关闭
 */
- (void)closeView;
/*
 *开始
 */
- (void)showView:(nullable UIView*)showView;
- (void)closeView:(nullable animalBlock)block;
/*
 *添加底部
 */
- (UIView*)addBottomView:(CGFloat)maxY;

/*
*添加顶部
*/
- (UIView*)addTopView;

/*
 *重新设置mainView的frame 如果不是在底部默认居中
 */
- (void)reSetMainViewFrame:(CGRect)frame;


/*
 * 更新下载进度条
 *
 * @param  value  值
 *
 */
- (BOOL)updateAlertTypeDownProgress:(CGFloat)value;


/*
 * 更新下拉菜单数据 用于外部传入数据 只更新下一列的数据 下下列的数据不变
 *
 * @param  section  列
 * @param  update  是否更新子列表数组
 * @param  data   数据
 *
 */
- (void)updateMenuChildrenDataWithSection:(NSInteger)section  withUpdateChildren:(BOOL)update withData:(NSArray*)data;
/*
 * 获取树形结构的数据层
 *
 */
- (id)getMyDataArr:(NSInteger )tableViewTag withType:(NSInteger)type;
/*
 * 树形结构的点击事件
 *
 */
- (void)selectWithTableView:(UITableView *)tableView withIndexPath:(NSIndexPath*)indexPath;

/*
 * 获取树形结构的选中的数据
 *
 */
- (NSArray*)getTreeSelectDataArr:(BOOL)first;

/*
 * 显示动画处理
 *
 */
- (void)dealAnamtionShowWithView:(UIView*)view withType:(DialogShowAnination)type withTime:(NSTimeInterval)time block:(animalBlock)block;

/*
 * 隐藏动画处理
 *
 */
- (void)dealAnamtionHideWithView:(UIView*)view withType:(DialogHideAnination)type withTime:(NSTimeInterval)time block:(animalBlock)block;

/*
* 回到今天  日历外部调用方法
*
*/
- (void)scrollToToday;
@end

NS_ASSUME_NONNULL_END
