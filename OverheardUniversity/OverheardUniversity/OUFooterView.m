//
//  OUFooterView.m
//  OverheardUniversity
//
//  Created by Tyler Kuster on 8/13/15.
//  Copyright (c) 2015 OverheardUniversity. All rights reserved.
//

#import "OUFooterView.h"
#import "OUCreatePostTextView.h"
#import "OUTheme.h"

@interface OUFooterView () <UITextViewDelegate>

@property (nonatomic, retain) OUCreatePostTextView* postTextView;

@end

@implementation OUFooterView

- (void)commonInit
{
    self.backgroundColor = [OUTheme brandColor];
    
    UIButton* postMap = [UIButton buttonWithType:UIButtonTypeCustom];
    postMap.frame = CGRectMake(16.0f, 8.0f, 32.0f, 32.0f);
    postMap.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:postMap];
    
    UIButton* profile = [UIButton buttonWithType:UIButtonTypeCustom];
    profile.frame = CGRectMake(self.frame.size.width - 48.0f, 8.0f, 32.0f, 32.0f);
    profile.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:profile];
    
    self.postTextView = [[OUCreatePostTextView alloc]initWithFrame:CGRectMake((self.frame.size.width / 2.0f) - 99.5, 10.0f, 199, 28)];
    self.postTextView.textAlignment = NSTextAlignmentCenter;
    self.postTextView.delegate = self;
    
    [self addSubview:self.postTextView];
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

#pragma mark - UITextViewDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    [UIView animateWithDuration:0.2f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.postTextView.textAlignment = NSTextAlignmentLeft;
                         self.postTextView.frame = [OUTheme createPostTextViewActiveRect];
                     } completion:^(BOOL finished) {
                         [self.delegate presentCreatePostView];
                     }];
    
    [UIView animateWithDuration:0.2f
                          delay:0.15f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [self.delegate presentCreatePostView];
                     } completion:nil];
    
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView {
//    [self.postTextView resignFirstResponder];
    self.postTextView.textAlignment = NSTextAlignmentLeft;
}

@end
