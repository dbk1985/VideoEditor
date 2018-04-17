//
//  ASHCollectionViewController.m
//  ASHSpringyCollectionView
//
//  Created by Ash Furrow on 2013-08-12.
//  Copyright (c) 2013 Ash Furrow. All rights reserved.
//

#import "ASHCollectionViewController.h"
#import "ASHSpringyCollectionViewFlowLayout.h"
#import "ASHSmallCell.h"

@interface ASHCollectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end

@implementation ASHCollectionViewController

static NSString *smallCellIdentifier = @"smallCell";
static NSString *bigCellIdentifier = @"bigCell";
static NSString *largerCellIdentifier = @"largerCell";

- (void)viewDidLoad
{
    [super viewDidLoad];

   ASHSpringyCollectionViewFlowLayout *layout = [[ASHSpringyCollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 80, CGRectGetWidth(self.view.frame), 25) collectionViewLayout:layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [self.view addSubview:collectionView];
	// Do any additional setup after loading the view.
    [collectionView registerClass:[ASHSmallMarkCell class] forCellWithReuseIdentifier:smallCellIdentifier];
    [collectionView registerClass:[ASHBigMarkCell class] forCellWithReuseIdentifier:bigCellIdentifier];
    [collectionView registerClass:[ASHLargerMarkCell class] forCellWithReuseIdentifier:largerCellIdentifier];
    collectionView.backgroundColor = [UIColor grayColor];
}

#pragma mark - UICollectionViewDataSource Methods

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10000;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.item;
    if ((row + 1) % 10 == 0) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:largerCellIdentifier forIndexPath:indexPath];
        return cell;
    }
    if ((row + 1) % 5 == 0) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:bigCellIdentifier forIndexPath:indexPath];
        return cell;
    }

    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:smallCellIdentifier forIndexPath:indexPath];

    return cell;
}

@end
