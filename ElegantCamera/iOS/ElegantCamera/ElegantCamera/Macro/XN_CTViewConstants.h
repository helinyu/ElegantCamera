//
//  XN_CTViewConstants.h
//  xndm_proj
//
//  独学而无友 则孤陋寡闻
//
//  Created by helinyu on 2019/6/21 18:44 .
//  Copyright © 2019 Linfeng Song. All rights reserved.
//  xcode 10.15 .
//
    

#ifndef XN_CTViewConstants_h
#define XN_CTViewConstants_h

#pragma mark -- tableView cro
//tableview
#define kTV_registerClassCell(tableView, cellClass, cellID) [tableView registerClass:[cellClass class] forCellReuseIdentifier:cellID]
#define kTV_registerClassCellDefaultName(tableView, cellClass) [tableView registerClass:[cellClass class] forCellReuseIdentifier:NSStringFromClass([cellClass class])]
#define kTV_ReuseCellDefaultName(tableView, cellClass) [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([cellClass class])]

#define kTV_registerXibCell(tableView, cellClass, cellID) [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([cellClass class]) bundle:nil] forCellReuseIdentifier:cellID];

#define kTV_registerCells(tableView, cellNames) \
    for (NSString *cellNameString in cellNames) { \
        kTV_registerClassCellDefaultName(tableView, NSClassFromString(cellNameString)); \
   }

// collectionView
#define kCV_registerClassCell(collectionView, cellClass, cellID) [collectionView registerClass:[cellClass class] forCellWithReuseIdentifier:cellID];
#define kCV_registerXibCell(collectionView, cellClass, cellID) [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([cellClass class]) bundle:nil] forCellWithReuseIdentifier:cellID];

// collectionView
#define kCV_registerClassIdentfierCell(collectionView, cellClass, cellID) [collectionView registerClass:[cellClass class] forCellWithReuseIdentifier:cellID]
#define kCV_registerWithClassCell(collectionView, cellClass) [collectionView registerClass:[cellClass class] forCellWithReuseIdentifier:NSStringFromClass([cellClass class])]

#define kCV_registerHeaderIdentifier(collectionView, HeaderView,identifier) [collectionView registerClass:[HeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identifier]
#define kCV_registerHeader(collectionView, HeaderView) kCV_registerHeaderIdentifier(collectionView,HeaderView,NSStringFromClass([HeaderView class]))

#define kCV_registerFooterIdentifier(collectionView, FooterView,identifier) [collectionView registerClass:[FooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:identifier]
#define kCV_registerFooter(collectionView, FooterView) kCV_registerFooterIdentifier(collectionView,FooterView,NSStringFromClass([FooterView class]))

#define kCV_reuseCellIdentfier(collectionView, identfier, indexPath)  [collectionView dequeueReusableCellWithReuseIdentifier:identfier forIndexPath:indexPath]
#define kCV_reuseCellClass(collectionView, cellClass, indexPath)  [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([cellClass class]) forIndexPath:indexPath]

#define kCV_ReuseSuplmentViewIdentifier(collectionView, RuseView, kind, identifier) [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:identifier forIndexPath:indexPath]
#define kCV_ReuseSuplmentView(collectionView, RuseView, kind) [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass([RuseView class]) forIndexPath:indexPath]

#define kCV_reuseHeaderIdentifier(collectionView, identifier, indexPath) [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identifier forIndexPath:indexPath]
#define kCV_reuseHeader(collectionView, suplemntViewClass, indexPath) kCV_reuseHeaderIdentifier(collectionView, NSStringFromClass([suplemntViewClass class]), indexPath)
#define kCV_reuserEmptyHeader(collectionView, indexPath) kCV_reuseHeader(collectionView, NSStringFromClass(UICollectionReusableView), indexPath);

#define kCV_reuseFooterIdentifier(collectionView, identifier, indexPath) [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:identifier forIndexPath:indexPath]

#define kCV_reuseFooter(collectionView, suplemntViewClass, indexPath) kCV_reuseFooterIdentifier(collectionView,NSStringFromClass([suplemntViewClass class]),indexPath)
#define kCV_reuserEmptyFooter(collectionView, indexPath) kCV_reuseFooter(collectionView, NSStringFromClass(UICollectionReusableView), indexPath);

#define kCV_reuseEmptyView(collectionView, kind, indexPath) [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass([UICollectionReusableView class]) forIndexPath:indexPath]

#define kCV_registerXibCell(collectionView, cellClass, cellID) [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([cellClass class]) bundle:nil] forCellWithReuseIdentifier:cellID];

#endif /* XN_CTViewConstants_h */
