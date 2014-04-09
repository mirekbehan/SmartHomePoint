//
//  Temperature.m
//  SmartHomePoint
//
//  Created by Jarda on 9/24/13.
//  Copyright (c) 2013 Jaroslav Kutnar @ University Hradec Kralove. All rights reserved.
//

#import "Temperature.h"

@implementation Temperature
@synthesize DefinedTemperatureInCelsius = _DefinedTemperatureInCelsius;
@synthesize TypeOfAppliance = _TypeOfAppliance;

-(id)initWithName:(NSString *)name
{
    NSLog(@"never init only with name");
    return nil;
}

-(id)initWithName:(NSString*)name Type:(ThermoType)thermoType AndTemperatureInCelsius:(NSNumber*)temperatureInCelsius
{
    self = [super initWithName:name];
    if (self) {
        _TypeOfAppliance = atTemperature;
        _TypeOfThermo = thermoType;
        _TemperatureInCelsius = temperatureInCelsius;
        _MinTemperature = [NSNumber numberWithDouble: 3.5];
        _MaxTemperature = [NSNumber numberWithDouble:35.0];
    }
    return self;
}

-(NSNumber*)DefinedTemperatureInCelsius
{
    return _DefinedTemperatureInCelsius;
}

-(void)setDefinedTemperatureInCelsius:(NSNumber *)DefinedTemperatureInCelsius
{
    if (DefinedTemperatureInCelsius.doubleValue<_MinTemperature.doubleValue)
        _DefinedTemperatureInCelsius = _MinTemperature;
    else if (DefinedTemperatureInCelsius.doubleValue>_MaxTemperature.doubleValue)
        _DefinedTemperatureInCelsius = _MaxTemperature;
    else {
        double d = round(DefinedTemperatureInCelsius.doubleValue * 2.0) / 2.0;
        _DefinedTemperatureInCelsius = [NSNumber numberWithDouble:d];
    }
}


-(NSString*) getDetailString
{
    NSNumber *temperatureUnit = [[NSUserDefaults standardUserDefaults] valueForKey:@"temp"];
    switch (temperatureUnit.intValue) {
        case 0:
            return [NSString stringWithFormat:@"%.01f°C", _TemperatureInCelsius.floatValue];
        default:
            return [NSString stringWithFormat:@"%.0f°F", _TemperatureInCelsius.floatValue * 9/5 + 32];
    }
}

-(NSString*) getDefinedTemperatureString
{
    if (_DefinedTemperatureInCelsius.doubleValue<=_MinTemperature.doubleValue)
        return NSLocalizedString(@"OFF", nil);
    
    NSNumber *temperatureUnit = [[NSUserDefaults standardUserDefaults] valueForKey:@"temp"];
    switch (temperatureUnit.intValue) {
        case 0:
            return [NSString stringWithFormat:@"%.01f°C", _DefinedTemperatureInCelsius.floatValue];
        default:
            return [NSString stringWithFormat:@"%.0f°F", _DefinedTemperatureInCelsius.floatValue * 9/5 + 32];
    }
}

-(UIImage*) getDetailImage
{
    if (_TypeOfThermo==ttSensor)
        return nil;
    if (_DefinedTemperatureInCelsius.doubleValue<=_MinTemperature.doubleValue)
        return [UIImage imageNamed:@"Red_dot.png"];
    return nil;
}


@end
