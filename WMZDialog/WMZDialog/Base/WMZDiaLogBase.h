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
#import <objc/runtime.h>
#import "WMZDialogAnimation.h"
#import "WMZDialogShareView.h"
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



@interface WMZDiaLogBase : UIViewController
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
@property(nonatomic,strong)UITableView *tableView;
/*
 *pickView
 */
@property (nonatomic, retain) UIPickerView *pickView;
/*
 *阴影
 */
@property(nonatomic,strong)UIView *shadowView;
/*
 *底部
 */
@property(nonatomic,strong)UIView *bottomView;
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
 *bundle
 */
@property (nonatomic, strong)NSBundle *dialogBundle;


/*
 *关闭
 */
- (void)closeView;

/*
 *添加底部
 */
- (UIView*)addBottomView:(CGFloat)maxY;

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
 * 获取年月对应的天数
 *
 */
- (NSArray*)timeDayWithArr:(NSArray*)arr withName:(NSString*)name;

/*
 * 显示动画处理
 *
 */
- (void)dealAnamtionShowWithView:(UIView*)view withType:(DialogShowAnination)type withTime:(NSTimeInterval)time;

/*
 * 隐藏动画处理
 *
 */
- (void)dealAnamtionHideWithView:(UIView*)view withType:(DialogHideAnination)type withTime:(NSTimeInterval)time;
@end

NS_ASSUME_NONNULL_END
