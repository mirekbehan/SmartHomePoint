//
//  Camera.m
//  SmartHomePoint
//
//  Created by Jarda on 21/06/14.
//  Copyright (c) 2014 Jaroslav Kutnar @ University Hradec Kralove. All rights reserved.
//

#import "Camera.h"

@implementation Camera
@synthesize TypeOfAppliance = _TypeOfAppliance;


-(id)initWithName:(NSString *)name
{
    self = [super initWithName:name];
    if (self) {
        _TypeOfAppliance = atCamera;
    }
    return self;
}


-(NSString*) getDetailString
{
    return @"";
}

-(UIImage*) getDetailImage
{
    return nil;
}

-(BOOL) supportSwitch
{
    return false;
}

@end
