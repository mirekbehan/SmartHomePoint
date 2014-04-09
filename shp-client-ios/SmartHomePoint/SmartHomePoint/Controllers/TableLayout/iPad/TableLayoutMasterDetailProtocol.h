//
//  TableLayoutMasterDetailProtocol.h
//  SmartHomePoint
//
//  Created by Jarda on 09/04/14.
//  Copyright (c) 2014 Jaroslav Kutnar @ University Hradec Kralove. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Room.h"
#import "Appliance.h"

@protocol TableLayoutMasterDetailProtocol <NSObject>

-(void) didSelectRoom:(Room *) room;
-(void) didSelectAppliance:(ApplianceType) typeOfAppliance;

@end
