//
//  RegisterViewController.h
//  overhearduniversity
//
//  Created by Tyler Kuster on 5/24/15.
//  Copyright (c) 2015 Overheard University, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RegisterViewController;

typedef NS_ENUM(NSInteger, RegisterStage)
{
    RegisterName,
    RegisterUsername,
    RegisterPassword,
    RegisterEmail
};

@interface RegisterViewController : UIViewController

@end
