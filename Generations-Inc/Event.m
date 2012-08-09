//
//  Event.m
//  Generations-Inc
//
//  Created by Andrew Davis on 8/8/12.
//  Copyright (c) 2012 Enginerds. All rights reserved.
//

#import "Event.h"

@implementation Event

@synthesize name = _name, location = _location, desc = _desc, date = _date;

-(id)initWithName:(NSString *)name location:(NSString *)location desc:(NSString *)desc date:(NSDate *)date
{
    
    self = [super init];
    if (self) {
        _name = name;
        _location = location;
        _desc = desc;
        _date = date;
        return self;
    }
    return nil;
    
}

@end
