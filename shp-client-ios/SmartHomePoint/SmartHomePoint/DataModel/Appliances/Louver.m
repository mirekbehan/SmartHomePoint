//
//  Louver.m
//  SmartHomePoint
//
//  Created by Jarda on 9/24/13.
//  Copyright (c) 2013 Jaroslav Kutnar @ University Hradec Kralove. All rights reserved.
//

#import "Louver.h"

@implementation Louver
@synthesize TypeOfAppliance = _TypeOfAppliance;

-(id)initWithName:(NSString*)name
{
    self = [super initWithName:name];
    if (self) {
        _TypeOfAppliance = atLouver;
    }
    return self;
}

-(NSString*) getDetailString
{
    return @"";
}

@end
