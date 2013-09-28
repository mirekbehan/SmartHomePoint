//
//  AppliancesViewController_iPhone.m
//  SmartHomePoint
//
//  Created by Jarda on 9/22/13.
//  Copyright (c) 2013 Jaroslav Kutnar @ University Hradec Kralove. All rights reserved.
//

#import "AppliancesTableViewController.h"
#import "uhkAppDelegate.h"
#import "FilteredAppliancesTableViewController.h"

@interface AppliancesTableViewController ()
@property DataManager* DataManager;
@property NSMutableArray* CurrentTypesOfAppliances;
@end


@implementation AppliancesTableViewController


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

    _CurrentTypesOfAppliances = [NSMutableArray array];
    for (NSInteger i=0; i<[_DataManager getRegisteredApllianceTypesCount]; i++) {
        AppliancetType aType = [_DataManager getRegisteredApplianceTypeForIndex:i];
        BOOL found = false;
        for (Area* area in _DataManager.Areas) {
            if (found)
                break;
            for (Room* room in area.Rooms) {
                if (found)
                    break;
                for (Appliance* appliance in room.Appliances) {
                    if (appliance.TypeOfAppliance==aType) {
                        [_CurrentTypesOfAppliances addObject:[NSNumber numberWithInt:i]];
                        found = true;
                        break;
                    }
                }
            }
        }
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - Table view data source

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return NSLocalizedString(@"All appliances", nil);
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _CurrentTypesOfAppliances.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    int idx = [[_CurrentTypesOfAppliances objectAtIndex:indexPath.row] intValue];
    AppliancetType aType = [_DataManager getRegisteredApplianceTypeForIndex:idx];
   
    static NSString *CellIdentifier = @"appCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = [_DataManager getNameOfApplianceType:aType];
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    int idx = [[_CurrentTypesOfAppliances objectAtIndex:indexPath.row] intValue];
    AppliancetType aType = [_DataManager getRegisteredApplianceTypeForIndex:idx];
    
    UIViewController* controller = [segue destinationViewController];
    if ([controller isKindOfClass:[FilteredAppliancesTableViewController class]])
        [((FilteredAppliancesTableViewController*)controller) setApplianceType:aType];
}

@end
