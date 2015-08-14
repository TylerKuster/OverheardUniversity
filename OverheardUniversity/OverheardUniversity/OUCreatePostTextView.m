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
    self.tintColor = [UIColor whiteColor];
    self.layer.borderColor = [[OUTheme darkBlue]CGColor];
    self.layer.borderWidth = 1.0f;
    self.layer.cornerRadius = 0.0f;
    self.backgroundColor = [OUTheme brandShadeColor];
    self.font = [OUTheme textViewFont];
    self.textColor = [OUTheme lightGrey];
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
    self.textContainerInset = UIEdgeInsetsMake(4.0f, 0, 0, 0);
    
    self.placeholderColor = [OUTheme lightGrey];
}

@end
