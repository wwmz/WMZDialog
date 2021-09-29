//
//  CollectionViewPopDemo.m
//  WMZDialog
//
//  Created by wmz on 2019/12/22.
//  Copyright © 2019 wmz. All rights reserved.
//
#define random1(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]
#define randomColor1 random1(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
#import "CollectionViewPopDemo.h"
#import "WMZDialog.h"
static NSString *const CollectionViewHeadView = @"CollectionViewHeadView";
static NSString *const CollectionViewFootView = @"CollectionViewFootView";
static NSString *const CollectionViewCell = @"CollectionViewCell";
@interface CollectionViewPopDemo ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property(nonatomic,strong)UICollectionView *collectionView;
@end

@implementation CollectionViewPopDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:CollectionViewCell];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CollectionViewHeadView];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:CollectionViewFootView];
}

#pragma -mark HeaderView使用
- (void)tapAction:(UIButton*)btn{
    Dialog()
    .wTypeSet(DialogTypePop)
    .wTapViewTypeSet(DiaPopInViewCollectionView)
    .wShowAnimationSet(AninatonZoomIn)
    .wHideAnimationSet(AninatonZoomOut)
    .wTapViewSet(btn)
    .wDataSet(@[
    @{@"name":@"微信",@"image":@"wallet"},
    @{@"name":@"支付宝",@"image":@"aaa"},
    @{@"name":@"米聊",@"image":@"bbb"},
    @{@"name":@"微信1",@"image":@"wallet"},
    ])
    .wStart();
}

//cell点击
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
       UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
       Dialog()
       .wTypeSet(DialogTypePop)
       .wTapViewTypeSet(DiaPopInViewCollectionView)
       .wShowAnimationSet(AninatonZoomIn)
       .wHideAnimationSet(AninatonZoomOut)
       .wTapViewSet(cell)
       .wDataSet(@[
       @{@"name":@"微信",@"image":@"wallet"},
       @{@"name":@"支付宝",@"image":@"aaa"},
       @{@"name":@"米聊",@"image":@"bbb"},
       @{@"name":@"微信1",@"image":@"wallet"},
       ])
       .wStart();
}

//cell上控件的弹窗
- (void)cellBtnTap:(UIButton*)sender{
    Dialog()
    .wTypeSet(DialogTypePop)
    .wTapViewTypeSet(DiaPopInViewCollectionView)
    .wShowAnimationSet(AninatonZoomIn)
    .wHideAnimationSet(AninatonZoomOut)
    .wDirectionSet(directionright)
    .wTapViewSet(sender)
    .wTagSet(10086) //设置tag防止重复弹窗
    .wDataSet(@[
       @{@"name":@"微信",@"image":@"wallet"},
       @{@"name":@"支付宝",@"image":@"aaa"},
       @{@"name":@"米聊",@"image":@"bbb"},
       @{@"name":@"微信1",@"image":@"wallet"},
       ])
    .wStart();
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = (UICollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CollectionViewCell forIndexPath:indexPath];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(30, 15, 80, 50);
    [cell.contentView addSubview:btn];
    [btn setTitle:@"点我弹出" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(cellBtnTap:) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = randomColor1;
    cell.backgroundColor = randomColor1;
    return cell;
        
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 10;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader){
        UICollectionReusableView *head = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:CollectionViewHeadView forIndexPath:indexPath];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(DialogScreenW-200, 0, DialogScreenW/3, 50);
        btn.tag = indexPath.section;
        [head addSubview:btn];
        [btn setTitle:@"头部点我弹出" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
        head.backgroundColor = randomColor1;
        return head;
    }else{
        UICollectionReusableView *head = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:CollectionViewFootView forIndexPath:indexPath];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(DialogScreenW-200, 0, DialogScreenW/3, 50);
        btn.tag = indexPath.section;
        [head addSubview:btn];
        [btn setTitle:@"尾部点我弹出" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
        head.backgroundColor = randomColor1;
        return head;
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(DialogScreenW,50);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(DialogScreenW,50);
}


- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flow = [UICollectionViewFlowLayout new];
        flow.itemSize = CGSizeMake(DialogScreenW/2 - 30, 100);
        flow.minimumLineSpacing = 10;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 100, DialogScreenW, DialogScreenH-100) collectionViewLayout:flow];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    return _collectionView;
}

@end
