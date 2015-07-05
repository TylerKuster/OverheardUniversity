//
//  RegisterViewController.m
//  overhearduniversity
//
//  Created by Tyler Kuster on 5/24/15.
//  Copyright (c) 2015 Overheard University, LLC. All rights reserved.
//

#import <Parse/Parse.h>
#import <TOMSMorphingLabel/TOMSMorphingLabel.h>

#import "RegisterViewController.h"
#import "OUTheme.h"

static const CGFloat kOffsetValue = 136.0f;
static const CGFloat kOverheardGuyOffsetValue = 310.0f;
static const CGFloat kLabelHeight = 100.0f;

typedef NS_ENUM(NSInteger, RegisterStage)
{
    RegisterName,
    RegisterUsername,
    RegisterPassword,
    RegisterEmail
};

@interface RegisterViewController () <UITextFieldDelegate>

@property (nonatomic, strong) TOMSMorphingLabel* messageLabel;
@property (nonatomic, weak) IBOutlet UITextField* registerTextField;
@property (nonatomic, weak) IBOutlet UIImageView* overheardGuy;

@property (nonatomic, weak) IBOutlet UIButton* nextButton;
@property (nonatomic, weak) IBOutlet UIButton* whyButton;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint* overheardGuyBottomConstraint;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint* registerViewBottomConstraint;

@property (assign) int registerStage;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view.layer insertSublayer:[OUTheme onboardingGradientFromView:self.view] atIndex:0];
    
    NSNotificationCenter* notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(keyboardOnScreen:) name:UIKeyboardDidShowNotification object:nil];
    
    self.registerStage = RegisterName;
    
    [self.registerTextField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logInButtonPressed
{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Oops!"
                                                    message:@"This isn't quite ready yet."
                                                   delegate:self
                                          cancelButtonTitle:@"Ok"
                                          otherButtonTitles:nil];
    [alert show];
}

- (IBAction)nextButtonPressed:(id)sender
{
    switch (self.registerStage) {
        case RegisterName:
        {
            [self setNameWithText:self.registerTextField.text];
            break;
        }
        case RegisterUsername:
        {
            [self checkUsernameWithText:self.registerTextField.text];
            break;
        }
        case RegisterPassword:
        {
            // TODO: Make this actually compare the two text fields
            [self confirmPasswordMatchWithPassword:self.registerTextField.text andConfirm:self.registerTextField.text];
            break;
        }
        case RegisterEmail:
        {
            [self confirmEDUWithEmail:self.registerTextField.text];
            break;
        }
        default:
            break;
    }
}

- (void)keyboardOnScreen:(NSNotification *)notification
{
    NSDictionary *info  = notification.userInfo;
    NSValue      *value = info[UIKeyboardFrameEndUserInfoKey];
    
    CGRect rawFrame      = [value CGRectValue];
    CGRect keyboardFrame = [self.view convertRect:rawFrame fromView:nil];
    CGFloat viewOffset = keyboardFrame.origin.y - kOffsetValue;
    CGRect labelFrame = CGRectMake(0.0f, viewOffset, [UIScreen mainScreen].bounds.size.width, kLabelHeight);
    
    if (self.registerStage == RegisterName) {
        [self showRegisterMessagesWithFrame:labelFrame andOffset:216.0f];
    }
}

- (void)showRegisterMessagesWithFrame:(CGRect)rect andOffset:(CGFloat)offset
{
    [UIView animateWithDuration:0.25f
                          delay:0.0f
         usingSpringWithDamping:0.8f
          initialSpringVelocity:1.0f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.registerViewBottomConstraint.constant = offset;
                         self.overheardGuyBottomConstraint.constant = kOverheardGuyOffsetValue;
                         
                         self.overheardGuy.alpha = 1.0f;
                         self.registerTextField.text = @"";
                         
                         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                             if (!self.messageLabel) {
                                  self.messageLabel = [[TOMSMorphingLabel alloc]initWithFrame:rect];
                             }
                             self.messageLabel.font = [OUTheme onboardingFont];
                             self.messageLabel.textAlignment = NSTextAlignmentCenter;
                             self.messageLabel.textColor = [UIColor whiteColor];
                             self.messageLabel.text = NSLocalizedString(@"First things first, what's your name?", nil);
                             
                             [self.view addSubview: self.messageLabel];
                         });
                         
                         [self.view layoutIfNeeded];
                         
                     } completion:nil];
}

- (void)setNameWithText:(NSString*)text
{
    [[NSUserDefaults standardUserDefaults] setValue:text forKey:@"name"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self moveTo:RegisterUsername withText:NSLocalizedString(@"Next let's add your username", nil)];
    self.registerStage = RegisterUsername;
}

- (void)checkUsernameWithText:(NSString*)text
{
    // TODO: Check if username exists first
    [[NSUserDefaults standardUserDefaults] setValue:text forKey:@"username"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    self.registerTextField.secureTextEntry = YES;
    [self moveTo:RegisterUsername withText:NSLocalizedString(@"We should set a password for that", nil)];
    self.registerStage = RegisterPassword;
}

- (void)confirmPasswordMatchWithPassword:(NSString*)password andConfirm:(NSString*)confirm
{
    // TODO: Password confirmation
//    if (password == confirm) {
        [[NSUserDefaults standardUserDefaults] setValue:password forKey:@"password"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    
        self.registerTextField.secureTextEntry = NO;
        self.registerTextField.font = [OUTheme onboardingFont];
    
        [self moveTo:RegisterUsername withText:NSLocalizedString(@"We need to confirm your university email", nil)];
        self.registerStage = RegisterEmail;
//    } else
//    {
//        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Oops!"
//                                                        message:@"Those didn't match. Try again?"
//                                                       delegate:self
//                                              cancelButtonTitle:@"Ok"
//                                              otherButtonTitles:nil];
//        [alert show];
//    }
    
}

- (void)confirmEDUWithEmail:(NSString*)email
{
    // TODO: Email confirmation
    [[NSUserDefaults standardUserDefaults] setValue:email forKey:@"email"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self signUpUser];
}

- (void)signUpUser
{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    
    PFUser *user = [PFUser user];
    user.username = [userDefaults valueForKey:@"username"];
    user.password = [userDefaults valueForKey:@"password"];
    user.email = [userDefaults valueForKey:@"email"];

    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Woo!"
                                                        message:@"You're signed up!"
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
        [alert show];
        } else {
            NSString *errorString = [error userInfo][@"error"];
            NSLog(@"Login Error:%@", errorString);
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Oops!"
                                                            message:@"Make sure you use a valid email"
                                                           delegate:self
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
            [alert show];
        }
    }];
}

- (void)moveTo:(RegisterStage)newStage withText:(NSString*)message
{
    self.registerStage = newStage;
    self.messageLabel.text = message;
    self.registerTextField.text = @"";
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self nextButtonPressed:nil];
    
    return NO;
}

@end
