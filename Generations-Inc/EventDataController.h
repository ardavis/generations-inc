//
//  EventDataController.h
//  Generations-Inc
//
//  Created by Andrew Davis on 8/8/12.
//  Copyright (c) 2012 Enginerds. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Event;

@interface EventDataController : NSObject

@property (nonatomic, copy) NSMutableArray *masterEventList;

- (NSUInteger)countOfList;
- (Event *)objectInListAtIndex:(NSUInteger)theIndex;
- (void)addEventWithName:(NSString *)inputName location:(NSString *)inputLocation desc:(NSString *)inputDesc date:(NSDate *)inputDate;

@end
