//
//  OUNewPostTextView.m
//  OverheardUniversity
//
//  Created by Tyler Kuster on 8/9/15.
//  Copyright (c) 2015 OverheardUniversity. All rights reserved.
//

#import "OUCreatePostTextView.h"
#import "OUTheme.h"

@implementation OUCreatePostTextView

- (void)commonInit
{
    //    self.backgroundColor = [UIColor purpleColor];
    self.font = [OUTheme textViewFont];
    [self setPlaceholder:NSLocalizedString(@"What have you heard?", nil)];
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

- (void)setPlaceholder:(NSString *)placeholder {
    [super setPlaceholder:placeholder];
    
    // Vertically centers the text - [TK]
    self.textContainerInset = UIEdgeInsetsMake(2.5f, 0, 0, 0);
    
    self.placeholderColor = [UIColor grayColor];
}

@end
