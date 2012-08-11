//
//  EventsMasterViewController.h
//  Generations-Inc
//
//  Created by Andrew Davis on 8/9/12.
//  Copyright (c) 2012 Enginerds. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventCell.h"

@class EventDataController;

@interface EventsMasterViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
	IBOutlet UITableView *eventsTableView;
}

@property (strong, nonatomic) IBOutlet UITableView *eventsTableView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *navControl;
@property (strong, nonatomic) EventDataController *myEventsDataController;
@property (strong, nonatomic) EventDataController *upcomingEventsDataController;
@property (strong, nonatomic) EventDataController *bookmarkedEventsDataController;

- (IBAction)segmentSelected:(UISegmentedControl *)sender;
@end
