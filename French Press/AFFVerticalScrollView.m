//
//  AFFVerticalScrollView.m
//  French Press
//
//  Created by Adam F Froio on 9/25/14.
//  Copyright (c) 2014 Adam F Froio. All rights reserved.
//

#import "AFFVerticalScrollView.h"

@implementation AFFVerticalScrollView

- (void)setContentOffset:(CGPoint)contentOffset animated:(BOOL)animated {
    // restrict movement to vertical only
    CGPoint newOffset = CGPointMake(0, contentOffset.y);
    [super setContentOffset:newOffset animated:animated];
}

- (void)setContentOffset:(CGPoint)contentOffset {
    // restrict movement to vertical only
    CGPoint newOffset = CGPointMake(0, contentOffset.y);
    [super setContentOffset:newOffset];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
