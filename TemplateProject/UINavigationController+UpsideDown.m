//
//  UINavigationController+UpsideDown.m
//  TemplateProject
//
//  Created by Peter on 1/9/15.
//  Copyright (c) 2015 Peter. All rights reserved.
//

#import "UINavigationController+UpsideDown.h"

@implementation UINavigationController (UpsideDown)

- (BOOL)shouldAutorotate {
	return YES;
}

- (NSInteger)supportedInterfaceOrientations {
	return UIInterfaceOrientationMaskAll;
}

@end
