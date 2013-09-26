//
//  TemperatureDetailViewController.h
//  SmartHomePoint
//
//  Created by Jarda on 9/26/13.
//  Copyright (c) 2013 Jaroslav Kutnar @ University Hradec Kralove. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApplianceDetailProtocol.h"

@interface TemperatureDetailViewController : UIViewController <ApplianceDetailProtocol>
@property (weak, nonatomic) IBOutlet UILabel *uiDefinedTemperature;
- (IBAction)StepperValueChanged:(id)sender;
@property (weak, nonatomic) IBOutlet UIStepper *uiStepper;

@end
