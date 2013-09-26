//
//  Room.m
//  SmartHomePoint
//
//  Created by Jarda on 9/24/13.
//  Copyright (c) 2013 Jaroslav Kutnar @ University Hradec Kralove. All rights reserved.
//

#import "Room.h"

@implementation Room


-(id)initWithName:(NSString*)name AndAppliances:(NSArray*)appliances
{
    self = [super init];
    if (self) {
        _Name = name;
        _Appliances = appliances;
    }
    return self;
}

@end
