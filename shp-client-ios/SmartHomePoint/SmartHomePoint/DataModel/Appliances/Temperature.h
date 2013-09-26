//
//  Temperature.h
//  SmartHomePoint
//
//  Created by Jarda on 9/24/13.
//  Copyright (c) 2013 Jaroslav Kutnar @ University Hradec Kralove. All rights reserved.
//

#import "Appliance.h"

@interface Temperature : Appliance

@property NSNumber* DefinedTemperatureInCelsius;
@property (readonly) NSNumber* ActualTemperatureInCelsius; //!TODO

@property (readonly) NSNumber* MinTemperature;
@property (readonly) NSNumber* MaxTemperature;
@end
