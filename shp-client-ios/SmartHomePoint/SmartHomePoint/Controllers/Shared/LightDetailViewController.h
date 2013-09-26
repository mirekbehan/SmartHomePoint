//
//  LightDetailViewController.h
//  SmartHomePoint
//
//  Created by Jarda on 9/22/13.
//  Copyright (c) 2013 Jaroslav Kutnar @ University Hradec Kralove. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApplianceDetailProtocol.h"

@interface LightDetailViewController : UIViewController <ApplianceDetailProtocol>
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UIView *colorWheel;
@property (weak, nonatomic) IBOutlet UIView *well;

@end
