//
//  OUTheme.h
//  
//
//  Created by Tyler Kuster on 6/5/15.
//
//

#import <UIKit/UIKit.h>

@interface OUTheme : UIColor

+ (UIColor*)brandColor;
+ (UIColor*)offWhiteColor;
+ (UIColor*)randomColor;
+ (CAGradientLayer*)onboardingGradientFromView:(UIView*)view;
+ (UIFont*)onboardingFont;

+ (CGRect)areaCarouselRect;
+ (CGRect)locationCarouselRect;

@end