//
//  settingsViewController.m
//  SmartHomePoint
//
//  Created by Jarda on 7/20/13.
//  Copyright (c) 2013 Jaroslav Kutnar @ University Hradec Kralove. All rights reserved.
//

#import "settingsViewController.h"
#import "ZBarSDK.h"


@interface settingsViewController () <ZBarReaderDelegate>

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
    ZBarReaderViewController *reader = [ZBarReaderViewController new];
    reader.readerDelegate = self;
    [reader.scanner setSymbology:ZBAR_QRCODE config:ZBAR_CFG_ENABLE to:0];
    reader.readerView.zoom = 1.0;
    reader.showsZBarControls = NO;
    [self presentViewController:reader animated:YES completion:nil];
}

- (void) imagePickerController:(UIImagePickerController*)reader didFinishPickingMediaWithInfo:(NSDictionary*)info {
    id<NSFastEnumeration> results = [info objectForKey: ZBarReaderControllerResults];
    //UIImage *image = [info objectForKey: UIImagePickerControllerOriginalImage];
    [reader dismissViewControllerAnimated:YES completion:NULL];


    /*
     UIStoryboard* storyBoard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
     UIViewController* controller = [storyBoard instantiateInitialViewController];
     [[[[UIApplication sharedApplication] delegate] window] setRootViewController:controller];
     [[[[UIApplication sharedApplication] delegate] window] makeKeyAndVisible];
     */
}

- (void) readerControllerDidFailToRead: (ZBarReaderController*) reader withRetry: (BOOL) retry
{
    if (!retry)
        [reader dismissViewControllerAnimated:YES completion:NULL];
}


@end
