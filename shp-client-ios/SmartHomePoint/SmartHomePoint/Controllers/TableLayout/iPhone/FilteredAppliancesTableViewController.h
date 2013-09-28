//
//  FilteredAppliancesTableViewController.h
//  SmartHomePoint
//
//  Created by Jarda on 9/27/13.
//  Copyright (c) 2013 Jaroslav Kutnar @ University Hradec Kralove. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Room.h"

@interface FilteredAppliancesTableViewController : UITableViewController

-(void)setRoom:(Room*)room;
-(void)setApplianceType:(AppliancetType)type;

@end
