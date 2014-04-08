//
//  Temperature.h
//  SmartHomePoint
//
//  Created by Jarda on 9/24/13.
//  Copyright (c) 2013 Jaroslav Kutnar @ University Hradec Kralove. All rights reserved.
//

#import "Appliance.h"

@interface Temperature : Appliance

typedef enum {
    ttSensor, ttThermostat
} ThermoType;


@property NSNumber* DefinedTemperatureInCelsius;
@property (readonly )NSNumber* TemperatureInCelsius;
@property (readonly) NSNumber* MinTemperature;
@property (readonly) NSNumber* MaxTemperature;

@property (readonly) ThermoType TypeOfThermo;

-(id)initWithName:(NSString*)name Type:(ThermoType)thermoType AndTemperatureInCelsius:(NSNumber*)temperatureInCelsius;
-(NSString*) getDefinedTemperatureString;
@end
