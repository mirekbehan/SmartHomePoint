//
//  Irrigation.h
//  SmartHomePoint
//
//  Created by Jarda on 9/24/13.
//  Copyright (c) 2013 Jaroslav Kutnar @ University Hradec Kralove. All rights reserved.
//

#import "Appliance.h"

@interface Irrigation : Appliance
@property NSNumber* IrrigateMinutes;
@property BOOL Irrigating;

-(void)startIrrigating;
-(void)stopIrrigating;
@end
