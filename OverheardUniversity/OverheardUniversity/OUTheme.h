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
+ (UIColor*)brandShadeColor;
+ (UIColor*)darkBlue;
+ (UIColor*)lightGrey;
+ (UIColor*)offWhiteColor;
+ (UIColor*)randomColor;
+ (CAGradientLayer*)onboardingGradientFromView:(UIView*)view;

+ (UIFont*)onboardingFont;
+ (UIFont*)textViewFont;

+ (CGRect)areaCarouselRect;
+ (CGRect)locationCarouselRect;

+ (CGRect)createPostTextViewActiveRect;
+ (CGRect)createPostTextViewNormalRect;


@end
