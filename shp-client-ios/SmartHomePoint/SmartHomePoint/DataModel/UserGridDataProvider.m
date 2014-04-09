//
//  UserGridDataProvider.m
//  SmartHomePoint
//
//  Created by Jarda on 10/2/13.
//  Copyright (c) 2013 Jaroslav Kutnar @ University Hradec Kralove. All rights reserved.
//

#import "UserGridDataProvider.h"
//#import "UGClient.h"


@interface UserGridDataProvider()
//@property UGClient *UsergridClient;
//@property UGUser *User;
@end


@implementation UserGridDataProvider


-(id)init
{
    self = [super init];
    if (self) {
 /*       _UsergridClient = [[UGClient alloc]initWithOrganizationId: @"jku" withApplicationID: @"sandbox" baseURL:@"https://api.usergrid.com"];
        
        [_UsergridClient setLogging:true];

        _User = [_UsergridClient getLoggedInUser];
        if (_User.username)
            return self;
        else
            return self;*/
    }
    return self;
}



@end
