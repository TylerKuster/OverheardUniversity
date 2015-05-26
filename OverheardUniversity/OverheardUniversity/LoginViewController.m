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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
// Pass the selected object to the new
}

@end
