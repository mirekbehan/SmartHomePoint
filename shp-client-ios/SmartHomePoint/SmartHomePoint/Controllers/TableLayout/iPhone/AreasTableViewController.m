//
//  AreasTableViewController.m
//  SmartHomePoint
//
//  Created by Jarda on 9/27/13.
//  Copyright (c) 2013 Jaroslav Kutnar @ University Hradec Kralove. All rights reserved.
//

#import "AreasTableViewController.h"
#import "uhkAppDelegate.h"
#import "FilteredAppliancesTableViewController.h"

@interface AreasTableViewController ()
@property DataManager* DataManager;
@end

@implementation AreasTableViewController


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
    uhkAppDelegate* appDelegate = [[UIApplication sharedApplication] delegate];
    _DataManager = appDelegate.dataManager;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - Table view data source

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _DataManager.Areas.count;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    Area* area = [_DataManager.Areas objectAtIndex:section];
    return area.Name;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    Area* area = [_DataManager.Areas objectAtIndex:section];
    return area.Rooms.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"areaTableCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    Area* area = [_DataManager.Areas objectAtIndex:indexPath.section];
    Room* room = [area.Rooms objectAtIndex:indexPath.row];
    cell.textLabel.text = room.Name;
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    Area* area = [_DataManager.Areas objectAtIndex:indexPath.section];
    Room* room = [area.Rooms objectAtIndex:indexPath.row];
    
    UIViewController* controller = [segue destinationViewController];
    if ([controller isKindOfClass:[FilteredAppliancesTableViewController class]])
        [((FilteredAppliancesTableViewController*)controller) setRoom:room];
}


@end
