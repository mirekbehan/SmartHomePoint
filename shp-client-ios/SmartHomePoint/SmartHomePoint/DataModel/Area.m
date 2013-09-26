//
//  Area.m
//  SmartHomePoint
//
//  Created by Jarda on 9/24/13.
//  Copyright (c) 2013 Jaroslav Kutnar @ University Hradec Kralove. All rights reserved.
//

#import "Area.h"

@implementation Area

-(id)initWithName:(NSString*)name AndRooms:(NSArray *)rooms
{
    self = [super init];
    if (self) {
        _Name = name;
        _Rooms = rooms;
    }
    return self;
}

@end
