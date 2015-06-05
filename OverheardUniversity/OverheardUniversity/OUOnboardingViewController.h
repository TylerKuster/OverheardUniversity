//
//  OUTestViewController.h
//  overhearduniversity
//
//  Created by Tyler Kuster on 5/26/15.
//  Copyright (c) 2015 Overheard University, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTSlidingPagesDataSource.h"
#import "TTSliddingPageDelegate.h"

typedef NS_ENUM(NSInteger, OnboardingStage)
{
    OnboardingLocationRequest,
    OnboardingSchoolsGrid,
    OnboardingRegister,
    OnboardingLogin
};

@interface OUOnboardingViewController : UIViewController <TTSlidingPagesDataSource, TTSliddingPageDelegate>

@end
