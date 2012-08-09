//
//  Event.h
//  Generations-Inc
//
//  Created by Andrew Davis on 8/8/12.
//  Copyright (c) 2012 Enginerds. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Event : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *location;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, strong) NSDate *date;

-(id)initWithName:(NSString *)name location:(NSString *)location desc:(NSString *)desc date:(NSDate *)date;

@end
