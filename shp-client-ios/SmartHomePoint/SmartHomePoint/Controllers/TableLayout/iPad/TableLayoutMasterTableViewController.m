//
//  TableLayoutMasterTableViewController.m
//  SmartHomePoint
//
//  Created by Jarda on 09/04/14.
//  Copyright (c) 2014 Jaroslav Kutnar @ University Hradec Kralove. All rights reserved.
//

#import "TableLayoutMasterTableViewController.h"
#import "uhkAppDelegate.h"
#import "FilteredAppliancesTableViewController.h"

@interface TableLayoutMasterTableViewController ()
@property DataManager* DataManager;
@property NSMutableArray* CurrentTypesOfAppliances;
@end



@implementation TableLayoutMasterTableViewController

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
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
        ApplianceType aType = [_DataManager getRegisteredApplianceTypeForIndex:i];
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
    
    NSIndexPath *p = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView selectRowAtIndexPath:p animated:FALSE scrollPosition:UITableViewScrollPositionTop];
    [self.splitViewController.view setNeedsDisplay];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _DataManager.Areas.count + 1;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section>=_DataManager.Areas.count)
        return NSLocalizedString(@"All appliances", nil);
    Area* area = [_DataManager.Areas objectAtIndex:section];
    return area.Name;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==_DataManager.Areas.count-1)
        return 50.0;
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc] init];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section>=_DataManager.Areas.count)
        return _CurrentTypesOfAppliances.count;
    Area* area = [_DataManager.Areas objectAtIndex:section];
    return area.Rooms.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier =  @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (indexPath.section<_DataManager.Areas.count)
    {
        Area* area = [_DataManager.Areas objectAtIndex:indexPath.section];
        Room* room = [area.Rooms objectAtIndex:indexPath.row];
        cell.textLabel.text = room.Name;
    }
    else
    {
        int idx = [[_CurrentTypesOfAppliances objectAtIndex:indexPath.row] intValue];
        ApplianceType aType = [_DataManager getRegisteredApplianceTypeForIndex:idx];
        cell.textLabel.text = [_DataManager getNameOfApplianceType:aType];
    }
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id<TableLayoutMasterDetailProtocol> dvc = (FilteredAppliancesTableViewController*)self.splitViewController.delegate;
    if (dvc==nil) {
        NSAssert(false, @"TableLayoutMasterDetailProtocol is nill");
        return;
    }
    if (indexPath.section<_DataManager.Areas.count)
    {
        Area* area = [_DataManager.Areas objectAtIndex:indexPath.section];
        Room* room = [area.Rooms objectAtIndex:indexPath.row];
        [dvc didSelectRoom:room];
    }
    else
    {
        int idx = [[_CurrentTypesOfAppliances objectAtIndex:indexPath.row] intValue];
        ApplianceType aType = [_DataManager getRegisteredApplianceTypeForIndex:idx];
        [dvc didSelectAppliance:aType];
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end
