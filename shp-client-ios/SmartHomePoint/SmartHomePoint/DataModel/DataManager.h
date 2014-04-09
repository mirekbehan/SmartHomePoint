//
//  DataManager.h
//  SmartHomePoint
//
//  Created by Jarda on 9/24/13.
//  Copyright (c) 2013 Jaroslav Kutnar @ University Hradec Kralove. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Appliances/AppliancesInclude.h"
#import "Room.h"
#import "Area.h"

@interface DataManager : NSObject

@property (readonly) NSArray* Areas;

-(id)init;

-(void)retreiveAppliancesFromServer;
-(void)updateAppliancesToServer:(NSArray*)appliances;

-(void)setAppliancesForNextView:(NSArray*)appliances;
-(NSArray*)getAppliancesForThisView;

-(ApplianceType) getRegisteredApplianceTypeForIndex:(NSInteger)index;
-(NSInteger) getRegisteredApllianceTypesCount;
-(NSString*) getNameOfApplianceType:(ApplianceType)type;
@end
