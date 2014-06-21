//
//  Lock.h
//  SmartHomePoint
//
//  Created by Jarda on 21/06/14.
//  Copyright (c) 2014 Jaroslav Kutnar @ University Hradec Kralove. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Appliance.h"

@interface Lock : Appliance

@property BOOL Locked;

-(id)initWithName:(NSString*)name AndState:(BOOL)locked;

@end
