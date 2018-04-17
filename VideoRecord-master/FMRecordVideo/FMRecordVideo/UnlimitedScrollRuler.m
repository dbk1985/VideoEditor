//
//  UnlimitedScrollRuler.m
//  FMRecordVideo
//
//  Created by wzkj on 2018/4/17.
//  Copyright © 2018年 SF. All rights reserved.
//

#import "UnlimitedScrollRuler.h"

#define kSpace 5

@interface CollectionViewFlowLayout : UICollectionViewFlowLayout

@end

@implementation CollectionViewFlowLayout

- (void)prepareLayout
{
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.minimumLineSpacing = kSpace;
    self.sectionInset = UIEdgeInsetsMake(0, kSpace, 0, 0);
//    self.itemSize = CGSizeMake(kItemWidth,
//                               self.collectionView.frame.size.height-kHeightSpace*2);
    [super prepareLayout];
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *attrs = [self deepCopyWithArray:[super layoutAttributesForElementsInRect:rect]];
    CGFloat contentOffsetX = self.collectionView.contentOffset.x;
    CGFloat collectionViewCenterX = self.collectionView.frame.size.width * 0.5;
    for (UICollectionViewLayoutAttributes *attr in attrs) {
        CGFloat scale = 1 - fabs(attr.center.x - contentOffsetX - collectionViewCenterX) /self.collectionView.bounds.size.width;
        attr.transform = CGAffineTransformMakeScale(scale, scale);
    }
    return attrs;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}
//  每次都有图片居中
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    CGRect rect = CGRectMake(proposedContentOffset.x, 0, self.collectionView.bounds.size.width,self.collectionView.bounds.size.height);
    NSArray *attrs = [super layoutAttributesForElementsInRect:rect];
    CGFloat contentOffsetX = self.collectionView.contentOffset.x;
    CGFloat collectionViewCenterX = self.collectionView.frame.size.width * 0.5;
    CGFloat minDistance = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attr in attrs) {
        CGFloat distance = attr.center.x - contentOffsetX - collectionViewCenterX;
        if (fabs(distance) < fabs(minDistance)) {
            minDistance = distance;
        }
    }
    proposedContentOffset.x += minDistance;
    return proposedContentOffset;
}

//  UICollectionViewFlowLayout has cached frame mismatch for index path这个警告来源主要是在使用layoutAttributesForElementsInRect：方法返回的数组时，没有使用该数组的拷贝对象，而是直接使用了该数组。解决办法对该数组进行拷贝，并且是深拷贝。
- (NSArray *)deepCopyWithArray:(NSArray *)arr {
    NSMutableArray *arrM = [NSMutableArray array];
    for (UICollectionViewLayoutAttributes *attr in arr) {
        [arrM addObject:[attr copy]];
    }
    return arrM;
}

// 单元格吸附效果
//-(CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
//
//{
//    //1.计算scrollview最后停留的范围
//    CGRect lastRect ;
//    lastRect.origin = proposedContentOffset;
//    lastRect.size = self.collectionView.frame.size;
//    //2.取出这个范围内的所有属性
//    NSArray *array = [self layoutAttributesForElementsInRect:lastRect];
//    //起始的x值，也即默认情况下要停下来的x值
//    CGFloat startX = proposedContentOffset.x;
//    //3.遍历所有的属性
//    CGFloat adjustOffsetX = MAXFLOAT;
//    for (UICollectionViewLayoutAttributes *attrs in array) {
//        CGFloat attrsX = CGRectGetMinX(attrs.frame); //单元格x
//        CGFloat attrsW = CGRectGetWidth(attrs.frame) ; //单元格宽度
//        if (startX - attrsX  < attrsW/2) { //小于一半
//            adjustOffsetX = -(startX - attrsX);
//        }else{
//            adjustOffsetX = attrsW - (startX - attrsX);
//        }
//        break ;//只循环数组中第一个元素即可，所以直接break了
//    }
//    return CGPointMake(proposedContentOffset.x + adjustOffsetX, proposedContentOffset.y);
//}



@end

@interface UnlimitedScrollRuler ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic,weak) UICollectionView *collectionView;
@end

@implementation UnlimitedScrollRuler

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        CollectionViewFlowLayout *layout = [[CollectionViewFlowLayout alloc] init];
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 60) collectionViewLayout:layout];
        [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        [self.view addSubview:collectionView];
        _collectionView = collectionView;
        //开始时让CollectionView滚动到一个中间位置
        //计算frame，确保Item居中
//        [_myCollectionView setContentOffset:CGPointMake((kItemWidth+kSpace)*kSectionCount/2-kItemSpace, 0)];
    }
    return _collectionView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidLayoutSubviews {

    [super viewDidLayoutSubviews];

//    self.layout.itemSize = CGSizeMake(100, 100);

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return 20;

}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger page = scrollView.contentOffset.x/scrollView.bounds.size.width;
    NSLog(@"滚动到：%zd",page);
    if (page == 0) {//滚动到左边
        scrollView.contentOffset = CGPointMake(scrollView.bounds.size.width * (20 - 2), 0);
//        _pageControl.currentPage = _titles.count - 2;
    }else if (page == 20 - 1){//滚动到右边
        scrollView.contentOffset = CGPointMake(scrollView.bounds.size.width, 0);
//        _pageControl.currentPage = 0;
    }else{
//        _pageControl.currentPage = page - 1;
    }
}


@end
