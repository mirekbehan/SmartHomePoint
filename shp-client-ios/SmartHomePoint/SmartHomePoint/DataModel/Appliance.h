//
//  Appliance.h
//  SmartHomePoint
//
//  Created by Jarda on 9/24/13.
//  Copyright (c) 2013 Jaroslav Kutnar @ University Hradec Kralove. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Room.h"


@interface Appliance : NSObject

    typedef enum {
        atUnimplemented, atLight, atTemperature, atLouver, atIrrigation
    } ApplianceType;

-(id)initWithName:(NSString*)name;

-(NSString*) getDetailString;
-(UIImage*) getDetailImage;
-(BOOL) supportSwitch;

@property (readonly) ApplianceType TypeOfAppliance;
@property (readonly) NSString* Name;

@end
