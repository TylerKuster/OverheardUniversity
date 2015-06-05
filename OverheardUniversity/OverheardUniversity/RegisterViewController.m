//
//  RegisterViewController.m
//  overhearduniversity
//
//  Created by Tyler Kuster on 5/24/15.
//  Copyright (c) 2015 Overheard University, LLC. All rights reserved.
//

#import "RegisterViewController.h"
#import "OUProgressBarTextField.h"
#import <Parse/Parse.h>
#import <CLHoppingViewController/CLHoppingViewController.h>

@interface RegisterViewController ()
@property (nonatomic, weak) IBOutlet OUProgressBarTextField* usernameTextField;
@property (nonatomic, weak) IBOutlet UITextField* passwordTextField;
@property (nonatomic, weak) IBOutlet UITextField* confirmPasswordTextField;

@property (nonatomic, weak) IBOutlet UIButton* logInButton;
@property (nonatomic, weak) IBOutlet UIButton* facebookButton;
@property (nonatomic, weak) IBOutlet UIButton* twitterButton;
@property (nonatomic, weak) IBOutlet UIButton* emailButton;
@property (nonatomic, weak) IBOutlet UIButton* whyButton;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.usernameTextField.titleLabel.text = @"Test";
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

- (IBAction)registerButtonPressed
{
    PFUser *user = [PFUser user];
    user.username = self.usernameTextField.titleLabel.text;
    user.password = self.passwordTextField.text;
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            // Hooray! Let them use the app now.
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Nice!"
                                                            message:@"You're all set."
                                                           delegate:self
                                                  cancelButtonTitle:@"Yay!"
                                                  otherButtonTitles:nil];
            [alert show];
           
            [self.hoppingViewController unhop];
            
        } else {
            NSString *errorString = [error userInfo][@"error"];
            NSLog(@"Login Error:%@", errorString);
            // Show the errorString somewhere and let the user try again.
        }
    }];

}

#pragma mark - UICollectionViewDataSource & Delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    
//    UICollectionViewCell* cell = [[UICollectionViewCell alloc] initWithFrame:CGRectMake(0.0f, indexPath.row * 60.0f, self.view.frame.size.width, 60.0f)];
    cell.backgroundColor = [UIColor blueColor];
    
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
