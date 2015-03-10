//
//  ViewController.m
//  OverheardUniversity
//
//  Created by Tyler Kuster on 3/1/15.
//  Copyright (c) 2015 Overheard University, LLC. All rights reserved.
//

#import <Parse/Parse.h>

#import "LoginViewController.h"
#import "OULogin.h"
#import "OUViewController.h"

@interface LoginViewController ()

@property (strong, nonatomic, readwrite) IBOutlet UITextField* username;
@property (strong, nonatomic, readwrite) IBOutlet UITextField* password;
@property (strong, nonatomic, readwrite) IBOutlet OUViewController* vc1;
@property (strong, nonatomic, readwrite) IBOutlet OUViewController* vc2;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
    testObject[@"foo"] = @"bar";
    [testObject saveInBackground];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submitApplicationButtonPressed:(id)sender
{
    if (self.username && self.password) {
        [OULogin checkUsername:@"tyler"//[[NSUserDefaults standardUserDefaults] stringForKey:@"username"]
                      password:@"p"//[[NSUserDefaults standardUserDefaults] stringForKey:@"password"]
                      andEmail:@"test@overhearduniversity.com"];//[[NSUserDefaults standardUserDefaults] stringForKey:@"email"]];
    }
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
// Pass the selected object to the new
}

@end
