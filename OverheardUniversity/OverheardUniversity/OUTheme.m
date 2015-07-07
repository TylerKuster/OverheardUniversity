//
//  OUTheme.m
//  
//
//  Created by Tyler Kuster on 6/5/15.
//
//

#import "OUTheme.h"

static const CGFloat kAreaCarouselHeight = 300.0f;
static const CGFloat kLocationCarouselHeight = 200.0f;

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

+ (UIColor*)randomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    UIColor* color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    
    return color;
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

+ (CGRect)areaCarouselRect
{
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    CGFloat areaCarouselY = screenHeight - kAreaCarouselHeight;
    
    return CGRectMake(0.0f, areaCarouselY, screenWidth, kAreaCarouselHeight);
}

+ (CGRect)locationCarouselRect
{
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat locationCarouselHeight = kAreaCarouselHeight - kLocationCarouselHeight;
    
    return CGRectMake(0.0f, 120.0f, screenWidth, 300.0f);
}

@end
