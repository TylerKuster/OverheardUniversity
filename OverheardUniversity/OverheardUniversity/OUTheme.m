//
//  OUTheme.m
//  
//
//  Created by Tyler Kuster on 6/5/15.
//
//

#import "OUTheme.h"

@implementation OUTheme

+ (UIColor*)brandColor
{
    return [UIColor colorWithRed:0.02f green:0.33f blue:0.45f alpha:1.0f];
}

+ (UIColor*)topGradientColor
{
    return [UIColor colorWithRed:0.07f green:0.5f blue:0.68f alpha:1.0f];
}

+ (UIColor*)bottomGradientColor
{
    return [UIColor colorWithRed:0.03f green:0.36f blue:0.51f alpha:1.0f];
}

+ (UIColor*)offWhiteColor
{
    return [UIColor colorWithRed:0.95f green:0.95f blue:0.95f alpha:1.0f];
}

+ (CAGradientLayer*)onboardingGradientFromView:(UIView*)view
{
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = view.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[[self topGradientColor] CGColor], (id)[[self bottomGradientColor] CGColor], nil];

    return gradient;
}

+ (UIFont*)onboardingFont
{
    return [UIFont fontWithName:@"AvenirNext-Medium" size:18.0f];
}

@end
