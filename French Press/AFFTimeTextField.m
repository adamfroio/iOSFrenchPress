//
//  AFFTimeTextField.m
//  French Press
//
//  Created by Adam F Froio on 9/24/14.
//  Copyright (c) 2014 Adam F Froio. All rights reserved.
//

#import "AFFTimeTextField.h"

@implementation AFFTimeTextField

// UITextField subclassed to override the method below
- (CGRect)caretRectForPosition:(UITextPosition *)position
{
    return CGRectZero;  // hide the cursor within the text field
}


@end
