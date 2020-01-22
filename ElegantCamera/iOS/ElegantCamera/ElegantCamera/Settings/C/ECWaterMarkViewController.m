//
//  ECWaterMarkViewController.m
//  ElegantCamera
//
//  Created by Aka on 2019/11/13.
//  Copyright © 2019 Aka. All rights reserved.
//

#import "ECWaterMarkViewController.h"
#import "ECBaseCV.h"

@interface ECWaterMarkCCell : ECBaseCCell

@property (nonatomic, strong) UIImageView *imgView;

@end

@implementation ECWaterMarkCCell

- (void)baseInit {
    [super baseInit];
    
    _imgView = [UIImageView new];
    [self.contentView addSubview:_imgView];
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    _imgView.contentMode = UIViewContentModeScaleAspectFill;
}

@end


@interface ECWaterMarkViewTCell: ECBaseTCell

@property (nonatomic, strong) ECBaseCV *collectionView;

@end

@implementation ECWaterMarkViewTCell

- (void)baseInit {
    [super baseInit];
    
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumLineSpacing = 10.f;
    flowLayout.minimumInteritemSpacing = 10.f;
    _collectionView = [[ECBaseCV alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    [self.contentView addSubview:_collectionView];
    _collectionView.backgroundColor = [UIColor clearColor];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    kCV_registerWithClassCell(_collectionView, ECWaterMarkCCell);
}

@end

static NSInteger const kTableSectionNum = 3;

@interface ECWaterMarkViewController ()<UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) ECBaseTV *tableView;

@property (nonatomic, strong) NSArray<NSString *> *simples;
@property (nonatomic, strong) NSArray<NSString *> *sceneries;
@property (nonatomic, strong) NSArray<NSString *> *lovelies;

@end

@implementation ECWaterMarkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _simples = @[@"0",@"0",@"0",@"0",@"0",@"0"];
    _sceneries = @[@"0",@"0",@"0",@"0",@"0",@"0"];
    _lovelies = @[@"0",@"0",@"0",@"0",@"0",@"0"];

    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"水印";
    _tableView = [[ECBaseTV alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    kTV_registerClassCellDefaultName(self.tableView, ECWaterMarkViewTCell);
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view).offset(NAVIGATION_STATUS_HEIGHT);
    }];
    _tableView.sectionHeaderHeight = KMWidth(33.f);
    _tableView.sectionFooterHeight = CGFLOAT_MIN;
    
    if (@available(iOS 11.0, *)) {
      self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
      self.automaticallyAdjustsScrollViewInsets = NO;
    }
}


#pragma mark -- tableview datasource & delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return kTableSectionNum;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return KMWidth(80.f);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ECWaterMarkViewTCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ECWaterMarkViewTCell class]) forIndexPath:indexPath];
    cell.collectionView.tag = indexPath.section;
    cell.collectionView.dataSource = self;
    cell.collectionView.delegate = self;
    [cell.collectionView reloadData];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return KMWidth(33.f);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"简洁";
    }
    else if (section == 1) {
        return @"风景";
    }
    else {
        return @"可爱";
    }
}

#pragma mark -- collectionView datasource & delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView.tag == 0) {
        return _simples.count;
    }
    else if (collectionView.tag ==1) {
        return _sceneries.count;
    }
    else {
        return _lovelies.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ECWaterMarkCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ECWaterMarkCCell class]) forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor redColor];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
     return CGSizeMake(KMWidth(79.f), KMWidth(79.f));
}

@end
