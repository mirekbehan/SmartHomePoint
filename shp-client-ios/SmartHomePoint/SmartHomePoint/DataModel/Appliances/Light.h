//
//  Light.h
//  SmartHomePoint
//
//  Created by Jarda on 9/24/13.
//  Copyright (c) 2013 Jaroslav Kutnar @ University Hradec Kralove. All rights reserved.
//

#import "Appliance.h"

@interface Light : Appliance

typedef enum LightType {
    ltSimple, ltDimmed
} LightType;

@property  (readonly) LightType TypeOfLight;
@property BOOL Enabled;
@property NSNumber* Dim;
@property UIColor* Color;

-(id)initWithName:(NSString*)name andType:(LightType)lightType;

@end
