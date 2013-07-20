//
//  settingsViewController.m
//  SmartHomePoint
//
//  Created by Jarda on 7/20/13.
//  Copyright (c) 2013 Jaroslav Kutnar @ University Hradec Kralove. All rights reserved.
//

#import "settingsViewController.h"

@interface settingsViewController ()

@end

@implementation settingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onButtonTouchUp:(id)sender {
    UIStoryboard* storyBoard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
    UIViewController* controller = [storyBoard instantiateInitialViewController];    
    [[[[UIApplication sharedApplication] delegate] window] setRootViewController:controller];
    [[[[UIApplication sharedApplication] delegate] window] makeKeyAndVisible];    
}
@end
