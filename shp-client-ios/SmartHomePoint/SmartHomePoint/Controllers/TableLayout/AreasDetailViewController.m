//
//  AreasDetailViewController.m
//  SmartHomePoint
//
//  Created by Jarda on 9/22/13.
//  Copyright (c) 2013 Jaroslav Kutnar @ University Hradec Kralove. All rights reserved.
//

#import "AreasDetailViewController.h"

@interface AreasDetailViewController ()

@end

@implementation AreasDetailViewController

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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0)
        return 3;
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier;
    switch (indexPath.section) {
        case 0:
        {
            if (indexPath.row<2)
                CellIdentifier = @"lightCell";
            else
                CellIdentifier = @"lightSimpleCell";
            break;
        }
        case 1:
            CellIdentifier = @"tempCell";
            break;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = @"Light 1";
                    cell.detailTextLabel.text = @"ON";
                    break;
                case 1:
                    cell.textLabel.text = @"Light 2";
                    cell.detailTextLabel.text = @"OFF";
                    break;
                case 2:
                    cell.textLabel.text = @"Light simple";
                    cell.textLabel.backgroundColor = [UIColor clearColor];
                    break;
                default:
                    break;
            }
            break;
        }
        case 1:
        {
            cell.textLabel.text = @"Temperature";
            cell.detailTextLabel.text = @"20°C";
            break;
        }
        default:
            break;
    }
    return cell;
}
/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
