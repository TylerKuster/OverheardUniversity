//
//  OUNewPostTextView.m
//  OverheardUniversity
//
//  Created by Tyler Kuster on 8/9/15.
//  Copyright (c) 2015 OverheardUniversity. All rights reserved.
//

#import "OUCreatePostTextView.h"

@implementation OUCreatePostTextView

- (void)commonInit
{
    //    self.backgroundColor = [UIColor purpleColor];
    self.placeholderLabel.text = NSLocalizedString(@"What've you heard?", nil);
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self){
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self){
        [self commonInit];
    }
    return self;
}

@end
