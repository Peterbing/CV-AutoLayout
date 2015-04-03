//
//  TheFlowLayout.h
//  FinallyStuff
//
//  Created by Peter on 1/26/15.
//  Copyright (c) 2015 Peter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TheFlowLayout : UICollectionViewFlowLayout

- (UIEdgeInsets)insetForSectionAtIndex:(NSInteger)section;

- (CGFloat)minimumInteritemSpacingForSectionAtIndex:(NSInteger)section;

@end
