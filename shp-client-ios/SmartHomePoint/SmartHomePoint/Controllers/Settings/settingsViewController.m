//
//  settingsViewController.m
//  SmartHomePoint
//
//  Created by Jarda on 7/20/13.
//  Copyright (c) 2013 Jaroslav Kutnar @ University Hradec Kralove. All rights reserved.
//

#import "settingsViewController.h"
#import "ZBarSDK.h"
#import "uhkAppDelegate.h"

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
    [reader.scanner setSymbology:0 config:ZBAR_CFG_ENABLE to:0];
    [reader.scanner setSymbology:ZBAR_QRCODE config:ZBAR_CFG_ENABLE to:1];
    reader.readerView.zoom = 1.0;
    reader.showsZBarControls = NO;
    [self presentViewController:reader animated:YES completion:nil];
}

- (IBAction)onLoginTouch:(id)sender {
    [(uhkAppDelegate*)[[UIApplication sharedApplication] delegate] instantiateUserDefinedViewController];
}

- (void) imagePickerController:(UIImagePickerController*)reader didFinishPickingMediaWithInfo:(NSDictionary*)info {
    id<NSFastEnumeration> results = [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    for(symbol in results)
        break;
    NSLog(@"qr:%@", symbol.data);
    [reader dismissViewControllerAnimated:YES completion:NULL];

    //! save the token
    
    [(uhkAppDelegate*)[[UIApplication sharedApplication] delegate] instantiateUserDefinedViewController];
}

- (void) readerControllerDidFailToRead: (ZBarReaderController*) reader withRetry: (BOOL) retry
{
    if (!retry)
        [reader dismissViewControllerAnimated:YES completion:NULL];
}


- (BOOL)shouldAutorotate {
    return FALSE;
}

@end
