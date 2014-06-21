//
//  FilteredAppliancesTableViewController.m
//  SmartHomePoint
//
//  Created by Jarda on 9/27/13.
//  Copyright (c) 2013 Jaroslav Kutnar @ University Hradec Kralove. All rights reserved.
//

#import "FilteredAppliancesTableViewController.h"
#import "uhkAppDelegate.h"
#import "ApplianceDetailProtocol.h"

@interface FilteredAppliancesTableViewController () <UITableViewDelegate, UITableViewDataSource>
@property DataManager* DataManager;

//filter by room
@property Room* CurrentRoom;
@property NSMutableArray* CurrentTypesOfAppliances;
//filter by appliance
@property ApplianceType CurrentApplianceType;
@property NSMutableArray* RoomsForView;
@end

@implementation FilteredAppliancesTableViewController


-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    uhkAppDelegate* appDelegate = [[UIApplication sharedApplication] delegate];
    _DataManager = appDelegate.dataManager;
    
    if (_CurrentApplianceType==atUnimplemented) {
        _CurrentTypesOfAppliances = [NSMutableArray array];
        for (NSInteger i=0; i<[_DataManager getRegisteredApllianceTypesCount]; i++) {
            ApplianceType aType = [_DataManager getRegisteredApplianceTypeForIndex:i];
            for (Appliance* appliance in _CurrentRoom.Appliances) {
                if (appliance.TypeOfAppliance==aType) {
                    [_CurrentTypesOfAppliances addObject:[NSNumber numberWithInt:(int)i]];
                    break;
                }
            }
        }
    } else {
        _RoomsForView = [NSMutableArray array];
        for (Area* area in _DataManager.Areas) {
            for (Room* room in area.Rooms) {
                for (Appliance* appliance in room.Appliances) {
                    if (appliance.TypeOfAppliance==_CurrentApplianceType) {
                        [_RoomsForView addObject:room];
                        break;
                    }
                }
            }
        }
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (_CurrentApplianceType==atUnimplemented)
        self.navigationItem.title = _CurrentRoom.Name;
    else
        self.navigationItem.title = [_DataManager getNameOfApplianceType:_CurrentApplianceType];

    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_CurrentApplianceType==atUnimplemented)
        return _CurrentTypesOfAppliances.count;
    // filter by appliance type
    return _RoomsForView.count;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (_CurrentApplianceType==atUnimplemented) {
        int idx = [[_CurrentTypesOfAppliances objectAtIndex:section] intValue];
        if ([_DataManager getRegisteredApllianceTypesCount]<=idx)
            return @"";
        ApplianceType aType = [_DataManager getRegisteredApplianceTypeForIndex:idx];
        return [_DataManager getNameOfApplianceType:aType];
    }
    // filter by appliance type
    Room* room = (Room*)[_RoomsForView objectAtIndex:section];
    return room.Name;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_CurrentApplianceType == atUnimplemented) {
        int idx = [[_CurrentTypesOfAppliances objectAtIndex:section] intValue];
        if ([_DataManager getRegisteredApllianceTypesCount]<=idx) {
            NSLog(@"RegisteredApllianceTypesCount out of bounds");
            return 0;
        }
        NSInteger cnt = 0;
        ApplianceType aType = [_DataManager getRegisteredApplianceTypeForIndex:idx];
        for (Appliance* appliance in _CurrentRoom.Appliances) {
            if (appliance.TypeOfAppliance == aType)
                cnt++;
        }
        return cnt;
    }
    // filter by appliance type
    NSInteger cnt = 0;
    Room* room = (Room*)[_RoomsForView objectAtIndex:section];
    for (Appliance* appliance in room.Appliances) {
        if (appliance.TypeOfAppliance==_CurrentApplianceType)
            cnt++;
    }
    return cnt;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier;
    Appliance* currentAppliance = [self getApplianceForSection:indexPath.section AndRow:indexPath.row];

    switch (currentAppliance.TypeOfAppliance) {
        case atLight:
            if (((Light*)currentAppliance).TypeOfLight == ltSimple)
                CellIdentifier = @"lightSimpleCell";
            else
                CellIdentifier = @"lightCell";
            break;
        case atTemperature:
            if (((Temperature*)currentAppliance).TypeOfThermo == ttSensor)
                CellIdentifier = @"thermosensorCell";
            else
                CellIdentifier = @"thermostatCell";
            break;
        case atLouver:
            CellIdentifier = @"louverCell";
            break;
        case atIrrigation:
            CellIdentifier = @"irrigationCell";
            break;
        case atDoorLock:
            CellIdentifier = @"lightSimpleCell"; // same gui
            break;
        case atSecurity:
            CellIdentifier = @"lightSimpleCell"; // same gui
            break;
        case atCamera:
            CellIdentifier = @"cameraCell";
            break;
        default:
            NSLog(@"Appliance detail unimplemented");
            break;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.textLabel.font = [UIFont systemFontOfSize:17.0];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = currentAppliance.Name;
    cell.detailTextLabel.text = [currentAppliance getDetailString];

    UIImageView* detailImageView = (UIImageView *)[cell viewWithTag:2];
    if (detailImageView) {
        detailImageView.image = [currentAppliance getDetailImage];
        switch (currentAppliance.TypeOfAppliance) {
            case atLight:
            {//!TODO - create colored image
                Light* light = (Light*)currentAppliance;
                if (light.TypeOfLight == ltSimple)
                    break;
                if (light.Dim.doubleValue==0.0)
                    detailImageView.backgroundColor = [UIColor clearColor];
                else
                    detailImageView.backgroundColor = light.Color;
                break;
            }
            default:
                break;
        }
    }

    if ([currentAppliance supportSwitch]) {
        UISwitch* simpleSwitch = ((UISwitch *) [cell viewWithTag: 1]);
        if (simpleSwitch!=nil) {
            [simpleSwitch addTarget:self action:@selector(setSwitchState:) forControlEvents:UIControlEventValueChanged];
            [simpleSwitch setTag:100*indexPath.section+indexPath.row];
            switch (currentAppliance.TypeOfAppliance) {
                case atLight:
                    if (((Light*)currentAppliance).TypeOfLight == ltSimple)
                        [simpleSwitch setOn:((Light*)currentAppliance).Enabled];
                    break;
                case atDoorLock:
                    [simpleSwitch setOn:((Lock*)currentAppliance).Locked];
                    break;
                default:
                    break;
            }
        }
    }
    return cell;
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController* controller = [segue destinationViewController];
    if (! [controller conformsToProtocol:@protocol(ApplianceDetailProtocol)])
        return;
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    UIViewController <ApplianceDetailProtocol> *dc = (UIViewController <ApplianceDetailProtocol> *) controller;
    [dc setAppliance:[self getApplianceForSection:indexPath.section AndRow:indexPath.row]];
}



#pragma mark - local

- (void)setSwitchState:(UISwitch*)sender
{
    NSInteger section = sender.tag/100;
    NSInteger row = sender.tag - (100*section);
    Appliance* currentAppliance = [self getApplianceForSection:section AndRow:row];
    
    if ([currentAppliance isKindOfClass:[Light class]])
        ((Light*)currentAppliance).Enabled = [sender isOn];
}


-(Appliance*) getApplianceForSection:(NSInteger)section AndRow:(NSInteger)row
{
    if (_CurrentApplianceType==atUnimplemented) {
        int idx = [[_CurrentTypesOfAppliances objectAtIndex:section] intValue];
        ApplianceType aType = [_DataManager getRegisteredApplianceTypeForIndex:idx];
        NSInteger cnt = 0;
        for (Appliance* appliance in _CurrentRoom.Appliances) {
            if (appliance.TypeOfAppliance == aType) {
                if (cnt==row)
                    return appliance;
                cnt++;
            }
        }
    }
    
    NSInteger cnt = 0;
    Room* room = (Room*)[_RoomsForView objectAtIndex:section];
    for (Appliance* appliance in room.Appliances) {
        if (appliance.TypeOfAppliance==_CurrentApplianceType) {
            if (cnt==row)
                return appliance;
            cnt++;
        }
    }

    NSLog(@"Current appliance is nil");
    return nil;
}




#pragma mark - TableLayoutMasterDetailProtocol


-(void) didSelectRoom:(Room *) room
{
    _CurrentApplianceType=atUnimplemented;
    _CurrentRoom = room;
    
    _CurrentTypesOfAppliances = [NSMutableArray array];
    for (NSInteger i=0; i<[_DataManager getRegisteredApllianceTypesCount]; i++) {
        ApplianceType aType = [_DataManager getRegisteredApplianceTypeForIndex:i];
        for (Appliance* appliance in _CurrentRoom.Appliances) {
            if (appliance.TypeOfAppliance==aType) {
                [_CurrentTypesOfAppliances addObject:[NSNumber numberWithInt:(int)i]];
                break;
            }
        }
    }
    
    self.navigationItem.title = _CurrentRoom.Name;
    [self.tableView reloadData];
}


-(void) didSelectAppliance:(ApplianceType) typeOfAppliance
{
    _CurrentApplianceType=typeOfAppliance;
    _CurrentRoom = nil;
    _RoomsForView = [NSMutableArray array];
    for (Area* area in _DataManager.Areas) {
        for (Room* room in area.Rooms) {
            for (Appliance* appliance in room.Appliances) {
                if (appliance.TypeOfAppliance==_CurrentApplianceType) {
                    [_RoomsForView addObject:room];
                    break;
                }
            }
        }
    }
    
    self.navigationItem.title = [_DataManager getNameOfApplianceType:_CurrentApplianceType];
    [self.tableView reloadData];
}


@end
