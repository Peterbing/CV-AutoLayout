//
//  ThirdCollectionViewCell.h
//  FinallyStuff
//
//  Created by Peter on 1/24/15.
//  Copyright (c) 2015 Peter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionCellNeedsLayoutWidth.h"

@interface ThirdCollectionViewCell : UICollectionViewCell<CollectionCellNeedsLayoutWidth>

@property (strong, nonatomic) UIView *bubble;

@property (strong, nonatomic) UILabel *label;

- (instancetype)initWithFrame:(CGRect)frame;

- (void)configureForLayoutWidth:(CGFloat)width;

- (void)configureWithText:(NSString *)text;

+ (instancetype)sharedSizingInstance;

@end
