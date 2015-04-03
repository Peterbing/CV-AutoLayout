//
//  CollectionCellNeedsLayoutWidth.h
//  FinallyStuff
//
//  Created by Peter on 2/8/15.
//  Copyright (c) 2015 Peter. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CollectionCellNeedsLayoutWidth <NSObject>

- (void)configureForLayoutWidth:(CGFloat)width;

+ (instancetype)sharedSizingInstance;

- (CGFloat)totalWidthOfCellChrome;

@end
