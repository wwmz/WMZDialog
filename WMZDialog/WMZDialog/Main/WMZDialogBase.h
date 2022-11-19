//
//  WMZDialogBase.h
//  WMZDialog
//
//  Created by wmz on 2019/6/21.
//  Copyright © 2019年 wmz. All rights reserved.
//

#import "WMZDialogMacro.h"
#import "WMZDialogUntils.h"
#import "WMZDialogAnimation.h"
#import "WMZDialogManage.h"
#import "WMZDialogNormal.h"
#import "WMZDialogTree.h"

NS_ASSUME_NONNULL_BEGIN
@interface WMZDialogBase : UIView
/// 配置
@property (nonatomic, copy, readonly) NSDictionary <NSNumber* , NSString*> *configDic;
/// 属性
@property (nonatomic, strong) WMZDialogParam *param;
/// 主要视图
@property (nonatomic, strong) WMZDialogNormal *mainView;
/// 阴影
@property (nonatomic, strong) UIView *shadowView;
/// 毛玻璃
@property (nonatomic, strong) UIVisualEffectView *effectView;
/// 键盘高度
@property (nonatomic, assign) CGFloat keyBoardHeight;
/// 初始frame
@property (nonatomic, assign) CGRect normalRect;
/// 旧frame
@property (nonatomic, assign) CGRect beforeRect;
/// 已经关闭
@property (nonatomic, assign, getter = isClose) BOOL close;
/// 开启暗黑模式
@property (nonatomic, assign) BOOL wOpenDark;
/// 更新下载进度条
/// @param  value  值
- (BOOL)updateAlertTypeDownProgress:(CGFloat)value;
/// 更新下拉菜单数据 用于外部传入数据 只更新下一列的数据 下下列的数据不变
/// @param  section  列
/// @param  update  是否更新子列表数组
/// @param  data   数据
- (void)updateMenuChildrenDataWithSection:(NSInteger)section  withUpdateChildren:(BOOL)update withData:(NSArray*)data;
/// 显示动画处理
- (void)dealAnamtionShowWithView:(UIView*)view withType:(DialogShowAnination)type withTime:(NSTimeInterval)time block:(AnimalBlock)block;
/// 隐藏动画处理
- (void)dealAnamtionHideWithView:(UIView*)view withType:(DialogHideAnination)type withTime:(NSTimeInterval)time block:(AnimalBlock)block;

@end

NS_ASSUME_NONNULL_END
