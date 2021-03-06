//
//  Security.m
//  SmartHomePoint
//
//  Created by Jarda on 21/06/14.
//  Copyright (c) 2014 Jaroslav Kutnar @ University Hradec Kralove. All rights reserved.
//

#import "Security.h"

@implementation Security
@synthesize TypeOfAppliance = _TypeOfAppliance;


-(id)initWithName:(NSString *)name
{
    NSLog(@"never init only with name");
    return nil;
}


-(id)initWithName:(NSString*)name AndState:(BOOL)locked
{
    self = [super initWithName:name];
    if (self) {
        _Locked = locked;
        _TypeOfAppliance = atSecurity;
    }
    return self;
}


-(NSString*) getDetailString
{
    if (_Locked)
        return @"Alarmed";
    return @"Disabled";
}

-(UIImage*) getDetailImage
{
    return nil;
}

-(BOOL) supportSwitch
{
    return true;
}

@end
