//
//  Irrigation.m
//  SmartHomePoint
//
//  Created by Jarda on 9/24/13.
//  Copyright (c) 2013 Jaroslav Kutnar @ University Hradec Kralove. All rights reserved.
//

#import "Irrigation.h"


@interface Irrigation()
@property NSTimer *Timer;
@end



@implementation Irrigation

@synthesize TypeOfAppliance = _TypeOfAppliance;
@synthesize IrrigateMinutes = _IrrigateMinutes;



-(id)initWithName:(NSString*)name
{
    self = [super initWithName:name];
    if (self) {
        _TypeOfAppliance = atIrrigation;
        _IrrigateMinutes = [NSNumber numberWithInt:15];
    }
    return self;
}

-(NSString*) getDetailString
{
    if (_Irrigating)
    {
        return [NSString stringWithFormat:@"%d m.", _IrrigateMinutes.intValue];
    }
    return @"";
}


- (void)setIrrigateMinutes:(NSNumber *)IrrigateMinutes
{
    if (IrrigateMinutes.intValue<0.0)
        [self stopIrrigating];
    else if (IrrigateMinutes.intValue>120)
        _IrrigateMinutes = [NSNumber numberWithFloat:120.0];
    else
        _IrrigateMinutes = IrrigateMinutes;
}

-(NSNumber*)IrrigateMinutes
{
    return _IrrigateMinutes;
}

-(void)startIrrigating
{
    _Irrigating = TRUE;
    _Timer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
}

-(void)stopIrrigating
{
    _IrrigateMinutes = [NSNumber numberWithInt:15];
    _Irrigating = FALSE;
    [_Timer invalidate];
}


-(void)onTimer
{
    if (_IrrigateMinutes.intValue==1)
    {
        [self stopIrrigating];
        return;
    }
    _IrrigateMinutes = [NSNumber numberWithInt:_IrrigateMinutes.intValue-1];
}

@end
