//
//  Louver.h
//  SmartHomePoint
//
//  Created by Jarda on 9/24/13.
//  Copyright (c) 2013 Jaroslav Kutnar @ University Hradec Kralove. All rights reserved.
//

#import "Appliance.h"

@interface Louver : Appliance
@property NSNumber* HideRatioInPercent;

-(id)initWithName:(NSString*)name AndHiddenRatio:(NSNumber*)hiddenRatio;
@end
