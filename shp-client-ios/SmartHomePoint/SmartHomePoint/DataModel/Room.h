//
//  Room.h
//  SmartHomePoint
//
//  Created by Jarda on 9/24/13.
//  Copyright (c) 2013 Jaroslav Kutnar @ University Hradec Kralove. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Appliance.h"

@interface Room : NSObject

@property (readonly) NSString* Name;
@property (readonly) NSArray* Appliances;

-(id)initWithName:(NSString*)name AndAppliances:(NSArray*)appliances;

@end
