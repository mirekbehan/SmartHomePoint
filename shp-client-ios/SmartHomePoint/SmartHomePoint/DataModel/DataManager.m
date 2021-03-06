//
//  DataManager.m
//  SmartHomePoint
//
//  Created by Jarda on 9/24/13.
//  Copyright (c) 2013 Jaroslav Kutnar @ University Hradec Kralove. All rights reserved.
//

#import "DataManager.h"
#import "Area.h"
#import "Room.h"
#import "Appliance.h"
#import "AppliancesInclude.h"

@interface DataManager()
@property NSArray* AppliancesToDo;
@end



@implementation DataManager

-(id)init
{
    self = [super init];
    if (self) {
        [self retreiveAppliancesFromServer];
    }
    return self;
}

-(void)retreiveAppliancesFromServer
{
    NSMutableArray* areas = [NSMutableArray array];
    //GENERAL
    {
        NSMutableArray* rooms = [NSMutableArray array];
        {
            NSMutableArray* app = [NSMutableArray array];
            Lock* l1 = [[Lock alloc] initWithName:@"Main door" AndState:FALSE];
            [app addObject:l1];
            Security* s1 = [[Security alloc] initWithName:@"House alarm" AndState:FALSE];
            [app addObject:s1];
            [rooms addObject:[[Room alloc]initWithName:@"Inside" AndAppliances:[NSArray arrayWithArray:app]]];
        }
        {
            NSMutableArray* app = [NSMutableArray array];
            Lock* l1 = [[Lock alloc] initWithName:@"Main gate" AndState:TRUE];
            [app addObject:l1];
            Lock* l2 = [[Lock alloc] initWithName:@"Garage" AndState:FALSE];
            [app addObject:l2];
            Camera* c1 = [[Camera alloc] initWithName:@"Entrance"];
            [app addObject:c1];
            [rooms addObject:[[Room alloc]initWithName:@"Outside" AndAppliances:[NSArray arrayWithArray:app]]];
        }
        
        [areas addObject:[[Area alloc] initWithName:@"General" AndRooms:[NSArray arrayWithArray:rooms]]];
    }
    //FIRST FLOOR
    {
        NSMutableArray* rooms = [NSMutableArray array];
        {// Kitchen
            NSMutableArray* app = [NSMutableArray array];
            Light* l1 = [[Light alloc] initWithName:@"Main" andType:ltDimmed];
            l1.Dim = [NSNumber numberWithFloat:0.3];
            l1.Color = [UIColor redColor];
            [app addObject:l1];
            Light* l2 = [[Light alloc] initWithName:@"Spotlights" andType:ltSimple];
            l2.Enabled = true;
            [app addObject:l2];
            Light* l3 = [[Light alloc] initWithName:@"Dining table" andType:ltDimmed];
            l3.Dim = [NSNumber numberWithFloat:0.0];
            l3.Color = [UIColor blueColor];
            [app addObject:l3];
            Temperature* t1 = [[Temperature alloc] initWithName:@"Thermostat" Type:ttThermostat AndTemperatureInCelsius:[NSNumber numberWithFloat:22.1]];
            t1.DefinedTemperatureInCelsius = [NSNumber numberWithFloat:23.3];
            [app addObject:t1];
            Louver* lo1 = [[Louver alloc] initWithName:@"Louver south" AndHiddenRatio:[NSNumber numberWithInt:0]];
            [app addObject:lo1];
            Louver* lo2 = [[Louver alloc] initWithName:@"Louver east 1" AndHiddenRatio:[NSNumber numberWithInt:50]];
            [app addObject:lo2];
            Louver* lo3 = [[Louver alloc] initWithName:@"Louver east 2" AndHiddenRatio:[NSNumber numberWithInt:100]];
            [app addObject:lo3];
            [rooms addObject:[[Room alloc]initWithName:@"Kitchen" AndAppliances:[NSArray arrayWithArray:app]]];
        }
        {// WorkRoom
            NSMutableArray* app = [NSMutableArray array];
            Light* l1 = [[Light alloc] initWithName:@"Main" andType:ltDimmed];
            l1.Dim = [NSNumber numberWithFloat:1.0];
            l1.Color = [UIColor greenColor];
            [app addObject:l1];
            Temperature* t1 = [[Temperature alloc] initWithName:@"Thermostat" Type:ttThermostat AndTemperatureInCelsius:[NSNumber numberWithFloat:23.4]];
            t1.DefinedTemperatureInCelsius = [NSNumber numberWithFloat:3.0];
            [app addObject:t1];
            //Louver* lo1 = [[Louver alloc] initWithName:@"Louver"];
            //[app addObject:lo1];
            [rooms addObject:[[Room alloc]initWithName:@"Workroom" AndAppliances:[NSArray arrayWithArray:app]]];
        }
        {// Bedroom
            NSMutableArray* app = [NSMutableArray array];
            Light* l1 = [[Light alloc] initWithName:@"Main" andType:ltDimmed];
            l1.Dim = [NSNumber numberWithFloat:0.0];
            l1.Color = [UIColor yellowColor];
            [app addObject:l1];
            Temperature* t1 = [[Temperature alloc] initWithName:@"Thermostat" Type:ttThermostat AndTemperatureInCelsius:[NSNumber numberWithFloat:19.7]];
            t1.DefinedTemperatureInCelsius = [NSNumber numberWithFloat:20.1];
            [app addObject:t1];
            //Louver* lo1 = [[Louver alloc] initWithName:@"Louver"];
            //[app addObject:lo1];
            [rooms addObject:[[Room alloc]initWithName:@"Bedroom" AndAppliances:[NSArray arrayWithArray:app]]];
        }
        {// BathRoom
            NSMutableArray* app = [NSMutableArray array];
            Light* l1 = [[Light alloc] initWithName:@"Main" andType:ltDimmed];
            l1.Dim = [NSNumber numberWithFloat:0.0];
            l1.Color = [UIColor whiteColor];
            [app addObject:l1];
            Temperature* t1 = [[Temperature alloc] initWithName:@"Thermostat" Type:ttThermostat AndTemperatureInCelsius:[NSNumber numberWithFloat:22.7]];
            t1.DefinedTemperatureInCelsius = [NSNumber numberWithFloat:23.8];
            [app addObject:t1];
            //Louver* lo1 = [[Louver alloc] initWithName:@"Louver"];
            //[app addObject:lo1];
            [rooms addObject:[[Room alloc]initWithName:@"Bathroom" AndAppliances:[NSArray arrayWithArray:app]]];
        }
        
        [areas addObject:[[Area alloc] initWithName:@"1. floor" AndRooms:[NSArray arrayWithArray:rooms]]];
    }
    //SECOND FLOOR
    {
        NSMutableArray* rooms = [NSMutableArray array];
        {// Child room 1
            NSMutableArray* app = [NSMutableArray array];
            Light* l1 = [[Light alloc] initWithName:@"Main" andType:ltDimmed];
            l1.Dim = [NSNumber numberWithFloat:1.0];
            l1.Color = [UIColor magentaColor];
            [app addObject:l1];
            Temperature* t1 = [[Temperature alloc] initWithName:@"Thermostat" Type:ttThermostat AndTemperatureInCelsius:[NSNumber numberWithFloat:21.5]];
            t1.DefinedTemperatureInCelsius = [NSNumber numberWithFloat:21.5];
            [app addObject:t1];
            //Louver* lo1 = [[Louver alloc] initWithName:@"Louver"];
            //[app addObject:lo1];
            [rooms addObject:[[Room alloc]initWithName:@"Child room 1" AndAppliances:[NSArray arrayWithArray:app]]];
        }
        {// Child room 2
            NSMutableArray* app = [NSMutableArray array];
            Light* l1 = [[Light alloc] initWithName:@"Main" andType:ltDimmed];
            l1.Dim = [NSNumber numberWithFloat:0.0];
            l1.Color = [UIColor cyanColor];
            [app addObject:l1];
            Temperature* t1 = [[Temperature alloc] initWithName:@"Thermostat" Type:ttThermostat AndTemperatureInCelsius:[NSNumber numberWithFloat:16.5]];
            t1.DefinedTemperatureInCelsius = [NSNumber numberWithFloat:20.0];
            [app addObject:t1];
            //Louver* lo1 = [[Louver alloc] initWithName:@"Louver"];
            //[app addObject:lo1];
            [rooms addObject:[[Room alloc]initWithName:@"Child room 2" AndAppliances:[NSArray arrayWithArray:app]]];
        }
        
        [areas addObject:[[Area alloc] initWithName:@"2. floor" AndRooms:[NSArray arrayWithArray:rooms]]];
    }
    //GARDEN
    {
        NSMutableArray* rooms = [NSMutableArray array];
        {// Garden 1
            NSMutableArray* app = [NSMutableArray array];
            Irrigation* i1 = [[Irrigation alloc] initWithName:@"Irrigation"];
            [app addObject:i1];
            Temperature* t1 = [[Temperature alloc] initWithName:@"Outside sensor" Type:ttSensor AndTemperatureInCelsius:[NSNumber numberWithFloat:12.0]];
            t1.DefinedTemperatureInCelsius = [NSNumber numberWithFloat:-3.0];
            [app addObject:t1];
            Temperature* t2 = [[Temperature alloc] initWithName:@"Greenhouse sensor" Type:ttSensor AndTemperatureInCelsius:[NSNumber numberWithFloat:17.9]];
            t2.DefinedTemperatureInCelsius = [NSNumber numberWithFloat:12.0];
            [app addObject:t2];
            [rooms addObject:[[Room alloc]initWithName:@"Garden" AndAppliances:[NSArray arrayWithArray:app]]];
        }
        
        [areas addObject:[[Area alloc] initWithName:@"Garden" AndRooms:[NSArray arrayWithArray:rooms]]];
    }
    
    _Areas = [NSArray arrayWithArray:areas];
}

-(void)updateAppliancesToServer:(NSArray*)appliances
{
    // send changed values
}


-(void)setAppliancesForNextView:(NSArray*)appliances
{
    _AppliancesToDo = appliances;
}

-(NSArray*)getAppliancesForThisView
{
    return _AppliancesToDo;
}

-(ApplianceType) getRegisteredApplianceTypeForIndex:(NSInteger)index
{
    switch (index) {
        case 0:
            return atTemperature;
        case 1:
            return atLight;
        case 2:
            return atLouver;
        case 3:
            return atIrrigation;
        case 4:
            return atDoorLock;
        case 5:
            return atSecurity;
        case 6:
            return atCamera;
        default:
            return atUnimplemented;
    }
}

-(NSInteger) getRegisteredApllianceTypesCount
{
    if ([self getRegisteredApplianceTypeForIndex:6]==atUnimplemented ||
        [self getRegisteredApplianceTypeForIndex:7]!=atUnimplemented)
        NSLog(@"Bad count");
    return 7;
}

-(NSString*) getNameOfApplianceType:(ApplianceType)type
{
    switch (type) {
        case atTemperature:
            return NSLocalizedString(@"Temperature", nil);;
        case atLight:
            return NSLocalizedString(@"Lights", nil);;
        case atLouver:
            return NSLocalizedString(@"Louvers", nil);;
        case atIrrigation:
            return NSLocalizedString(@"Irrigation", nil);;
        case atDoorLock:
            return NSLocalizedString(@"Locks", nil);;
        case atSecurity:
            return NSLocalizedString(@"Alarms", nil);;
        case atCamera:
            return NSLocalizedString(@"Cameras", nil);;
        default:
            return @"";
    }
    
}

@end
