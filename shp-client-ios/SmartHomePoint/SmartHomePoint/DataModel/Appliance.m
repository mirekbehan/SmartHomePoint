//
//  Appliance.m
//  SmartHomePoint
//
//  Created by Jarda on 9/24/13.
//  Copyright (c) 2013 Jaroslav Kutnar @ University Hradec Kralove. All rights reserved.
//

#import "Appliance.h"

@implementation Appliance


-(id)initWithName:(NSString*)name
{
    self = [super init];
    if (self) {
        _Name = name;
        _TypeOfAppliance = atUnimplemented;
    }
    return self;
}

-(NSString*) getDetailString
{
    NSAssert(false, @"Unimplemented getDetailString");
    return @"";
}

-(UIImage*) getDetailImage
{
    return nil;
}

-(BOOL) supportSwitch
{
    return FALSE;
}

@end
