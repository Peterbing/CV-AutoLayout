//
//  TheViewController.m
//  FinallyStuff
//
//  Created by Peter on 1/22/15.
//  Copyright (c) 2015 Peter. All rights reserved.
//

#import "TheViewController.h"

#import "TheFlowLayout.h"
#import "ThirdCollectionViewCell.h"

@interface TheViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet TheFlowLayout *flowLayout;

@property (strong, nonatomic) NSArray *items;

@end

@implementation TheViewController

#pragma mark -
#pragma mark view controller

- (void)viewDidLoad {
	[super viewDidLoad];
	self.items = @[@"aba bab aba bab aba bab aba very very very very very very very very long", @"foo", @"bar", @"baz", @"qux", @"and et cetera and et cetera", @"additional things", @"foo", @"bar", @"baz", @"qux", @"and et cetera and et cetera", @"additional things", @"foo", @"bar", @"baz", @"qux", @"and et cetera and et cetera", @"additional things", @"aba bab aba bab aba bab aba", @"foo", @"bar", @"baz", @"qux", @"and et cetera and et cetera", @"additional things", @"foo", @"bar", @"baz", @"qux", @"and et cetera and et cetera", @"additional things", @"foo", @"bar", @"baz", @"qux", @"and et cetera and et cetera", @"additional things", @"aba bab aba bab aba bab aba", @"foo", @"bar", @"baz", @"qux", @"and et cetera and et cetera", @"additional things", @"foo", @"bar", @"baz", @"qux", @"and et cetera and et cetera", @"additional things", @"foo", @"bar", @"baz", @"qux", @"and et cetera and et cetera", @"additional things", @"aba bab aba bab aba bab aba", @"foo", @"bar", @"baz", @"qux", @"and et cetera and et cetera", @"additional things", @"foo", @"bar", @"baz", @"qux", @"and et cetera and et cetera", @"additional things", @"foo", @"bar", @"baz", @"qux", @"and et cetera and et cetera", @"additional things"];
	[self.collectionView registerClass:[ThirdCollectionViewCell class]
			forCellWithReuseIdentifier:@"Third"];
//	self.flowLayout.minimumInteritemSpacing = 24.0;
	self.flowLayout.minimumLineSpacing = 6.0;
//	self.flowLayout.sectionInset = UIEdgeInsetsMake(24.0, 24.0, 24.0, 24.0);
}

- (void)viewWillTransitionToSize:(CGSize)size
	   withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
	[super viewWillTransitionToSize:size
		  withTransitionCoordinator:coordinator];
	[self.flowLayout invalidateLayout];
}

- (CGFloat)getCurrentLayoutWidthForIndexPath:(NSIndexPath *)indexPath {
	UIEdgeInsets insets = [self.flowLayout insetForSectionAtIndex:indexPath.section];
	return CGRectGetWidth(self.collectionView.bounds) - insets.left - insets.right;
}

#pragma mark -
#pragma mark collection view data source

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
				  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	ThirdCollectionViewCell *third = [collectionView dequeueReusableCellWithReuseIdentifier:@"Third"
																			   forIndexPath:indexPath];
	[third configureForLayoutWidth:[self getCurrentLayoutWidthForIndexPath:indexPath]];
	[third configureWithText:self.items[indexPath.row]];
	return third;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
	 numberOfItemsInSection:(NSInteger)section {
	return self.items.count;
}

#pragma mark -
#pragma mark collection view delegate

- (CGSize)collectionView:(UICollectionView *)collectionView
				  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
	ThirdCollectionViewCell *sizingCell = [ThirdCollectionViewCell sharedSizingInstance];
	[sizingCell configureForLayoutWidth:[self getCurrentLayoutWidthForIndexPath:indexPath]];
	[sizingCell configureWithText:self.items[indexPath.row]];
	CGSize size = [sizingCell systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
	return size;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
						layout:(UICollectionViewLayout *)collectionViewLayout
		insetForSectionAtIndex:(NSInteger)section {
	return UIEdgeInsetsMake(8.0, 8.0, 8.0, 8.0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
				   layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
	return 8.0;
}

@end
