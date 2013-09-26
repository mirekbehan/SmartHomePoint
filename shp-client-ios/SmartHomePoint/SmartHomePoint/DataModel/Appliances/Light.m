//
//  Light.m
//  SmartHomePoint
//
//  Created by Jarda on 9/24/13.
//  Copyright (c) 2013 Jaroslav Kutnar @ University Hradec Kralove. All rights reserved.
//

#import "Light.h"


@implementation Light
@synthesize TypeOfAppliance = _TypeOfAppliance;
@synthesize Dim = _Dim;


-(id)initWithName:(NSString*)name andType:(LightType)lightType
{
    self = [super initWithName:name];
    if (self) {
        _TypeOfLight = lightType;
        _TypeOfAppliance = atLight;
    }
    return self;
}

- (void)setDim:(NSNumber*)dim
{
    if (dim.floatValue>1.0)
        _Dim = [NSNumber numberWithFloat:1.0];
    else if (dim.floatValue<0.0)
        _Dim = [NSNumber numberWithFloat:0.0];
    else
        _Dim = dim;
}

-(NSNumber*)Dim
{
    return _Dim;
}

-(NSString*) getDetailString
{
    if (_TypeOfLight==ltSimple)
        return @"";
    if (_Dim.doubleValue==0.0)
        return NSLocalizedString(@"OFF", nil);
    return [NSString stringWithFormat:@"%ld%%",lroundf(_Dim.floatValue*100)];
}


@end
