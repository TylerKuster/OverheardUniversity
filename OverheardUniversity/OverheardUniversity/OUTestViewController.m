//
//  OUTestViewController.m
//  overhearduniversity
//
//  Created by Tyler Kuster on 5/26/15.
//  Copyright (c) 2015 Overheard University, LLC. All rights reserved.
//

#import "OUTestViewController.h"
#import "TTScrollSlidingPagesController.h"
#import "TTSlidingPage.h"
#import "TTSlidingPageTitle.h"

@interface OUTestViewController ()
@property (strong, nonatomic) TTScrollSlidingPagesController *slider;
@end

@implementation OUTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //initial setup of the TTScrollSlidingPagesController.
    self.slider = [[TTScrollSlidingPagesController alloc] init];
    self.slider.titleScrollerInActiveTextColour = [UIColor whiteColor];
    self.slider.titleScrollerBottomEdgeColour = [UIColor darkGrayColor];
    self.slider.titleScrollerBottomEdgeHeight = 2;
    
    //set properties to customiser the slider. Make sure you set these BEFORE you access any other properties on the slider, such as the view or the datasource. Best to do it immediately after calling the init method.
    self.slider.hideStatusBarWhenScrolling = NO;
    self.slider.titleScrollerHidden = YES;
    //slider.titleScrollerHeight = 100;
    //slider.titleScrollerItemWidth=60;
    //slider.titleScrollerBackgroundColour = [UIColor darkGrayColor];
    self.slider.disableTitleScrollerShadow = YES;
    self.slider.disableUIPageControl = YES;
    self.slider.initialPageNumber = 1;
    //slider.pagingEnabled = NO;
    _slider.zoomOutAnimationDisabled = YES;
    //self.slider.disableTitleShadow = YES;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7){
        //        self.slider.hideStatusBarWhenScrolling = YES;//this property normally only makes sense on iOS7+. See the documentation in TTScrollSlidingPagesController.h. If you wanted to use it in iOS6 you'd have to make sure the status bar overlapped the TTScrollSlidingPagesController.
    }
    
    //set the datasource.
    self.slider.dataSource = self;
    
    //add the slider's view to this view as a subview, and add the viewcontroller to this viewcontrollers child collection (so that it gets retained and stays in memory! And gets all relevant events in the view controller lifecycle)
    self.slider.view.frame = self.view.frame;
    [self.view insertSubview:self.slider.view atIndex:0];
    [self addChildViewController:self.slider];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark TTSlidingPagesDataSource methods
-(int)numberOfPagesForSlidingPagesViewController:(TTScrollSlidingPagesController *)source{
    return 2; //just return 7 pages as an example
}

-(TTSlidingPage *)pageForSlidingPagesViewController:(TTScrollSlidingPagesController*)source atIndex:(int)index
{
    //    NSUUID *appID = [[NSUUID alloc] initWithUUIDString:@"d0b43270-f777-11e4-8f6b-667982007156"];
    //
    //    LYRClient *layerClient = [LYRClient clientWithAppID:appID];
    switch (index) {
        case 0:
        {
            UIViewController* viewController = [[UIViewController alloc] init];
            viewController.view.backgroundColor = [UIColor purpleColor];
            
            return [[TTSlidingPage alloc] initWithContentViewController: viewController];
            break;
        }
        case 1:
        {
            UIViewController* viewController = [[UIViewController alloc] init];
            viewController.view.backgroundColor = [UIColor orangeColor];
            
            return [[TTSlidingPage alloc] initWithContentViewController: viewController];
            break;
        }
        default:
            break;
    }
    
    return nil;
}

-(TTSlidingPageTitle *)titleForSlidingPagesViewController:(TTScrollSlidingPagesController *)source atIndex:(int)index{
    TTSlidingPageTitle *title;
    if (index == 0){
        //use a image as the header for the first page
        title = [[TTSlidingPageTitle alloc] initWithHeaderText:@"Profile"];
        //        title= [[TTSlidingPageTitle alloc] initWithHeaderImage:[UIImage imageNamed:@"about-tomthorpelogo.png"]];
    } else {
        //all other pages just use a simple text header
        switch (index) {
            case 1:
                title = [[TTSlidingPageTitle alloc] initWithHeaderText:@"Log In"];
                break;
            case 2:
                title = [[TTSlidingPageTitle alloc] initWithHeaderText:@"Log In"];
                break;
            case 3:
                title = [[TTSlidingPageTitle alloc] initWithHeaderText:@"More Stuff"];
                break;
            case 4:
                title = [[TTSlidingPageTitle alloc] initWithHeaderText:@"Another Page"];
                break;
            default:
                title = [[TTSlidingPageTitle alloc] initWithHeaderText:[NSString stringWithFormat:@"Page %d", index+1]];
                break;
        }
        
    }
    return title;
}

#pragma mark - delegate
-(void)didScrollToViewAtIndex:(NSUInteger)index
{
    NSLog(@"scrolled to view");
}

@end
