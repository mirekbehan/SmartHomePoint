//
//  Area.h
//  SmartHomePoint
//
//  Created by Jarda on 9/24/13.
//  Copyright (c) 2013 Jaroslav Kutnar @ University Hradec Kralove. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Area : NSObject

@property (readonly) NSString* Name;
@property (readonly) NSArray* Rooms;

-(id)initWithName:(NSString*)name AndRooms:(NSArray*)rooms;

@end
