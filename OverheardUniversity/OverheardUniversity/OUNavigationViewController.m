//
//  OUMainViewController.m
//  overhearduniversity
//
//  Created by Tyler Kuster on 4/26/15.
//  Copyright (c) 2015 Overheard University, LLC. All rights reserved.
//
#import "OUNavigationViewController.h"
#import "OUCampusCarousel.h"

static const CGFloat kTopBarHeight = 80.0f;

@interface OUNavigationViewController ()
@property (nonatomic, weak) IBOutlet OUCampusCarousel* campusCarousel;

@end

@implementation OUNavigationViewController 

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
