//
//  ThirdCollectionViewCell.m
//  FinallyStuff
//
//  Created by Peter on 1/24/15.
//  Copyright (c) 2015 Peter. All rights reserved.
//

#import "ThirdCollectionViewCell.h"

@interface ThirdCollectionViewCell ()

@property (strong, nonatomic) NSLayoutConstraint *bottom;

@property (strong, nonatomic) NSLayoutConstraint *leading;

@property (strong, nonatomic) NSLayoutConstraint *top;

@property (strong, nonatomic) NSLayoutConstraint *trailing;

@end

@implementation ThirdCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		self.translatesAutoresizingMaskIntoConstraints = NO;
		_bubble = ({
			UIView *view = [[UIView alloc] init];
			view.backgroundColor = [UIColor grayColor];
			view.layer.cornerRadius = 8.0;
			view.translatesAutoresizingMaskIntoConstraints = NO;
			view;
		});
		_label = ({
			UILabel *label = [[UILabel alloc] init];
			label.lineBreakMode = NSLineBreakByWordWrapping;
			label.numberOfLines = 0;
			label.text = @"hello";
			label.textColor = [UIColor whiteColor];
			label.translatesAutoresizingMaskIntoConstraints = NO;
			label;
		});

		[self.contentView addSubview:_bubble];
		[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[bubble]-0-|" options:0 metrics:nil views:@{@"bubble": _bubble}]];
		[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[bubble]-0-|" options:0 metrics:nil views:@{@"bubble": _bubble}]];

		[_bubble addSubview:_label];
		CGFloat c = 12.0;
		_bottom = [NSLayoutConstraint constraintWithItem:_bubble attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_label attribute:NSLayoutAttributeBottom multiplier:1.0 constant:c];
		_leading = [NSLayoutConstraint constraintWithItem:_bubble attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:_label attribute:NSLayoutAttributeLeading multiplier:1.0 constant:-c];
		_top = [NSLayoutConstraint constraintWithItem:_bubble attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_label attribute:NSLayoutAttributeTop multiplier:1.0 constant:-c];
		_trailing = [NSLayoutConstraint constraintWithItem:_bubble attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:_label attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:c];
		[_bubble addConstraints:@[_bottom, _leading, _top, _trailing]];
	}
	return self;
}

- (void)configureForLayoutWidth:(CGFloat)width {
	self.label.preferredMaxLayoutWidth = width - [self totalWidthOfCellChrome];
}

- (void)configureWithText:(NSString *)text {
	self.label.text = text;
}

+ (instancetype)sharedSizingInstance {
	static ThirdCollectionViewCell *shared;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		shared = [[ThirdCollectionViewCell alloc] initWithFrame:CGRectMake(0.0, 0.0, 1.0, 1.0)];
	});
	return shared;
}

- (CGFloat)totalWidthOfCellChrome {
	return ABS(self.leading.constant) + ABS(self.trailing.constant);
}

@end
