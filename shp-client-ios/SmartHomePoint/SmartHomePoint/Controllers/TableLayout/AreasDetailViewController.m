//
//  AreasDetailViewController.m
//  SmartHomePoint
//
//  Created by Jarda on 9/22/13.
//  Copyright (c) 2013 Jaroslav Kutnar @ University Hradec Kralove. All rights reserved.
//

#import "AreasDetailViewController.h"
#import "uhkAppDelegate.h"
#import "ApplianceDetailProtocol.h"

@interface AreasDetailViewController ()
@property Room* CurrentRoom;
@property DataManager* DataManager;
@property NSMutableArray* CurrentTypesOfAppliances;
@end

@implementation AreasDetailViewController

-(void)setRoom:(Room*)room
{
    uhkAppDelegate* appDelegate = [[UIApplication sharedApplication] delegate];
    _DataManager = appDelegate.dataManager;
    _CurrentRoom = room;
    _CurrentTypesOfAppliances = [NSMutableArray array];
    for (NSInteger i=0; i<[_DataManager getRegisteredApllianceTypesCount]; i++) {
        AppliancetType aType = [_DataManager getRegisteredApplianceTypeForIndex:i];
        for (Appliance* appliance in _CurrentRoom.Appliances) {
            if (appliance.TypeOfAppliance==aType) {
                [_CurrentTypesOfAppliances addObject:[NSNumber numberWithInt:i]];
                break;
            }
        }
    }
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.title = _CurrentRoom.Name;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _CurrentTypesOfAppliances.count;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    int idx = [[_CurrentTypesOfAppliances objectAtIndex:section] intValue];
    if ([_DataManager getRegisteredApllianceTypesCount]<=idx)
        return @"";
    AppliancetType aType = [_DataManager getRegisteredApplianceTypeForIndex:idx];
    return [_DataManager getNameOfApplianceType:aType];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int idx = [[_CurrentTypesOfAppliances objectAtIndex:section] intValue];
    if ([_DataManager getRegisteredApllianceTypesCount]<=idx) {
        NSAssert(false, @"RegisteredApllianceTypesCount out of bounds");
        return 0;
    }
    NSInteger cnt = 0;
    AppliancetType aType = [_DataManager getRegisteredApplianceTypeForIndex:idx];
    for (Appliance* appliance in _CurrentRoom.Appliances) {
        if (appliance.TypeOfAppliance == aType)
            cnt++;
    }
    return cnt;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier;
    int idx = [[_CurrentTypesOfAppliances objectAtIndex:indexPath.section] intValue];
    AppliancetType aType = [_DataManager getRegisteredApplianceTypeForIndex:idx];
    Appliance* currentAppliance = nil;
    NSInteger cnt = 0;
    for (Appliance* appliance in _CurrentRoom.Appliances) {
        if (appliance.TypeOfAppliance == aType) {
            if (cnt==indexPath.row) {
                currentAppliance = appliance;
                break;
            }
            cnt++;
        }
    }
    if (currentAppliance == nil) {
        NSAssert(false, @"Current appliance is nil");
        return nil;
    }
    switch (currentAppliance.TypeOfAppliance) {
        case atLight:
            if (((Light*)currentAppliance).TypeOfLight == ltSimple)
                CellIdentifier = @"lightSimpleCell";
            else
                CellIdentifier = @"lightCell";
            break;
        case atTemperature:
            CellIdentifier = @"tempCell";
            break;
        case atLouver:
            CellIdentifier = @"louverCell";
            break;
        case atIrrigation:
            CellIdentifier = @"louverCell";
            break;
        default:
            NSAssert(false, @"Appliance detail unimplemented");
            break;
    }

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = currentAppliance.Name;
    cell.detailTextLabel.text = [currentAppliance getDetailString];

    UISwitch* simpleSwitch = ((UISwitch *) [cell viewWithTag: 1]);
    if (simpleSwitch!=nil) {
        [simpleSwitch addTarget:self action:@selector(setSwitchState:) forControlEvents:UIControlEventValueChanged];
        [simpleSwitch setTag:100*indexPath.section+indexPath.row];
        switch (currentAppliance.TypeOfAppliance) {
            case atLight:
                if (((Light*)currentAppliance).TypeOfLight == ltSimple)
                    [simpleSwitch setOn:((Light*)currentAppliance).Enabled];
            default:
                break;
        }
    }
    return cell;
}

- (void)setSwitchState:(UISwitch*)sender
{
    NSInteger section = sender.tag/100;
    NSInteger row = sender.tag - (100*section);
    int idx = [[_CurrentTypesOfAppliances objectAtIndex:section] intValue];
    AppliancetType aType = [_DataManager getRegisteredApplianceTypeForIndex:idx];
    Appliance* currentAppliance = nil;
    NSInteger cnt = 0;
    for (Appliance* appliance in _CurrentRoom.Appliances) {
        if (appliance.TypeOfAppliance == aType) {
            if (cnt==row) {
                currentAppliance = appliance;
                break;
            }
            cnt++;
        }
    }
    if ([currentAppliance isKindOfClass:[Light class]])
        ((Light*)currentAppliance).Enabled = [sender isOn];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    int idx = [[_CurrentTypesOfAppliances objectAtIndex:indexPath.section] intValue];
    AppliancetType aType = [_DataManager getRegisteredApplianceTypeForIndex:idx];
    Appliance* currentAppliance = nil;
    NSInteger cnt = 0;
    for (Appliance* appliance in _CurrentRoom.Appliances) {
        if (appliance.TypeOfAppliance == aType) {
            if (cnt==indexPath.row) {
                currentAppliance = appliance;
                break;
            }
            cnt++;
        }
    }
    if (currentAppliance == nil) {
        NSAssert(false, @"Current appliance is nil");
        return;
    }
    
    UIViewController* controller = [segue destinationViewController];
    if ([controller conformsToProtocol:@protocol(ApplianceDetailProtocol)]) {
        UIViewController <ApplianceDetailProtocol> *dc = (UIViewController <ApplianceDetailProtocol> *) controller;
        [dc setAppliance:currentAppliance];
    }
}


@end
