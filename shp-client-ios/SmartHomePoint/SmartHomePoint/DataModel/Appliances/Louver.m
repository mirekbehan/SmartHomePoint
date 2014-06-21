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
@synthesize HideRatioInPercent = _HideRatioInPercent;

-(id)initWithName:(NSString*)name
{
    self = [super initWithName:name];
    if (self) {
        _TypeOfAppliance = atLouver;
        _HideRatioInPercent = [NSNumber numberWithInt:0];
    }
    return self;
}

-(id)initWithName:(NSString*)name AndHiddenRatio:(NSNumber*)hiddenRatio
{
    self = [super initWithName:name];
    if (self) {
        _TypeOfAppliance = atLouver;
        _HideRatioInPercent = hiddenRatio;
    }
    return self;
}


-(NSString*) getDetailString
{
    if (_HideRatioInPercent.intValue==0)
        return NSLocalizedString(@"LouverUp", nil);
    else if (_HideRatioInPercent.intValue==100)
        return NSLocalizedString(@"LouverDown", nil);
    return [NSString stringWithFormat:@"%d%%", _HideRatioInPercent.intValue];
}

- (void)setHideRatioInPercent:(NSNumber*)ratio
{
    if (ratio.intValue<0)
        _HideRatioInPercent = [NSNumber numberWithInt:0];
    else if (ratio.intValue>100)
        _HideRatioInPercent =  [NSNumber numberWithInt:100];
    _HideRatioInPercent = ratio;
}


-(NSNumber*)HideRatioInPercent
{
    return _HideRatioInPercent;
}


@end
