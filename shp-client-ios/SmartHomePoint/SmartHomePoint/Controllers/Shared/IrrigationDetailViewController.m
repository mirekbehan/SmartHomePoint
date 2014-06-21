//
//  IrrigationDetailViewController.m
//  SmartHomePoint
//
//  Created by Jarda on 21/06/14.
//  Copyright (c) 2014 Jaroslav Kutnar @ University Hradec Kralove. All rights reserved.
//

#import "IrrigationDetailViewController.h"
#import "Irrigation.h"

@interface IrrigationDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *uiLabelMinutes;
@property (weak, nonatomic) IBOutlet UIStepper *uiStepper;
@property (weak, nonatomic) IBOutlet UIButton *uiButton;

@property Irrigation* CurrentIrrigation;

@end

@implementation IrrigationDetailViewController

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

-(void)viewWillAppear:(BOOL)animated
{
    if (_CurrentIrrigation.Irrigating)
        _uiButton.titleLabel.text = NSLocalizedString(@"Stop", nil);
    else
        _uiButton.titleLabel.text = NSLocalizedString(@"Irrigate", nil);
    _uiStepper.value = _CurrentIrrigation.IrrigateMinutes.intValue;
    _uiLabelMinutes.text = [NSString stringWithFormat:@"%d mins.",(int)_uiStepper.value];
}


- (IBAction)onStepperValueChange:(id)sender
{
    _CurrentIrrigation.IrrigateMinutes = [NSNumber numberWithDouble:_uiStepper.value];
    _uiLabelMinutes.text = [NSString stringWithFormat:@"%d mins.",_CurrentIrrigation.IrrigateMinutes.intValue];
}

- (IBAction)onIrrigate:(id)sender
{
    if (_CurrentIrrigation.Irrigating)
        [_CurrentIrrigation stopIrrigating];
    else
        [_CurrentIrrigation startIrrigating];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - ApplianceDetailProtocol

-(void)setAppliance:(Appliance *)appliance
{
    _CurrentIrrigation = (Irrigation*)appliance;
}


@end
