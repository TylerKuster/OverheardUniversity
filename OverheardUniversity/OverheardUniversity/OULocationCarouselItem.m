//
//  OULocationCarouselItem.m
//  OverheardUniversity
//
//  Created by Tyler Kuster on 8/2/15.
//  Copyright (c) 2015 OverheardUniversity. All rights reserved.
//

#import "OULocationCarouselItem.h"
#import "OUTheme.h"
#import "OUListenButton.h"

@interface OULocationCarouselItem ()

@property (nonatomic, retain) UILabel* locationName;
@property (nonatomic, retain) UILabel* locationNumberOfPosts;
@property (nonatomic, retain) UILabel* locationNumberOfFollowers;
@property (nonatomic, retain) OUListenButton* listenButton;

@end

static const CGFloat cardHeight = 206.0f;
static const CGFloat cardBorderLeading = 0.5f;
static const CGFloat cardBorderTrailing = cardBorderLeading * 2.0f;
static const CGFloat areaLabelHeight = 25.0f;

static const CGFloat buttonLeading = 44.0f;
static const CGFloat buttonTrailing = 88.0f;


@implementation OULocationCarouselItem

- (void)commonInit
{
    self.backgroundColor = [OUTheme brandColor];
    
    UIView* card = [[UIView alloc] initWithFrame:CGRectMake(cardBorderLeading, areaLabelHeight, self.frame.size.width - cardBorderTrailing, cardHeight)];
    card.backgroundColor = [UIColor whiteColor];

    [self addSubview:card];
    
    CGFloat labelWidth = self.frame.size.width - cardBorderTrailing;
    
    self.locationName = [[UILabel alloc] initWithFrame:CGRectMake(cardBorderLeading, 33.0f, labelWidth, 30.0f)];
    self.locationName.backgroundColor = [UIColor whiteColor];
    self.locationName.textAlignment = NSTextAlignmentCenter;
    self.locationName.textColor = [UIColor colorWithRed:66.0f / 255.0f green:66.0f / 255.0f blue:66.0f / 255.0f alpha:1.0f];
    self.locationName.font = [UIFont fontWithName:@"AvenirNext-DemiBold"  size:20.0];
    
    [self addSubview:self.locationName];
    
    self.locationNumberOfPosts = [[UILabel alloc] initWithFrame:CGRectMake(cardBorderLeading, 65.0f, labelWidth, 20.0f)];
    self.locationNumberOfPosts.backgroundColor = [UIColor whiteColor];
    self.locationNumberOfPosts.textAlignment = NSTextAlignmentCenter;
    self.locationNumberOfPosts.textColor = [UIColor colorWithRed:66.0f / 255.0f green:66.0f / 255.0f blue:66.0f / 255.0f alpha:1.0f];
    self.locationNumberOfPosts.font = [UIFont fontWithName:@"AvenirNext-Regular"  size:14.0];
    
    [self addSubview:self.locationNumberOfPosts];
    
    self.locationNumberOfFollowers = [[UILabel alloc] initWithFrame:CGRectMake(cardBorderLeading, 86.0f, labelWidth, 20.0f)];
    self.locationNumberOfFollowers.backgroundColor = [UIColor whiteColor];
    self.locationNumberOfFollowers.textAlignment = NSTextAlignmentCenter;
    self.locationNumberOfFollowers.textColor = [UIColor colorWithRed:66.0f / 255.0f green:66.0f / 255.0f blue:66.0f / 255.0f alpha:1.0f];
    self.locationNumberOfFollowers.font = [UIFont fontWithName:@"AvenirNext-Regular"  size:14.0];
    
    [self addSubview:self.locationNumberOfFollowers];
    
    self.listenButton = [[OUListenButton alloc] initWithFrame:CGRectMake(buttonLeading, 115.0f, self.frame.size.width - buttonTrailing, 24.0f)];
    
    [self addSubview:self.listenButton];
    
    self.locationName.text = @"Parks Library";
    self.locationNumberOfPosts.text = @"1208 Posts";
    self.locationNumberOfFollowers.text = @"2129 Listening";

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
