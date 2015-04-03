//
//  TheFlowLayout.m
//  FinallyStuff
//
//  Created by Peter on 1/26/15.
//  Copyright (c) 2015 Peter. All rights reserved.
//

#import "TheFlowLayout.h"

@interface TheFlowLayout ()

@property (strong, nonatomic) NSMutableDictionary *framesCache;

@end

@implementation TheFlowLayout

- (void)invalidateLayout {
	[super invalidateLayout];
	@synchronized(self.framesCache) {
		[self.framesCache removeAllObjects];
	}
}

- (void)prepareLayout {
	[super prepareLayout];
	self.framesCache = [[NSMutableDictionary alloc] init];
}

- (void)adjustFrameOfLayoutAttributes:(UICollectionViewLayoutAttributes *)attrs {
	CGFloat leftInset = [self insetForSectionAtIndex:attrs.indexPath.section].left;
	@synchronized(self.framesCache) {
		NSValue *fr = [self.framesCache objectForKey:[NSNumber numberWithInt:attrs.indexPath.item]];
		if (fr) { // value is in the cache
#if DEBUG
			NSLog(@"found a frame in the cache for index %@", @(attrs.indexPath.item));
#endif
			attrs.frame = [fr CGRectValue];
		}
		else if (attrs.indexPath.item == 0) { // always butt the first item up against the inset
			CGRect frame = CGRectMake(leftInset, attrs.frame.origin.y, attrs.frame.size.width, attrs.frame.size.height);
			[self.framesCache setObject:[NSValue valueWithCGRect:frame] forKey:[NSNumber numberWithInt:0]];
			attrs.frame = frame;
		}
		else { // we need to look at the previous item's frame
			NSIndexPath *previous = [NSIndexPath indexPathForItem:attrs.indexPath.item - 1
														inSection:attrs.indexPath.section];
			UICollectionViewLayoutAttributes *previousAttrs = [self layoutAttributesForItemAtIndexPath:previous];
			if (CGRectGetMidY(attrs.frame) == CGRectGetMidY(previousAttrs.frame)) { // items are in the same row
				CGFloat spacing = [self minimumInteritemSpacingForSectionAtIndex:attrs.indexPath.section];
				CGRect frame = CGRectMake(CGRectGetMaxX(previousAttrs.frame) + spacing, attrs.frame.origin.y, attrs.frame.size.width, attrs.frame.size.height);
				[self.framesCache setObject:[NSValue valueWithCGRect:frame] forKey:[NSNumber numberWithInt:attrs.indexPath.item]];
				attrs.frame = frame;
			}
			else { // item begins a row, so butt it
				CGRect frame = CGRectMake(leftInset, attrs.frame.origin.y, attrs.frame.size.width, attrs.frame.size.height);
				[self.framesCache setObject:[NSValue valueWithCGRect:frame] forKey:[NSNumber numberWithInt:attrs.indexPath.item]];
				attrs.frame = frame;
			}
		}
	}
}

- (UIEdgeInsets)insetForSectionAtIndex:(NSInteger)section {
	id delegate = self.collectionView.delegate;
	if ([delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)]) {
		UIEdgeInsets insets = [delegate collectionView:self.collectionView
												layout:self
								insetForSectionAtIndex:section];
		return insets;
	}
	else {
		return self.sectionInset;
	}
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
	NSArray *attributes = [super layoutAttributesForElementsInRect:rect];
	for (UICollectionViewLayoutAttributes *attrs in attributes) {
		if (attrs.representedElementCategory == UICollectionElementCategoryCell) {
			[self adjustFrameOfLayoutAttributes:attrs];
		}
	}
	return attributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
	UICollectionViewLayoutAttributes *attrs = [super layoutAttributesForItemAtIndexPath:indexPath];
	[self adjustFrameOfLayoutAttributes:attrs];
	return attrs;
}

- (CGFloat)minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
	id delegate = self.collectionView.delegate;
	if ([delegate respondsToSelector:@selector(collectionView:layout:minimumInteritemSpacingForSectionAtIndex:)]) {
		CGFloat spacing = [delegate collectionView:self.collectionView
											layout:self
		  minimumInteritemSpacingForSectionAtIndex:section];
		return spacing;
	}
	else {
		return self.minimumInteritemSpacing;
	}
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset {
	CGPoint offset = [super targetContentOffsetForProposedContentOffset:proposedContentOffset];
	// TODO
	return offset;
}

@end
