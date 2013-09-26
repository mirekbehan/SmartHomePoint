//
//  TemperatureDetailViewController.m
//  SmartHomePoint
//
//  Created by Jarda on 9/26/13.
//  Copyright (c) 2013 Jaroslav Kutnar @ University Hradec Kralove. All rights reserved.
//

#import "TemperatureDetailViewController.h"
#import "Temperature.h"

@interface TemperatureDetailViewController ()
@property Temperature* CurrentTemperature;
@end

@implementation TemperatureDetailViewController

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
}

-(void)viewWillAppear:(BOOL)animated
{
    _uiDefinedTemperature.text = [_CurrentTemperature getDetailString];
    _uiStepper.value = _CurrentTemperature.DefinedTemperatureInCelsius.doubleValue;
    _uiStepper.minimumValue = _CurrentTemperature.MinTemperature.doubleValue;
    _uiStepper.maximumValue = _CurrentTemperature.MaxTemperature.doubleValue;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)StepperValueChanged:(id)sender
{
    _CurrentTemperature.DefinedTemperatureInCelsius = [NSNumber numberWithDouble:((UIStepper*)sender).value];
    _uiDefinedTemperature.text = [_CurrentTemperature getDetailString];
}


#pragma mark - ApplianceDetailProtocol

-(void)setAppliance:(Appliance *)appliance
{
    _CurrentTemperature = (Temperature*)appliance;
}

@end
