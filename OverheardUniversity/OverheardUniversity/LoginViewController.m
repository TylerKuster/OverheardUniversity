//
//  ViewController.m
//  OverheardUniversity
//
//  Created by Tyler Kuster on 3/1/15.
//  Copyright (c) 2015 Overheard University, LLC. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>

@interface LoginViewController ()

@property (strong, nonatomic, readwrite) IBOutlet UITextField* username;
@property (strong, nonatomic, readwrite) IBOutlet UITextField* password;

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
    
}

@end
