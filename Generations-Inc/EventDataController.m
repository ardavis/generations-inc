//
//  EventDataController.m
//  Generations-Inc
//
//  Created by Andrew Davis on 8/8/12.
//  Copyright (c) 2012 Enginerds. All rights reserved.
//

#import "EventDataController.h"
#import "Event.h"

@interface EventDataController ()
- (void)initializeDefaultDataList;
@end

@implementation EventDataController

@synthesize masterEventList = _masterEventList;

- (id)init {
    if (self = [super init]) {
        [self initializeDefaultDataList];
        return self;
    }
    return nil;
}

- (void)initializeDefaultDataList {
    
    NSMutableArray *eventList = [[NSMutableArray alloc] init];
    self.masterEventList = eventList;
}

- (void)setMasterEventList:(NSMutableArray *)newList {
    if (_masterEventList != newList) {
        _masterEventList = [newList mutableCopy];
    }
}

- (NSUInteger)countOfList {
    return [self.masterEventList count];
}

- (Event *)objectInListAtIndex:(NSUInteger)theIndex {
    return [self.masterEventList objectAtIndex:theIndex];
}

- (void)addEventWithName:(NSString *)inputName location:(NSString *)inputLocation desc:(NSString *)inputDesc date:(NSDate *)inputDate
{
    Event *event;
    event = [[Event alloc] initWithName:inputName location:inputLocation desc:inputDesc date:inputDate];
    [self.masterEventList addObject:event];
}

- (void)removeEvent:(Event *)eventToBeRemoved
{
    [self.masterEventList removeObject:eventToBeRemoved];
}

@end
