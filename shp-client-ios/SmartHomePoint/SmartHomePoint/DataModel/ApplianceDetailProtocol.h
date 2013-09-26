//
//  ApplianceDetailProtocol.h
//  SmartHomePoint
//
//  Created by Jarda on 9/26/13.
//  Copyright (c) 2013 Jaroslav Kutnar @ University Hradec Kralove. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Appliance.h"

@protocol ApplianceDetailProtocol <NSObject>

-(void)setAppliance:(Appliance*)appliance;

@end
